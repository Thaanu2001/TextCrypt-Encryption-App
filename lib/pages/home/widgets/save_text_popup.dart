import 'package:encrypt_decrypt_app/constants/string_constants.dart';
import 'package:encrypt_decrypt_app/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../components/custom_button.dart';
import '../../../components/custom_popup.dart';

void saveTextPopup(BuildContext context) {
  final HomeController controller = Get.find<HomeController>(
    tag: homeControllerTag,
  );

  return customPopup(
    context: context,
    topic: 'Save Encrypted Text',
    width: 0.8,
    body: Form(
      key: controller.savedTextFormKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          Text(
            'This text will only be saved locally on your device. You can access it later from the "Saved Texts" section on side drawer.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          Text(
            'Your password will not be saved with the text.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: controller.savedTextController,
            textInputAction: TextInputAction.done,
            style: GoogleFonts.robotoMono(
                fontSize: 18, color: Colors.white, fontWeight: FontWeight.w400),
            decoration: new InputDecoration(
              hintText: 'Name for the text',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a name for the text';
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
            text: 'Save',
          ),
        ],
      ),
    ),
  );
}
