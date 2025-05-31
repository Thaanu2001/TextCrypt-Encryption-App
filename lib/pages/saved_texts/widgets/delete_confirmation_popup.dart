import 'package:flutter/material.dart';

import '../../../components/custom_button.dart';
import '../../../components/custom_popup.dart';
import '../../../constants/theme_constants.dart';

deleteConfirmationPopup({
  required BuildContext context,
  required VoidCallback onDelete,
}) {
  return customPopup(
    context: context,
    topic: 'Delete Confirmation',
    width: 0.8,
    body: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 10),
        Text(
          'Are you sure you want to delete this text?',
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
                text: 'Cancel',
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
                text: 'Delete',
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
