import 'package:flutter/material.dart';

class ButtonStipe extends StatelessWidget {
  const ButtonStipe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: Row(
        children: [
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                primary: Colors.grey,
                backgroundColor: Color(0xff171717),
              ),
              child: Icon(
                Icons.paste,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ),
          SizedBox(width: 15),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                primary: Colors.grey,
                backgroundColor: Color(0xff171717),
              ),
              child: Icon(
                Icons.backspace_outlined,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ),
          SizedBox(width: 15),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                primary: Colors.grey,
                backgroundColor: Color(0xff171717),
              ),
              child: Icon(
                Icons.copy,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ),
          SizedBox(width: 15),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                primary: Colors.grey,
                backgroundColor: Color(0xff171717),
              ),
              child: Icon(
                Icons.share_outlined,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
