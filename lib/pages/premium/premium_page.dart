import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/custom_app_bar.dart';
import '../../components/custom_button.dart';
import '../../constants/string_constants.dart';
import '../../constants/theme_constants.dart';
import '../../controllers/premium_controller.dart';

class PremiumPage extends GetView<PremiumController> {
  const PremiumPage({super.key});

  @override
  String? get tag => premiumControllerTag;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'premium.Premium_Purchase'.tr,
        leadingIcon: Icons.arrow_back,
        leadingOnTap: () => Get.back(),
      ),
      body: Obx(
        () => Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.defaultPadding,
              ),
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Text(
                    'premium.desc_1'.tr,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'premium.desc_2'.tr,
                  ),
                  SizedBox(height: 26),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppTheme.greyShade1,
                      border: Border.all(
                        color: AppTheme.greyTint1,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(
                        AppTheme.defaultBorderRadius,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'premium.Premium'.tr,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(
                                    color: AppTheme.white,
                                  ),
                            ),
                            Spacer(),
                            if (controller.product != null)
                              Text(
                                '${controller.product?.priceString}',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Text(
                          '• ' +
                              'premium.Ad-free_experience'.tr +
                              '\n'
                                  '• ' +
                              'premium.Lifetime_access'.tr +
                              '\n'
                                  '• ' +
                              'premium.Support_the_development_of_the_application'
                                  .tr,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: AppTheme.white,
                                  ),
                        ),
                        SizedBox(height: 20),
                        controller.isPremium.value == true
                            ? Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: AppTheme.green.withValues(alpha: 0.6),
                                  borderRadius: BorderRadius.circular(
                                    AppTheme.defaultBorderRadius,
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  'premium.Active'.tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              )
                            : CustomButton(
                                onTap: () => controller.onPurchase(),
                                text: 'premium.Upgrade_to_Premium'.tr,
                              ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'premium.desc_3'.tr,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'premium.desc_4'.tr,
                  ),
                  SizedBox(height: 16),
                  CustomButton(
                    onTap: () => controller.onRestore(),
                    text: 'premium.Restore_Purchase'.tr,
                    buttonType: ButtonType.secondary,
                  ),
                  SizedBox(height: MediaQuery.paddingOf(context).bottom + 8),
                ],
              ),
            ),
            if (controller.purchaseInProgress.value)
              Container(
                color: Colors.black38,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 3,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'premium.Please_wait'.tr,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
