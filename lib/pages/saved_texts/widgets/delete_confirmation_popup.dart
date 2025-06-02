import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

import '../../../components/custom_button.dart';
import '../../../components/custom_popup.dart';
import '../../../constants/theme_constants.dart';

deleteConfirmationPopup({
  required BuildContext context,
  required VoidCallback onDelete,
}) {
  return customPopup(
    context: context,
    topic: 'saved_texts.Confirm_Delete'.tr,
    width: 0.8,
    body: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 10),
        Text(
          'saved_texts.Are_you_sure_you_want_to_delete_this_text'.tr,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: CustomButton(
                onTap: () {
                  Navigator.of(context).pop();
                },
                text: 'saved_texts.Cancel'.tr,
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: CustomButton(
                btnColor: AppTheme.red,
                onTap: () {
                  onDelete();
                  Navigator.of(context).pop();
                },
                text: 'saved_texts.Delete'.tr,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
