import 'package:encrypt_decrypt_app/constants/string_constants.dart';
import 'package:get/get.dart';

import '../../util/localization/language_controller.dart';

class InitialBindings {
  InitialBindings() {
    Get.put<LanguageController>(
      LanguageController(),
      tag: languageControllerTag,
      permanent: true,
    );
  }
}
