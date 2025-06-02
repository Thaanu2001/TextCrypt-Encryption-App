import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/export.dart';
import 'package:get/state_manager.dart';

import '../../components/custom_app_bar.dart';
import '../../constants/string_constants.dart';
import '../../constants/theme_constants.dart';
import '../../controllers/saved_texts_controller.dart';
import 'widgets/dropdown_options_widget.dart';
import 'widgets/export_import_options_widget.dart';
import 'widgets/saved_texts_ad_widget.dart';

class SavedTextsPage extends GetView<SavedTextsController> {
  const SavedTextsPage({super.key});

  @override
  String? get tag => savedTextsControllerTag;

  @override
  Widget build(BuildContext context) {
    controller.getSavedTexts();
    return Scaffold(
      appBar: CustomAppBar(
        title: 'saved_texts.Saved_Encryptions'.tr,
        toolbarHeight: 60,
        leadingIcon: Icons.arrow_back,
        leadingOnTap: () => Navigator.of(context).pop(),
        actionWidget: ExportImportOptionsWidget(),
      ),
      body: Obx(
        () => controller.isDataLoading.value
            ? Center(
                child: CircularProgressIndicator(
                  color: AppTheme.white,
                ),
              )
            : controller.savedTexts.isEmpty
                ? Center(
                    child: Text(
                      'saved_texts.No_saved_texts_found'.tr,
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppTheme.defaultPadding,
                          ),
                          child: Text(
                            'saved_texts.desc_1'.tr,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                        SizedBox(height: 14),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppTheme.defaultPadding,
                          ),
                          child: Text(
                            'saved_texts.desc_2'.tr,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                        SizedBox(height: 24),
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: controller.savedTexts.length,
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            final text = controller.savedTexts[index];
                            return Container(
                              margin: EdgeInsets.only(
                                left: AppTheme.defaultPadding,
                                right: AppTheme.defaultPadding,
                                bottom: 16,
                              ),
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: AppTheme.greyShade1,
                                borderRadius: BorderRadius.circular(
                                  AppTheme.defaultBorderRadius,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          text.description,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      DropdownOptionsWidget(text),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    text.text,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        SavedTextsAdWidget(),
                        SizedBox(
                          height: MediaQuery.paddingOf(context).bottom + 8,
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }
}
