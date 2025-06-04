import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../constants/theme_constants.dart';
import '../routes/routes.dart';

class PremiumController extends GetxController {
  final RxBool purchaseInProgress = false.obs;
  final RxnBool isPremium = RxnBool(null);
  StoreProduct? product = null;

  @override
  void onInit() {
    super.onInit();
    getSubscriptionStatus();
  }

  void getSubscriptionStatus() async {
    try {
      product = (await Purchases.getProducts(
        ['premium_1'],
        productCategory: ProductCategory.nonSubscription,
      ))
          .first;

      CustomerInfo customerInfo = await Purchases.getCustomerInfo();
      if (customerInfo.entitlements.all['premium']?.isActive == true) {
        isPremium.value = true;
      } else {
        isPremium.value = false;
      }
    } catch (e) {
      print('Error fetching subscription status: $e');
      isPremium.value = false;
    }
  }

  void onPurchase() async {
    try {
      purchaseInProgress.value = true;
      final products = await Purchases.getProducts(
        ['premium_1'],
        productCategory: ProductCategory.nonSubscription,
      );
      CustomerInfo customerInfo = await Purchases.purchaseStoreProduct(
        products.first,
      );

      if (customerInfo.entitlements.all["premium"]?.isActive == true) {
        isPremium.value = true;
        Get.offAllNamed(Routes.HOME);
        Get.snackbar(
          'premium.Purchase_successful'.tr,
          'premium.You_have_successfully_purchased_the_premium_membership'.tr,
          backgroundColor: AppTheme.grey,
          colorText: AppTheme.white,
        );
      }
    } on PlatformException catch (e) {
      var errorCode = PurchasesErrorHelper.getErrorCode(e);
      if (errorCode != PurchasesErrorCode.purchaseCancelledError) {
        Get.snackbar(
          'premium.Transaction_failed'.tr,
          'premium.An_error_occurred_while_processing_your_purchase'.tr +
              ' ${e.message}',
          backgroundColor: AppTheme.grey,
          colorText: AppTheme.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'premium.Transaction_failed'.tr,
        'premium.An_error_occurred_while_processing_your_purchase._Please_try_again_later'
            .tr,
        backgroundColor: AppTheme.grey,
        colorText: AppTheme.white,
      );
    } finally {
      purchaseInProgress.value = false;
    }
  }

  void onRestore() async {
    try {
      purchaseInProgress.value = true;

      if (isPremium.value == true) {
        Get.snackbar(
          'premium.Already_Subscribed'.tr,
          'premium.You_already_have_an_active_subscription'.tr,
          backgroundColor: AppTheme.grey,
          colorText: AppTheme.white,
        );
        return;
      }
      final customerInfo = await Purchases.restorePurchases();

      if (customerInfo.entitlements.all["premium"]?.isActive == true) {
        isPremium.value = true;
        Get.offAllNamed(Routes.HOME);

        Get.snackbar(
          'premium.Subscription_Restored'.tr,
          'premium.Your_subscription_has_been_restored_successfully'.tr,
          backgroundColor: AppTheme.grey,
          colorText: AppTheme.white,
        );
      } else {
        isPremium.value = false;
        Get.snackbar(
          'premium.No_Active_Subscription'.tr,
          'premium.No_active_subscription_found_Please_purchase_a_subscription'
              .tr,
          backgroundColor: AppTheme.grey,
          colorText: AppTheme.white,
        );
      }
    } on PlatformException catch (e) {
      var errorCode = PurchasesErrorHelper.getErrorCode(e);
      if (errorCode != PurchasesErrorCode.purchaseCancelledError) {
        Get.snackbar(
          'premium.Transaction_failed'.tr,
          'premium.An_error_occurred_while_processing_your_purchase'.tr +
              ' ${e.message}',
          backgroundColor: AppTheme.grey,
          colorText: AppTheme.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'premium.Transaction_failed'.tr,
        'premium.An_error_occurred_while_processing_your_purchase._Please_try_again_later'
            .tr,
        backgroundColor: AppTheme.grey,
        colorText: AppTheme.white,
      );
    } finally {
      purchaseInProgress.value = false;
    }
  }
}
