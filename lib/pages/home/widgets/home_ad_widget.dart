import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../constants/string_constants.dart';
import '../../../controllers/home_controller.dart';

class HomeAdWidget extends GetView<HomeController> {
  const HomeAdWidget({super.key});

  @override
  String? get tag => homeControllerTag;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => !controller.homeBannerAdLoaded.value
          ? const SizedBox.shrink()
          : Padding(
              padding: const EdgeInsets.only(top: 20),
              child: SizedBox(
                width: controller.homeBannerAd!.size.width.toDouble(),
                height: controller.homeBannerAd!.size.height.toDouble(),
                child: AdWidget(ad: controller.homeBannerAd!),
              ),
            ),
    );
  }
}
