import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/string_constants.dart';
import '../../controllers/home_controller.dart';
import 'widgets/actions_section.dart';
import 'widgets/animated_text_widget.dart';
import 'widgets/content_textfield_widget.dart';
import 'widgets/encrypt_section.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  String? get tag => homeControllerTag;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          color: Color(0xff1e1e1f),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(
                  20,
                  MediaQuery.of(context).padding.top + 5,
                  20,
                  20,
                ),
                color: Color(0xff171717),
                width: double.infinity,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'TextCrypt - Encrypt Decrypt',
                    style: GoogleFonts.robotoMono(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              ActionsSection(),
              Flexible(
                fit: FlexFit.tight,
                child: Container(
                  margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  padding: EdgeInsets.all(15),
                  color: Color(0xff171717),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AnimatedTextWidget(),
                      Flexible(
                        fit: FlexFit.tight,
                        child: ContentTextfieldWidget(),
                      ),
                    ],
                  ),
                ),
              ),
              EncryptSection(),
            ],
          ),
        ),
      ),
    );
  }
}
