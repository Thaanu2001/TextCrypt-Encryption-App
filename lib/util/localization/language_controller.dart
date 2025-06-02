// ignore_for_file: deprecated_member_use

import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../constants/string_constants.dart';

class LanguageController extends GetxController {
  static LanguageController get to => Get.find();

  final availableLocales = ['en', 'es', 'fr', 'de', 'it', 'pt', 'ru', 'zh'];
  final language = "".obs;
  final store = GetStorage();

  String get currentLanguage => language.value;

  @override
  void onInit() async {
    setInitialLocalLanguage();
    super.onInit();
  }

  // Retrieves and Sets language based on device settings
  setInitialLocalLanguage() {
    if (currentLanguageStore.value == '') {
      updateLanguage(ui.window.locale.languageCode);
    }
  }

  // Gets current language stored
  RxString get currentLanguageStore {
    language.value = store.read('language') ?? '';
    print('Current language stored: ${language.value}');
    return language;
  }

  // Gets the language locale app is set to
  Locale? get getLocale {
    if (currentLanguageStore.value == '') {
      final deviceLanguage = Get.deviceLocale?.languageCode;
      if (availableLocales.contains(deviceLanguage)) {
        language.value = deviceLanguage!;
        updateLanguage(deviceLanguage);
      } else {
        language.value = defaultLanguage;
        updateLanguage(defaultLanguage);
      }
    } else if (currentLanguageStore.value != '') {
      // Set the stored string country code to the locale
      return Locale(currentLanguageStore.value);
    }
    // Gets the default language key for the system.
    return Get.deviceLocale;
  }

  // Updates the language stored
  Future<void> updateLanguage(String value) async {
    language.value = value;
    await store.write('language', value);
    Get.updateLocale(Locale(language.value));
    update();
  }

  String getLanguageString(String languageCode) {
    switch (languageCode) {
      case 'en':
        return 'English';
      case 'it':
        return 'Italiano';
      case 'fr':
        return 'Français';
      case 'de':
        return 'Deutsch';
      case 'ru':
        return 'Русский';
      case 'zh':
        return '中文';
      case 'es':
        return 'Español';
      case 'pt':
        return 'Português';
      default:
        return 'English';
    }
  }

  List<Locale> supportedLocales() {
    return [
      Locale('en'),
      Locale('es'),
      Locale('fr'),
      Locale('de'),
      Locale('it'),
      Locale('pt'),
      Locale('ru'),
      Locale('zh'),
    ];
  }
}
