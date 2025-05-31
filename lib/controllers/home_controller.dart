import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:encrypt_decrypt_app/constants/string_constants.dart';
import 'package:encrypt_decrypt_app/controllers/saved_texts_controller.dart';
import 'package:encrypt_decrypt_app/models/save_text_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:share/share.dart';

import '../components/custom_button.dart';
import '../components/custom_popup.dart';
import '../pbkdf2.dart';

class HomeController extends GetxController {
  final SavedTextsController savedTextsController =
      Get.find<SavedTextsController>(tag: savedTextsControllerTag);

  TextEditingController textController = TextEditingController();
  TextEditingController passController = TextEditingController();

  GlobalKey<FormState> savedTextFormKey = GlobalKey<FormState>();
  TextEditingController savedTextController = TextEditingController();

  late AnimatedTextController textAnimationController =
      AnimatedTextController();

  RxBool isDone = false.obs;
  RxBool canSaveText = false.obs;
  RxBool obscurePassword = true.obs;
  RxBool stopTextAnimation = false.obs;

  BannerAd? homeBannerAd;
  RxBool homeBannerAdLoaded = false.obs;
  final homeBannerAdUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/9214589741'
      : 'ca-app-pub-3940256099942544/2435281174';

  InterstitialAd? interstitialAd;
  RxBool interstitialAdLoaded = false.obs;
  RxInt decryptCount = 4.obs;
  final interstitialAdUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/1033173712'
      : 'ca-app-pub-3940256099942544/4411468910';

  @override
  void onInit() {
    super.onInit();
    loadHomeBannerAd();
    loadDecryptInterstitialAd();
    textController.addListener(() {
      if (textController.text.isEmpty) {
        isDone.value = false;
        canSaveText.value = false;
        stopTextAnimation.value = false;
      }
    });
  }

  @override
  void dispose() {
    textController.dispose();
    passController.dispose();
    textAnimationController.dispose();
    savedTextController.dispose();
    homeBannerAd?.dispose();
    interstitialAd?.dispose();
    super.dispose();
  }

  void showPassword() {
    obscurePassword.value = !obscurePassword.value;
  }

  void stopTextAnimationFunction() {
    stopTextAnimation.value = true;
  }

  void openSavedText(SaveText text) {
    FocusManager.instance.primaryFocus?.unfocus();
    passController.text = '';
    textController.text = text.text;
    isDone.value = true;
    canSaveText.value = true;
    stopTextAnimation.value = true;
    textAnimationController.reset();
  }

  void pasteFunction() async {
    FocusManager.instance.primaryFocus?.unfocus();
    ClipboardData? cdata = await Clipboard.getData(Clipboard.kTextPlain);
    if (cdata != null) textController.text = cdata.text as String;
    print(cdata?.text);
  }

  void clearFunction() {
    FocusManager.instance.primaryFocus?.unfocus();
    textController.text = '';
    passController.text = '';

    isDone.value = false;
    canSaveText.value = false;
    stopTextAnimation.value = false;
    textAnimationController.reset();
  }

  void copyFunction() {
    FocusManager.instance.primaryFocus?.unfocus();
    Clipboard.setData(ClipboardData(text: textController.text));
  }

  void shareFunction() {
    FocusManager.instance.primaryFocus?.unfocus();
    Share.share(textController.text);
  }

  void encryptText() {
    if (passController.text != '' && textController.text != '') {
      final iv = encrypt.IV.fromLength(16);

      //* Create PBKDF2 instance using the SHA256 hash
      var gen = new PBKDF2(hash: sha256);

      //* Generate a 32 byte key using the given password and salt, with 1000 iterations
      var keyPBKDF2 = gen.generateKey(passController.text, "salt", 1000, 32);

      //* Digest the generated PBKDF2 Key
      var digest = md5.convert(keyPBKDF2);
      print(digest.toString());

      //* generate key using digested md5
      final key = encrypt.Key.fromUtf8(digest.toString());

      final encrypter =
          encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.ecb));

      final encrypted = encrypter.encrypt(textController.text, iv: iv);

      textController.text = encrypted.base64;

      isDone.value = true;
      canSaveText.value = true;
    } else {
      customPopup(
        context: Get.context!,
        topic: 'Empty Fields',
        body: Column(
          children: [
            Text(
              'Please enter both text and password to encrypt',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: 'Ok',
              onTap: () => Get.back(),
            ),
          ],
        ),
      );
    }
  }

  void decryptText() {
    try {
      final iv = encrypt.IV.fromLength(16);

      //* Create PBKDF2 instance using the SHA256 hash
      var gen = new PBKDF2(hash: sha256);

      //* Generate a 32 byte key using the given password and salt, with 1000 iterations
      var keyPBKDF2 = gen.generateKey(passController.text, "salt", 1000, 32);

      //* Digest the generated PBKDF2 Key
      var digest = md5.convert(keyPBKDF2);

      //* generate key using digested md5
      final key = encrypt.Key.fromUtf8(digest.toString());

      final encrypter =
          encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.ecb));

      final decrypted = encrypter.decrypt64(textController.text, iv: iv);
      textController.text = decrypted;

      isDone.value = true;
      canSaveText.value = false;
    } catch (e) {
      print(e);
      //* Password wrong popup
      if (e.toString() ==
          'Invalid argument(s): Invalid or corrupted pad block') {
        customPopup(
          context: Get.context!,
          topic: 'Wrong Password',
          body: Column(
            children: [
              const Text(
                'Password you entered does not match',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              CustomButton(
                text: 'Ok',
                onTap: () => Get.back(),
              ),
            ],
          ),
        );
      } else {
        customPopup(
          context: Get.context!,
          topic: 'Invalid Input',
          body: Column(
            children: [
              const Text(
                'Invalid text or password entered',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              CustomButton(
                text: 'Ok',
                onTap: () => Get.back(),
              ),
            ],
          ),
        );
      }
    }
  }

  void loadHomeBannerAd() async {
    final size = await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
      MediaQuery.sizeOf(Get.context!).width.truncate() - 32,
    );

    homeBannerAd = BannerAd(
      adUnitId: homeBannerAdUnitId,
      request: const AdRequest(),
      size: size!,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          debugPrint('$ad loaded.');
          homeBannerAdLoaded.value = true;
        },
        onAdFailedToLoad: (ad, err) {
          debugPrint('BannerAd failed to load: $err');
          ad.dispose();
        },
      ),
    )..load();
  }

  void showDecryptInterstitialAd() {
    if (textController.text.isEmpty || passController.text.isEmpty) {
      customPopup(
        context: Get.context!,
        topic: 'Empty Fields',
        body: Column(
          children: [
            const Text(
              'Please enter both text and password to decrypt',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: 'Ok',
              onTap: () => Get.back(),
            ),
          ],
        ),
      );
      return;
    }
    if (interstitialAdLoaded.value) {
      if (decryptCount.value < 3) {
        decryptCount.value++;
        decryptText();
        return;
      }
      decryptCount.value = 0;
      interstitialAd?.show();
      interstitialAdLoaded.value = false;
      loadDecryptInterstitialAd();
    } else {
      decryptText();
    }
  }

  void loadDecryptInterstitialAd() {
    InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            // Called when the ad showed the full screen content.
            onAdShowedFullScreenContent: (ad) {},
            // Called when an impression occurs on the ad.
            onAdImpression: (ad) {},
            // Called when the ad failed to show full screen content.
            onAdFailedToShowFullScreenContent: (ad, err) {
              // Dispose the ad here to free resources.
              ad.dispose();
            },
            // Called when the ad dismissed full screen content.
            onAdDismissedFullScreenContent: (ad) {
              decryptText();
              // Dispose the ad here to free resources.
              ad.dispose();
            },
            // Called when a click is recorded for an ad.
            onAdClicked: (ad) {},
          );

          print('$ad loaded.');
          // Keep a reference to the ad so you can show it later.
          interstitialAd = ad;
          interstitialAdLoaded.value = true;
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (LoadAdError error) {
          print('InterstitialAd failed to load: $error');
        },
      ),
    );
  }
}
