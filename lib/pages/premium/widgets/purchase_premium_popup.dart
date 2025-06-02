import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/custom_button.dart';
import '../../../components/custom_popup.dart';
import '../../../constants/string_constants.dart';
import '../../../controllers/premium_controller.dart';
import '../../../routes/routes.dart';

Future purchasePremiumPopup(BuildContext context) {
  final PremiumController premiumController = Get.find<PremiumController>(
    tag: premiumControllerTag,
  );

  return customPopup(
    context: context,
    topic: 'premium.Remove_Ads'.tr,
    width: 0.8,
    body: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 10),
        Text(
          'premium.Remove_ads_and_support_the_development_of_this_app_by_purchasing_premium_for'
                  .tr +
              ' ${premiumController.product?.priceString}.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: CustomButton(
                text: 'premium.Cancel'.tr,
                buttonType: ButtonType.secondary,
                onTap: () => Get.back(),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: CustomButton(
                text: 'premium.Purchase'.tr,
                onTap: () {
                  Get.back(result: false);
                  Get.toNamed(Routes.PREMIUM);
                },
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
