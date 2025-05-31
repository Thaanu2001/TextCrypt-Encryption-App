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
      product = (await Purchases.getProducts(['premium_1'])).first;

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
      final products = await Purchases.getProducts(['premium_1']);
      CustomerInfo customerInfo = await Purchases.purchaseStoreProduct(
        products.first,
      );

      if (customerInfo.entitlements.all["premium"]?.isActive == true) {
        isPremium.value = true;
        Get.offAllNamed(Routes.HOME);
        Get.snackbar(
          'Purchase successful',
          'You have successfully purchased the premium membership.',
          backgroundColor: AppTheme.grey,
          colorText: AppTheme.white,
        );
      }
    } on PlatformException catch (e) {
      var errorCode = PurchasesErrorHelper.getErrorCode(e);
      if (errorCode != PurchasesErrorCode.purchaseCancelledError) {
        Get.snackbar(
          'Transaction failed',
          'An error occurred while processing your purchase: ${e.message}',
          backgroundColor: AppTheme.grey,
          colorText: AppTheme.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Transaction failed',
        'An error occurred while processing your purchase. Please try again later.',
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
          'Already Subscribed',
          'You already have an active subscription.',
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
          'Subscription Restored',
          'Your subscription has been restored successfully.',
          backgroundColor: AppTheme.grey,
          colorText: AppTheme.white,
        );
      } else {
        isPremium.value = false;
        Get.snackbar(
          'No Active Subscription',
          'No active subscription found. Please purchase a subscription.',
          backgroundColor: AppTheme.grey,
          colorText: AppTheme.white,
        );
      }
    } on PlatformException catch (e) {
      var errorCode = PurchasesErrorHelper.getErrorCode(e);
      if (errorCode != PurchasesErrorCode.purchaseCancelledError) {
        Get.snackbar(
          'Transaction failed',
          'An error occurred while restoring your subscription: ${e.message}',
          backgroundColor: AppTheme.grey,
          colorText: AppTheme.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Transaction failed',
        'An error occurred while restoring your subscription. Please try again later.',
        backgroundColor: AppTheme.grey,
        colorText: AppTheme.white,
      );
    } finally {
      purchaseInProgress.value = false;
    }
  }
}
