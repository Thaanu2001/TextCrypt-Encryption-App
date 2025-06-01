import 'package:encrypt_decrypt_app/components/custom_button.dart';
import 'package:encrypt_decrypt_app/constants/theme_constants.dart';
import 'package:encrypt_decrypt_app/controllers/premium_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/custom_app_bar.dart';
import '../../constants/string_constants.dart';

class PremiumPage extends GetView<PremiumController> {
  const PremiumPage({super.key});

  @override
  String? get tag => premiumControllerTag;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Premium Purchase',
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
                    'Support us and unlock a smoother, distraction-free app — no more ads, just you and the content.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Premium is a one-time purchase. Once you\'ve upgraded, you\'ll have lifetime access to the ad-free experience.',
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
                              'Premium',
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
                          '• Ad-free experience.\n'
                          '• Lifetime access.\n'
                          '• Support the development of the application.',
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
                                  'Active',
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
                                text: 'Upgrade to Premium',
                              ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Thank you for considering supporting our app! Your contribution helps us keep improving and providing a great experience.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'If you have already purchased premium, please restore your purchase from the below button.',
                  ),
                  SizedBox(height: 16),
                  CustomButton(
                    onTap: () => controller.onRestore(),
                    text: 'Restore Purchase',
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
                          'Please wait...',
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
