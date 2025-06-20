// import '../../assets/icons/customicons_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_utils/src/extensions/export.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/string_constants.dart';
import '../../../controllers/home_controller.dart';

class EncryptSection extends GetView<HomeController> {
  @override
  String? get tag => homeControllerTag;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Row(
        children: [
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Obx(
              () => TextFormField(
                controller: controller.passController,
                textInputAction: TextInputAction.done,
                obscureText: controller.obscurePassword.value,
                style: GoogleFonts.robotoMono(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w400),
                decoration: new InputDecoration(
                  hintText: 'home.Password'.tr,
                  suffixIcon: InkWell(
                    onTap: controller.showPassword,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Icon(
                        controller.obscurePassword.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                        size: 18,
                        color: Colors.white38,
                      ),
                    ),
                  ),
                  suffixIconConstraints: BoxConstraints(
                    minWidth: 40,
                    maxHeight: 20,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 15),
          TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              foregroundColor: Colors.grey,
              backgroundColor: Color(0xff171717),
            ),
            child: Icon(
              CupertinoIcons.lock,
              color: Colors.white,
              size: 20,
            ),
            onPressed: () => controller.encryptText(),
          ),
          SizedBox(width: 15),
          TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              foregroundColor: Colors.grey,
              backgroundColor: Color(0xff171717),
            ),
            child: Icon(
              CupertinoIcons.lock_open,
              color: Colors.white,
              size: 20,
            ),
            onPressed: () => controller.showDecryptInterstitialAd(),
          ),
        ],
      ),
    );
  }
}
