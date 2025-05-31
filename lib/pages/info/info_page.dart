import 'package:encrypt_decrypt_app/components/custom_app_bar.dart';
import 'package:encrypt_decrypt_app/constants/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Info',
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
                  'TextCrypt is a simple and secure app for encrypting and decrypting text.',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "How TextCrypt Works",
                    style: GoogleFonts.notoSans(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "🔑 Step 1: Get the Password",
                    style: GoogleFonts.notoSans(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "The user enters a password. This will be used to generate a secure key.",
                    style: GoogleFonts.notoSans(fontSize: 16),
                  ),
                  SizedBox(height: 24),
                  Text(
                    "🧂 Step 2: Add Salt",
                    style: GoogleFonts.notoSans(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "We combine the password with a 'salt' (a random string) to make the result unique.",
                    style: GoogleFonts.notoSans(fontSize: 16),
                  ),
                  SizedBox(height: 24),
                  Text(
                    "🔁 Step 3: Strengthen the Password with PBKDF2",
                    style: GoogleFonts.notoSans(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "PBKDF2 uses SHA256 and 1000 rounds of hashing to make the password stronger and more secure.",
                    style: GoogleFonts.notoSans(fontSize: 16),
                  ),
                  SizedBox(height: 24),
                  Text(
                    "🧪 Step 4: Convert to Fixed-Length with MD5",
                    style: GoogleFonts.notoSans(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "The PBKDF2 result is hashed using MD5 to produce a 16-byte fixed-length key for AES.",
                    style: GoogleFonts.notoSans(fontSize: 16),
                  ),
                  SizedBox(height: 24),
                  Text(
                    "🗝️ Step 5: Create AES Key",
                    style: GoogleFonts.notoSans(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "We convert the MD5 result into a key suitable for AES encryption.",
                    style: GoogleFonts.notoSans(fontSize: 16),
                  ),
                  SizedBox(height: 24),
                  Text(
                    "🔒 Step 6: Encrypt the Text",
                    style: GoogleFonts.notoSans(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "The user's text is encrypted using AES and the key created above.",
                    style: GoogleFonts.notoSans(fontSize: 16),
                  ),
                  SizedBox(height: 24),
                  Text(
                    "📄 Final Output: Encrypted Text",
                    style: GoogleFonts.notoSans(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "The result looks like random characters and can only be decrypted using the correct password.",
                    style: GoogleFonts.notoSans(fontSize: 16),
                  ),
                ],
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
