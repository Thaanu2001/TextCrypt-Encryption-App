import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../constants/string_constants.dart';
import '../../../controllers/saved_texts_controller.dart';

class SavedTextsAdWidget extends GetView<SavedTextsController> {
  const SavedTextsAdWidget({super.key});

  @override
  String? get tag => savedTextsControllerTag;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => !controller.savedTextsBannerAdLoaded.value
          ? const SizedBox.shrink()
          : SizedBox(
              width: controller.savedTextsBannerAd!.size.width.toDouble(),
              height: controller.savedTextsBannerAd!.size.height.toDouble(),
              child: AdWidget(ad: controller.savedTextsBannerAd!),
            ),
    );
  }
}
