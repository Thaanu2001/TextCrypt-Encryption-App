import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:encrypt_decrypt_app/pbkdf2.dart';
import 'package:encrypt_decrypt_app/widgets/button_stripe.dart';
import 'package:encrypt_decrypt_app/widgets/password_stripe.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share/share.dart';
import 'package:crypto/crypto.dart';

TextEditingController passController = TextEditingController();

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController textController = TextEditingController();
  bool stopTextAnimation = false;
  bool isDone = false;

  void pasteFunction() async {
    FocusManager.instance.primaryFocus?.unfocus();
    ClipboardData? cdata = await Clipboard.getData(Clipboard.kTextPlain);
    if (cdata != null) textController.text = cdata.text as String;
    print(cdata!.text);
  }

  void clearFunction() {
    FocusManager.instance.primaryFocus?.unfocus();
    textController.text = '';
    passController.text = '';

    setState(() {
      isDone = false;
    });
  }

  void copyFunction() {
    FocusManager.instance.primaryFocus?.unfocus();
    Clipboard.setData(ClipboardData(text: textController.text));
  }

  void shareFunction() {
    FocusManager.instance.primaryFocus?.unfocus();
    Share.share(textController.text);
  }

  void encryptText() {
    if (passController.text != '' && textController.text != '') {
      final iv = encrypt.IV.fromLength(16);

      //* Create PBKDF2 instance using the SHA256 hash
      var gen = new PBKDF2(hash: sha256);

      //* Generate a 32 byte key using the given password and salt, with 1000 iterations
      var keyPBKDF2 = gen.generateKey(passController.text, "salt", 1000, 32);

      //* Digest the generated PBKDF2 Key
      var digest = md5.convert(keyPBKDF2);
      print(digest.toString());

      //* generate key using digested md5
      final key = encrypt.Key.fromUtf8(digest.toString());

      final encrypter =
          encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.ecb));

      final encrypted = encrypter.encrypt(textController.text, iv: iv);

      textController.text = encrypted.base64;

      setState(() {
        isDone = true;
      });
    } else {
      showCupertinoDialog<void>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('Empty Fields'),
          content: const Text('Please enter both text and password to encrypt'),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    }
  }

  void decryptText() {
    if (passController.text != '' && textController.text != '') {
      try {
        final iv = encrypt.IV.fromLength(16);

        //* Create PBKDF2 instance using the SHA256 hash
        var gen = new PBKDF2(hash: sha256);

        //* Generate a 32 byte key using the given password and salt, with 1000 iterations
        var keyPBKDF2 = gen.generateKey(passController.text, "salt", 1000, 32);

        //* Digest the generated PBKDF2 Key
        var digest = md5.convert(keyPBKDF2);

        //* generate key using digested md5
        final key = encrypt.Key.fromUtf8(digest.toString());

        final encrypter =
            encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.ecb));

        final decrypted = encrypter.decrypt64(textController.text, iv: iv);
        textController.text = decrypted;

        setState(() {
          isDone = true;
        });
      } catch (e) {
        print(e);
        //* Password wrong popup
        if (e.toString() ==
            'Invalid argument(s): Invalid or corrupted pad block') {
          showCupertinoDialog<void>(
            context: context,
            builder: (BuildContext context) => CupertinoAlertDialog(
              title: const Text('Wrong Password'),
              content: const Text('Password you entered does not match'),
              actions: <CupertinoDialogAction>[
                CupertinoDialogAction(
                  child: const Text('Ok'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        } else {
          showCupertinoDialog<void>(
            context: context,
            builder: (BuildContext context) => CupertinoAlertDialog(
              title: const Text('Invalid Input'),
              content: const Text('Invalid text or password entered'),
              actions: <CupertinoDialogAction>[
                CupertinoDialogAction(
                  child: const Text('Ok'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        }
      }
    } else {
      showCupertinoDialog<void>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('Empty Fields'),
          content: const Text('Please enter both text and password to decrypt'),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    }
  }

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
        body: Container(
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
                  'RayGun - Encrypt Decrypt',
                  style: GoogleFonts.robotoMono(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ),
              ButtonStipe(
                paste: () => pasteFunction(),
                clear: () => clearFunction(),
                copy: () => copyFunction(),
                share: () => shareFunction(),
                isDone: isDone,
              ),
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
                          onTap: () => setState(() => stopTextAnimation = true),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              PasswrodStripe(
                  encrypt: () => encryptText(), decrypt: () => decryptText()),
            ],
          ),
        ),
      ),
    );
  }
}
