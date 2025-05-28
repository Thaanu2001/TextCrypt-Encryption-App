import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/string_constants.dart';
import '../../../controllers/home_controller.dart';

class AnimatedTextWidget extends GetView<HomeController> {
  const AnimatedTextWidget({super.key});

  @override
  String? get tag => homeControllerTag;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AnimatedTextKit(
        controller: controller.textAnimationController,
        repeatForever: !controller.stopTextAnimation.value,
        totalRepeatCount: 1,
        animatedTexts: [
          TypewriterAnimatedText(
            'Enter your text',
            textStyle: GoogleFonts.robotoMono(
              fontSize: 20,
              color: Colors.white,
            ),
            speed: Duration(milliseconds: 100),
          ),
        ],
      ),
    );
  }
}
