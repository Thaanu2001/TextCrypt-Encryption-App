import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../components/custom_button.dart';
import '../../../components/custom_popup.dart';
import '../../../constants/string_constants.dart';
import '../../../controllers/home_controller.dart';

void saveTextPopup(BuildContext context) {
  final HomeController controller = Get.find<HomeController>(
    tag: homeControllerTag,
  );

  return customPopup(
    context: context,
    topic: 'home.Save_Encrypted_Text'.tr,
    width: 0.8,
    body: Form(
      key: controller.savedTextFormKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          Text(
            'home.save_text_popup_desc_1'.tr,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          Text(
            'home.save_text_popup_desc_2'.tr,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: controller.savedTextController,
            textInputAction: TextInputAction.done,
            style: GoogleFonts.robotoMono(
                fontSize: 18, color: Colors.white, fontWeight: FontWeight.w400),
            decoration: new InputDecoration(
              hintText: 'home.Name_for_the_text'.tr,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'home.Please_enter_a_name_for_the_text'.tr;
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          CustomButton(
            onTap: () {
              if (controller.savedTextFormKey.currentState?.validate() ??
                  false) {
                controller.showSaveTextInterstitialAd();
              }
            },
            text: 'home.Save'.tr,
          ),
        ],
      ),
    ),
  );
}
