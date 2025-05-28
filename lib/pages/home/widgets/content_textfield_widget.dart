import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/string_constants.dart';
import '../../../controllers/home_controller.dart';

class ContentTextfieldWidget extends GetView<HomeController> {
  const ContentTextfieldWidget({super.key});

  @override
  String? get tag => homeControllerTag;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller.textController,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.next,
      minLines: 8,
      maxLines: null,
      style: GoogleFonts.robotoMono(
        fontSize: 18,
        color: Colors.white,
        fontWeight: FontWeight.w400,
      ),
      decoration: new InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(5, 10, 5, 10),
        enabledBorder: OutlineInputBorder(
          borderSide: new BorderSide(
            color: Colors.transparent,
            width: 0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: new BorderSide(
            color: Colors.transparent,
            width: 0,
          ),
        ),
        isDense: true,
      ),
      onTap: () => controller.stopTextAnimationFunction(),
    );
  }
}
