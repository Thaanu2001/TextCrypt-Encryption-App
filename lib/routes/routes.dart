import 'package:encrypt_decrypt_app/pages/info/info_page.dart';
import 'package:encrypt_decrypt_app/pages/premium/premium_page.dart';
import 'package:encrypt_decrypt_app/pages/saved_texts/saved_texts_page.dart';
import 'package:encrypt_decrypt_app/routes/bindings/premium_binding.dart';
import 'package:encrypt_decrypt_app/routes/bindings/saved_texts_binding.dart';
import 'package:get/get.dart';

import '../pages/home/home_page.dart';
import 'bindings/home_binding.dart';

abstract class _Paths {
  _Paths._();

  static const HOME = '/home';
  static const SAVED_TEXTS = '/saved-texts';
  static const INFO = '/info';
  static const PREMIUM = '/premium';
}

class Routes {
  Routes._();

  static const HOME = _Paths.HOME;
  static const SAVED_TEXTS = _Paths.SAVED_TEXTS;
  static const INFO = _Paths.INFO;
  static const PREMIUM = _Paths.PREMIUM;

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
      ];
}
