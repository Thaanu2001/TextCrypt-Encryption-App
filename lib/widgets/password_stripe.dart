import 'package:encrypt_decrypt_app/icons/customicons_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PasswrodStripe extends StatefulWidget {
  const PasswrodStripe({Key? key}) : super(key: key);

  @override
  State<PasswrodStripe> createState() => _PasswrodStripeState();
}

class _PasswrodStripeState extends State<PasswrodStripe> {
  bool _obscurePassword = true;

  //* Show Password
  void _showPassword() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
          20, 20, 20, MediaQuery.of(context).padding.bottom + 8),
      child: Row(
        children: [
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: TextFormField(
              // controller: password,
              autofillHints: [AutofillHints.newPassword],
              textInputAction: TextInputAction.done,
              // validator: (val) =>
              //     validatePassword(val as String),
              // autovalidateMode: (isValidated)
              // ? AutovalidateMode.onUserInteraction
              // : null,

              obscureText: _obscurePassword,
              style: GoogleFonts.robotoMono(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w400),
              decoration: new InputDecoration(
                hintText: 'Password',
                hintStyle: GoogleFonts.robotoMono(color: Colors.white38),
                contentPadding: EdgeInsets.fromLTRB(15, 10, 10, 10),
                enabledBorder: OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.white38, width: 1.5),
                  borderRadius: BorderRadius.circular(5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.white38, width: 2),
                  borderRadius: BorderRadius.circular(5),
                ),
                filled: true,
                isDense: true,
                fillColor: Color(0xff171717),
                suffixIcon: InkWell(
                  onTap: _showPassword,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Icon(
                      _obscurePassword ? Customicons.eye_off : Customicons.eye,
                      size: 18,
                      color: Colors.white38,
                    ),
                  ),
                ),
                suffixIconConstraints: BoxConstraints(
                  minWidth: 40,
                  maxHeight: 20,
                ),
              ),
            ),
          ),
          SizedBox(width: 15),
          TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              primary: Colors.grey,
              backgroundColor: Color(0xff171717),
            ),
            child: Icon(
              Icons.lock_outline_sharp,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
