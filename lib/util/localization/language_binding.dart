import 'package:get/get.dart';

import '../../constants/string_constants.dart';
import 'language_controller.dart';

class LanguageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<LanguageController>(
      LanguageController(),
      tag: languageControllerTag,
    );
  }
}
