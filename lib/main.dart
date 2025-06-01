import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import 'constants/theme_constants.dart';
import 'routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  if (kDebugMode) {
    MobileAds.instance.updateRequestConfiguration(
      RequestConfiguration(testDeviceIds: ['e0053cdea2b90e74876eba6e3048e6b8']),
    );
  }

  await initRevenueCat();

  runApp(Main(initialRoute: Routes.initial));
}

Future<void> initRevenueCat() async {
  await Purchases.setLogLevel(LogLevel.debug);

  PurchasesConfiguration configuration;
  configuration = PurchasesConfiguration(
    Platform.isAndroid
        ? 'goog_RdGwOmTXQwozrAUfwaxaeGlpQAf'
        : 'appl_sdUWWKcUKGizjrgfJwBtcmelKGJ',
  );
  await Purchases.configure(configuration);
}

class Main extends StatelessWidget {
  final String initialRoute;
  const Main({Key? key, required this.initialRoute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.transparent,
      ),
      child: GetMaterialApp(
        title: 'TextCrypt',
        debugShowCheckedModeBanner: false,
        defaultTransition: Transition.cupertino,
        initialRoute: initialRoute,
        getPages: Routes.pages,
        theme: AppTheme.appTheme,
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: const TextScaler.linear(1),
            ),
            child: child as Widget,
          );
        },
      ),
    );
  }
}
