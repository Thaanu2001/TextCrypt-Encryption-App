import 'package:get/get.dart';

import '../pages/home/home_page.dart';
import 'bindings/home_binding.dart';

abstract class _Paths {
  _Paths._();

  static const HOME = '/home';
}

class Routes {
  Routes._();

  static const HOME = _Paths.HOME;

  static String get initial => HOME;

  static List<GetPage> get pages => [
        GetPage(
          name: _Paths.HOME,
          page: () => HomeScreen(),
          binding: HomeBinding(),
        ),
      ];
}
