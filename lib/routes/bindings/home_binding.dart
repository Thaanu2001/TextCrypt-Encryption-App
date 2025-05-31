import 'package:encrypt_decrypt_app/controllers/saved_texts_controller.dart';
import 'package:get/get.dart';

import '../../constants/string_constants.dart';
import '../../controllers/home_controller.dart';
import '../../controllers/interstitial_ad_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(SavedTextsController(), tag: savedTextsControllerTag);

    Get.put<HomeController>(HomeController(), tag: homeControllerTag);

    Get.put<InterstitialAdController>(
      InterstitialAdController(),
      tag: interstitialAdControllerTag,
    );
  }
}
