import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';

import '../components/custom_button.dart';
import '../components/custom_popup.dart';
import '../pbkdf2.dart';

class HomeController extends GetxController {
  TextEditingController textController = TextEditingController();
  TextEditingController passController = TextEditingController();
  late AnimatedTextController textAnimationController =
      AnimatedTextController();
  RxBool isDone = false.obs;
  RxBool obscurePassword = true.obs;
  RxBool stopTextAnimation = false.obs;

  @override
  void dispose() {
    textController.dispose();
    passController.dispose();
    textAnimationController.dispose();
    super.dispose();
  }

  void showPassword() {
    obscurePassword.value = !obscurePassword.value;
  }

  void stopTextAnimationFunction() {
    stopTextAnimation.value = true;
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
    if (passController.text.isNotEmpty && textController.text.isNotEmpty) {
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
    } else {
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
    }
  }
}
