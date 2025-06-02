import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/string_constants.dart';
import '../../../constants/theme_constants.dart';
import '../../../controllers/home_controller.dart';
import '../../../controllers/saved_texts_controller.dart';
import '../../../models/save_text_model.dart';

class DropdownOptionsWidget extends GetView<SavedTextsController> {
  final SaveText text;
  DropdownOptionsWidget(this.text, {super.key});

  @override
  String? get tag => savedTextsControllerTag;

  final HomeController homeController =
      Get.find<HomeController>(tag: homeControllerTag);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        customButton: Icon(
          Icons.more_horiz_rounded,
          color: AppTheme.white,
          size: 20,
        ),
        style: TextStyle(
          color: AppTheme.white,
          fontSize: 16,
        ),
        items: [
          DropdownMenuItem(
            child: Row(
              children: [
                Icon(
                  CupertinoIcons.lock_open,
                  color: AppTheme.white,
                  size: 20,
                ),
                SizedBox(width: 8),
                Text('saved_texts.Decrypt'.tr),
              ],
            ),
            value: 'view',
          ),
          DropdownMenuItem(
            child: Row(
              children: [
                Icon(
                  CupertinoIcons.share,
                  color: AppTheme.white,
                  size: 20,
                ),
                SizedBox(width: 8),
                Text('saved_texts.Share'.tr),
              ],
            ),
            value: 'share',
          ),
          DropdownMenuItem(
            child: Row(
              children: [
                Icon(
                  CupertinoIcons.delete,
                  color: AppTheme.white,
                  size: 20,
                ),
                SizedBox(width: 8),
                Text('saved_texts.Delete'.tr),
              ],
            ),
            value: 'delete',
          ),
        ],
        onChanged: (value) => controller.handleDropdownAction(
          value as String,
          text,
          () => homeController.openSavedText(text),
        ),
        dropdownStyleData: DropdownStyleData(
          width: 160,
          padding: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: AppTheme.greyShade1,
          ),
          offset: const Offset(0, 8),
        ),
      ),
    );
  }
}
