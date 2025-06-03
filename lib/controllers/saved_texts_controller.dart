import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sqflite/sqflite.dart';

import '../constants/string_constants.dart';
import '../constants/theme_constants.dart';
import '../models/save_text_model.dart';
import '../pages/saved_texts/widgets/delete_confirmation_popup.dart';
import 'premium_controller.dart';

class SavedTextsController extends GetxController {
  final PremiumController premiumController =
      Get.find<PremiumController>(tag: premiumControllerTag);

  late Database db;
  final RxBool isDataLoading = false.obs;
  final RxList<SaveText> savedTexts = <SaveText>[].obs;

  BannerAd? savedTextsBannerAd;
  Rx<AdSize?> savedTextsBannerAdSize = Rx<AdSize?>(null);
  RxBool savedTextsBannerAdLoaded = false.obs;
  final adUnitId = savedTextsBannerAdId;

  @override
  void onInit() {
    super.onInit();
    premiumController.isPremium.listen((isPremium) {
      if (isPremium == true) {
        savedTextsBannerAd?.dispose();
      } else if (isPremium == false) {
        loadSavedTextsBannerAd();
      }
    });
    initiateDatabase();
  }

  @override
  void dispose() {
    db.close();
    savedTextsBannerAd?.dispose();
    super.dispose();
  }

  initiateDatabase() async {
    db = await openDatabase(
      join(await getDatabasesPath(), 'saved_texts.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE texts(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, text TEXT NOT NULL, description TEXT NOT NULL)',
        );
      },
      version: 1,
    );
  }

  Future<void> insertText(String text, String description) async {
    try {
      final SaveText saveText = SaveText(
        text: text,
        description: description,
      );
      await insertTextData(saveText);

      Get.snackbar(
        'saved_texts.Success'.tr,
        'saved_texts.Text_saved_successfully'.tr,
        backgroundColor: AppTheme.grey,
        colorText: AppTheme.white,
      );
    } catch (e) {
      Get.snackbar(
        'saved_texts.Error'.tr,
        'saved_texts.Failed_to_save_text'.tr,
        backgroundColor: AppTheme.grey,
        colorText: AppTheme.white,
      );
    }
  }

  Future<void> insertTextData(SaveText text) async {
    await db.insert(
      'texts',
      text.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> getSavedTexts() async {
    try {
      isDataLoading.value = true;
      savedTexts.clear();
      final List<Map<String, dynamic>> maps = await db.query('texts');
      print('Fetched saved texts: $maps');
      savedTexts.value = List.generate(maps.length, (i) {
        return SaveText.fromMap(maps[i]);
      });
      savedTexts.sort((a, b) => b.id!.compareTo(a.id!));
    } catch (e) {
      Get.snackbar(
        'saved_texts.Error',
        'saved_texts.Failed_to_load_saved_texts'.tr,
        backgroundColor: AppTheme.grey,
        colorText: AppTheme.white,
      );
    } finally {
      isDataLoading.value = false;
    }
  }

  Future<void> deleteText(int id) async {
    try {
      await db.delete(
        'texts',
        where: 'id = ?',
        whereArgs: [id],
      );
      savedTexts.removeWhere((text) => text.id == id);
      Get.snackbar(
        'saved_texts.Success'.tr,
        'saved_texts.Text_deleted_successfully'.tr,
        backgroundColor: AppTheme.grey,
        colorText: AppTheme.white,
      );
      await getSavedTexts();
    } catch (e) {
      Get.snackbar(
        'saved_texts.Error'.tr,
        'saved_texts.Failed_to_delete_text'.tr,
        backgroundColor: AppTheme.grey,
        colorText: AppTheme.white,
      );
    }
  }

  void handleDropdownAction(String value, SaveText text, Function view) {
    if (value == 'delete') {
      deleteConfirmationPopup(
        context: Get.context!,
        onDelete: () => deleteText(text.id!),
      );
    } else if (value == 'view') {
      Get.back();
      view();
    } else if (value == 'share') {
      SharePlus.instance.share(
        ShareParams(
          text: text.text,
          sharePositionOrigin: Rect.fromLTWH(
            0,
            0,
            MediaQuery.of(Get.context!).size.width,
            MediaQuery.of(Get.context!).size.height,
          ),
        ),
      );
    }
  }

  void loadSavedTextsBannerAd() async {
    final size = await AdSize.getInlineAdaptiveBannerAdSize(
      MediaQuery.sizeOf(Get.context!).width.truncate() - 32,
      MediaQuery.sizeOf(Get.context!).width.truncate() - 32,
    );

    BannerAd(
      adUnitId: adUnitId,
      request: const AdRequest(),
      size: size,
      listener: BannerAdListener(
        onAdLoaded: (ad) async {
          debugPrint('$ad loaded.');
          savedTextsBannerAd = ad as BannerAd;
          savedTextsBannerAdSize.value =
              await savedTextsBannerAd!.getPlatformAdSize();
          savedTextsBannerAdLoaded.value = true;
        },
        onAdFailedToLoad: (ad, err) {
          debugPrint('BannerAd failed to load: $err');
          ad.dispose();
        },
      ),
    )..load();
  }

  void exportSavedTexts() async {
    try {
      final String csvData = savedTexts
          .map((text) => '${text.text},${text.description}')
          .join('\n');
      final String fileName = 'textcrypt_saved_texts.csv';
      final Directory directory = Platform.isAndroid
          ? await getExternalStorageDirectory() ?? Directory.systemTemp
          : await getApplicationDocumentsDirectory();
      final File file = File(join(directory.path, fileName));
      await file.writeAsString(csvData);
      OpenFile.open(file.path);

      Get.snackbar(
        'saved_texts.Export_Successful'.tr,
        'saved_texts.Saved_texts_exported_to'.tr + ' $fileName',
        backgroundColor: AppTheme.grey,
        colorText: AppTheme.white,
      );
    } catch (e) {
      Get.snackbar(
        'saved_texts.Error'.tr,
        'saved_texts.Failed_to_export_saved_texts'.tr,
        backgroundColor: AppTheme.grey,
        colorText: AppTheme.white,
      );
    }
  }

  void selectSavedTextsFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['csv'],
      );

      if (result != null) {
        File file = File(result.files.single.path!);
        if (file.existsSync()) {
          importSavedTexts(file);
        } else {
          Get.snackbar(
            'saved_texts.File_Not_Found'.tr,
            'saved_texts.The_selected_file_does_not_exist'.tr,
            backgroundColor: AppTheme.grey,
            colorText: AppTheme.white,
          );
        }
      }
    } catch (e) {
      Get.snackbar(
        'saved_texts.Error'.tr,
        'saved_texts.Failed_to_select_file'.tr,
        backgroundColor: AppTheme.grey,
        colorText: AppTheme.white,
      );
    }
  }

  void importSavedTexts(File file) async {
    try {
      final String contents = await file.readAsString();
      final List<String> lines = contents.split('\n');
      for (String line in lines) {
        final List<String> parts = line.split(',');
        if (parts.length == 2) {
          final SaveText text = SaveText(
            text: parts[0],
            description: parts[1],
          );
          await insertTextData(text);
        }
      }
      Get.snackbar(
        'saved_texts.Import_Successful'.tr,
        'saved_texts.Saved_texts_imported_successfully'.tr,
        backgroundColor: AppTheme.grey,
        colorText: AppTheme.white,
      );
      await getSavedTexts();
    } catch (e) {
      Get.snackbar(
        'saved_texts.Error'.tr,
        'saved_texts.Failed_to_import_saved_texts'.tr,
        backgroundColor: AppTheme.grey,
        colorText: AppTheme.white,
      );
    }
  }
}
