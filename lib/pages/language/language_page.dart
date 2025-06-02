import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/custom_app_bar.dart';
import '../../constants/string_constants.dart';
import '../../constants/theme_constants.dart';
import '../../util/localization/language_controller.dart';

class LanguagePage extends GetView<LanguageController> {
  LanguagePage({super.key});

  @override
  String? get tag => languageControllerTag;

  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'language.Change_Language'.tr,
        toolbarHeight: 60,
        leadingIcon: Icons.arrow_back,
        leadingOnTap: () => Navigator.of(context).pop(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.defaultPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Text(
              'language.Select_your_preferred_language'.tr,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 20),
            DropdownButtonHideUnderline(
              child: DropdownButton2<String>(
                isExpanded: true,
                hint: Text(
                  'language.Select_your_preferred_language'.tr,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppTheme.white,
                  ),
                ),
                items: controller.availableLocales
                    .map((item) => DropdownMenuItem(
                          value: item,
                          child: Text(
                            controller.getLanguageString(item),
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppTheme.white,
                            ),
                          ),
                        ))
                    .toList(),
                value: controller.currentLanguage,
                onChanged: (value) {
                  if (value != null) {
                    print(value);
                    controller.updateLanguage(value);
                  }
                },
                iconStyleData: IconStyleData(
                  icon: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: AppTheme.white,
                    size: 20,
                  ),
                ),
                buttonStyleData: ButtonStyleData(
                  padding: EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    color: AppTheme.greyShade1,
                    borderRadius: BorderRadius.circular(
                      AppTheme.defaultBorderRadius,
                    ),
                  ),
                ),
                dropdownStyleData: const DropdownStyleData(
                  decoration: BoxDecoration(
                    color: AppTheme.greyShade1,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                ),
                menuItemStyleData: const MenuItemStyleData(
                  height: 50,
                ),
                dropdownSearchData: DropdownSearchData(
                  searchController: textEditingController,
                  searchInnerWidgetHeight: 70,
                  searchInnerWidget: Container(
                    height: 70,
                    padding: const EdgeInsets.only(
                      top: 8,
                      bottom: 4,
                      right: 8,
                      left: 8,
                    ),
                    child: TextFormField(
                      expands: true,
                      maxLines: null,
                      controller: textEditingController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                        hintText: 'language.Search_for_language'.tr,
                        hintStyle: const TextStyle(
                          fontSize: 14,
                          color: AppTheme.white,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  searchMatchFn: (item, searchValue) {
                    return item.value.toString().contains(searchValue);
                  },
                ),
                onMenuStateChange: (isOpen) {
                  if (!isOpen) {
                    textEditingController.clear();
                  }
                },
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'language.note'.tr,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
