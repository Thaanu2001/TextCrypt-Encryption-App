import 'package:get/get.dart';

import '../../constants/string_constants.dart';
import '../../controllers/home_controller.dart';
import '../../controllers/interstitial_ad_controller.dart';
import '../../controllers/premium_controller.dart';
import '../../controllers/saved_texts_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<PremiumController>(PremiumController(), tag: premiumControllerTag);

    Get.put<SavedTextsController>(
      SavedTextsController(),
      tag: savedTextsControllerTag,
    );

    Get.put<HomeController>(HomeController(), tag: homeControllerTag);

    Get.put<InterstitialAdController>(
      InterstitialAdController(),
      tag: interstitialAdControllerTag,
    );
  }
}
