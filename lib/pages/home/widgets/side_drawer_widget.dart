import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/string_constants.dart';
import '../../../constants/theme_constants.dart';
import '../../../controllers/interstitial_ad_controller.dart';
import '../../../routes/routes.dart';

class SideDrawerWidget extends GetView<InterstitialAdController> {
  const SideDrawerWidget({super.key});

  @override
  String? get tag => interstitialAdControllerTag;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 220,
      backgroundColor: Color(0xff171717),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(
              20,
              MediaQuery.of(context).padding.top + 5,
              20,
              20,
            ),
            color: Color(0xff1e1e1f),
            width: double.infinity,
            child: Row(
              children: [
                Text(
                  'home.Menu'.tr,
                  style: GoogleFonts.robotoMono(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                  splashColor: AppTheme.greyShade1,
                  leading: SvgPicture.asset(
                    'assets/icons/save.svg',
                    width: 18,
                    colorFilter: ColorFilter.mode(
                      AppTheme.white,
                      BlendMode.srcIn,
                    ),
                  ),
                  title: Text(
                    'home.Saved_Texts'.tr,
                    style: GoogleFonts.robotoMono(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () => controller.showInterstitialAd(),
                ),
                ListTile(
                  splashColor: AppTheme.greyShade1,
                  leading: SvgPicture.asset(
                    'assets/icons/premium.svg',
                    width: 18,
                    colorFilter: ColorFilter.mode(
                      AppTheme.white,
                      BlendMode.srcIn,
                    ),
                  ),
                  title: Text(
                    'home.Premium'.tr,
                    style: GoogleFonts.robotoMono(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    Get.back();
                    Get.toNamed(Routes.PREMIUM);
                  },
                ),
                ListTile(
                  splashColor: AppTheme.greyShade1,
                  leading: SvgPicture.asset(
                    'assets/icons/language.svg',
                    width: 18,
                    colorFilter: ColorFilter.mode(
                      AppTheme.white,
                      BlendMode.srcIn,
                    ),
                  ),
                  title: Text(
                    'home.Language'.tr,
                    style: GoogleFonts.robotoMono(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    Get.back();
                    Get.toNamed(Routes.LANGUAGE);
                  },
                ),
                ListTile(
                  splashColor: AppTheme.greyShade1,
                  leading: SvgPicture.asset(
                    'assets/icons/info.svg',
                    width: 18,
                    colorFilter: ColorFilter.mode(
                      AppTheme.white,
                      BlendMode.srcIn,
                    ),
                  ),
                  title: Text(
                    'home.Info'.tr,
                    style: GoogleFonts.robotoMono(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    Get.back();
                    Get.toNamed(Routes.INFO);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
