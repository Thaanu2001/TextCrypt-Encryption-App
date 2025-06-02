import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import 'constants/string_constants.dart';
import 'constants/theme_constants.dart';
import 'routes/bindings/initial_binding.dart';
import 'routes/routes.dart';
import 'util/localization/language_binding.dart';
import 'util/localization/language_controller.dart';
import 'util/localization/localization.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  if (kDebugMode) {
    MobileAds.instance.updateRequestConfiguration(
      RequestConfiguration(testDeviceIds: ['e0053cdea2b90e74876eba6e3048e6b8']),
    );
  }

  await initRevenueCat();

  await GetStorage.init();
  InitialBindings();

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
      child: GetBuilder<LanguageController>(
        tag: languageControllerTag,
        builder: (languageController) {
          return GetMaterialApp(
            title: 'TextCrypt',
            debugShowCheckedModeBanner: false,
            defaultTransition: Transition.cupertino,
            initialRoute: initialRoute,
            getPages: Routes.pages,
            theme: AppTheme.appTheme,
            supportedLocales: languageController.supportedLocales(),
            locale: languageController.getLocale,
            initialBinding: LanguageBinding(),
            translations: Localization(),
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            builder: (BuildContext context, Widget? child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  textScaler: const TextScaler.linear(1),
                ),
                child: child as Widget,
              );
            },
          );
        },
      ),
    );
  }
}
