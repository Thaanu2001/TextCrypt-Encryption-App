import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../components/custom_app_bar.dart';
import '../../constants/theme_constants.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'info.Info'.tr,
        toolbarHeight: 60,
        leadingIcon: Icons.arrow_back,
        leadingOnTap: () => Navigator.of(context).pop(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppTheme.defaultPadding,
          ),
          child: Column(
            children: [
              SizedBox(height: 10),
              Center(
                child: Image.asset(
                  'assets/logo.png',
                  width: 100,
                  height: 100,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'TextCrypt',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'info.TextCrypt_is_a_simple_and_secure_app_for_encrypting_and_decrypting_text'
                      .tr,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "info.How_TextCrypt_Works".tr,
                    style: GoogleFonts.notoSans(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "🔑 " + "info.Step_1".tr,
                    style: GoogleFonts.notoSans(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "info.Step_1_desc".tr,
                    style: GoogleFonts.notoSans(fontSize: 16),
                  ),
                  SizedBox(height: 24),
                  Text(
                    "🧂 " + "info.Step_2".tr,
                    style: GoogleFonts.notoSans(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "info.Step_2_desc".tr,
                    style: GoogleFonts.notoSans(fontSize: 16),
                  ),
                  SizedBox(height: 24),
                  Text(
                    "🔁 " + "info.Step_3".tr,
                    style: GoogleFonts.notoSans(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "info.Step_3_desc".tr,
                    style: GoogleFonts.notoSans(fontSize: 16),
                  ),
                  SizedBox(height: 24),
                  Text(
                    "🧪 " + "info.Step_4".tr,
                    style: GoogleFonts.notoSans(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "info.Step_4_desc".tr,
                    style: GoogleFonts.notoSans(fontSize: 16),
                  ),
                  SizedBox(height: 24),
                  Text(
                    "🗝️ " + "info.Step_5".tr,
                    style: GoogleFonts.notoSans(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "info.Step_5_desc".tr,
                    style: GoogleFonts.notoSans(fontSize: 16),
                  ),
                  SizedBox(height: 24),
                  Text(
                    "🔒 " + "info.Step_6".tr,
                    style: GoogleFonts.notoSans(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "info.Step_6_desc".tr,
                    style: GoogleFonts.notoSans(fontSize: 16),
                  ),
                  SizedBox(height: 24),
                  Text(
                    "📄 " + "info.Step_7".tr,
                    style: GoogleFonts.notoSans(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "info.Step_7_desc".tr,
                    style: GoogleFonts.notoSans(fontSize: 16),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'info.contact'.tr,
                style: GoogleFonts.notoSans(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'Developed by Eleetra (Private) Limited',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: AppTheme.greyTint2,
                    ),
              ),
              SizedBox(height: 8),
              Text(
                '© 2024 All rights reserved',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: AppTheme.greyTint2,
                    ),
              ),
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
