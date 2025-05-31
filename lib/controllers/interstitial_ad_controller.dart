import 'dart:io';

import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../routes/routes.dart';

class InterstitialAdController extends GetxController {
  InterstitialAd? interstitialAd;
  RxBool interstitialAdLoaded = false.obs;
  RxInt pageOpenCount = 4.obs;

  final adUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/1033173712'
      : 'ca-app-pub-3940256099942544/4411468910';

  @override
  void onInit() {
    super.onInit();
    loadInterstitialAd();
  }

  @override
  void dispose() {
    interstitialAd?.dispose();
    super.dispose();
  }

  void showInterstitialAd() {
    if (interstitialAdLoaded.value) {
      if (pageOpenCount.value < 3) {
        pageOpenCount.value++;
        Get.back();
        Get.toNamed(Routes.SAVED_TEXTS);
        return;
      }
      pageOpenCount.value = 0;
      interstitialAd?.show();
      interstitialAdLoaded.value = false;
      loadInterstitialAd();
    } else {
      Get.back();
      Get.toNamed(Routes.SAVED_TEXTS);
    }
  }

  void loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: adUnitId,
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
              Get.back();
              Get.toNamed(Routes.SAVED_TEXTS);
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
