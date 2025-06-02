import 'package:get/get.dart';

import '../pages/home/home_page.dart';
import '../pages/info/info_page.dart';
import '../pages/language/language_page.dart';
import '../pages/premium/premium_page.dart';
import '../pages/saved_texts/saved_texts_page.dart';
import '../util/localization/language_binding.dart';
import 'bindings/home_binding.dart';
import 'bindings/premium_binding.dart';
import 'bindings/saved_texts_binding.dart';

abstract class _Paths {
  _Paths._();

  static const HOME = '/home';
  static const SAVED_TEXTS = '/saved-texts';
  static const INFO = '/info';
  static const PREMIUM = '/premium';
  static const LANGUAGE = '/language';
}

class Routes {
  Routes._();

  static const HOME = _Paths.HOME;
  static const SAVED_TEXTS = _Paths.SAVED_TEXTS;
  static const INFO = _Paths.INFO;
  static const PREMIUM = _Paths.PREMIUM;
  static const LANGUAGE = _Paths.LANGUAGE;

  static String get initial => HOME;

  static List<GetPage> get pages => [
        GetPage(
          name: _Paths.HOME,
          page: () => HomeScreen(),
          binding: HomeBinding(),
        ),
        GetPage(
          name: _Paths.SAVED_TEXTS,
          page: () => SavedTextsPage(),
          binding: SavedTextsBinding(),
        ),
        GetPage(
          name: _Paths.INFO,
          page: () => const InfoPage(),
        ),
        GetPage(
          name: _Paths.PREMIUM,
          page: () => const PremiumPage(),
          binding: PremiumBinding(),
        ),
        GetPage(
          name: _Paths.LANGUAGE,
          page: () => LanguagePage(),
          binding: LanguageBinding(),
        ),
      ];
}
