import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/string_constants.dart';
import '../../../constants/theme_constants.dart';
import '../../../controllers/saved_texts_controller.dart';

class ExportImportOptionsWidget extends GetView<SavedTextsController> {
  ExportImportOptionsWidget({super.key});

  @override
  String? get tag => savedTextsControllerTag;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: AppTheme.defaultPadding),
      child: DropdownButtonHideUnderline(
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
                    CupertinoIcons.share,
                    color: AppTheme.white,
                    size: 20,
                  ),
                  SizedBox(width: 8),
                  Text('Export'),
                ],
              ),
              value: 'export',
            ),
            DropdownMenuItem(
              child: Row(
                children: [
                  Icon(
                    CupertinoIcons.square_arrow_down,
                    color: AppTheme.white,
                    size: 20,
                  ),
                  SizedBox(width: 8),
                  Text('Import'),
                ],
              ),
              value: 'import',
            ),
          ],
          onChanged: (value) {
            if (value == 'export') {
              controller.exportSavedTexts();
            } else if (value == 'import') {
              controller.selectSavedTextsFile();
            }
          },
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
      ),
    );
  }
}
