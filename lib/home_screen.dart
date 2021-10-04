import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:encrypt_decrypt_app/icons/customicons_icons.dart';
import 'package:encrypt_decrypt_app/widgets/button_stripe.dart';
import 'package:encrypt_decrypt_app/widgets/password_stripe.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController textController = TextEditingController();
  bool stopTextAnimation = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
      ],
    );
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(
          statusBarBrightness:
              Brightness.dark // Dark == white status bar -- for IOS.
          ),
    );

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Color(0xff171717),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            color: Color(0xff1e1e1f),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(
                      20, MediaQuery.of(context).padding.top, 20, 20),
                  color: Color(0xff171717),
                  width: double.infinity,
                  child: Text(
                    'Encrypt Decrypt',
                    style: GoogleFonts.robotoMono(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ),
                ButtonStipe(),
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
                        AnimatedTextKit(
                          repeatForever: !stopTextAnimation,
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
                          onTap: () {
                            print("Tap Event");
                          },
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          child: TextField(
                            controller: textController,
                            keyboardType: TextInputType.multiline,
                            textInputAction: TextInputAction.next,
                            minLines: 8,
                            maxLines: null,
                            style: GoogleFonts.robotoMono(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w400),
                            decoration: new InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                              enabledBorder: OutlineInputBorder(
                                borderSide: new BorderSide(
                                    color: Colors.transparent, width: 0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: new BorderSide(
                                    color: Colors.transparent, width: 0),
                              ),
                              isDense: true,
                            ),
                            onTap: () =>
                                setState(() => stopTextAnimation = true),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                PasswrodStripe(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
