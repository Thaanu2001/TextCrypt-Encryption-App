import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ButtonStipe extends StatelessWidget {
  final Function paste;
  final Function clear;
  final Function copy;
  final Function share;
  final bool isDone;
  const ButtonStipe({
    Key? key,
    required this.paste,
    required this.clear,
    required this.copy,
    required this.share,
    required this.isDone,
  }) : super(key: key);

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
              onPressed: () => paste(),
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
              onPressed: () => clear(),
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
                color: (isDone) ? Colors.white : Colors.white38,
              ),
              onPressed: (isDone) ? () => copy() : null,
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
                CupertinoIcons.share,
                color: (isDone) ? Colors.white : Colors.white38,
              ),
              onPressed: (isDone) ? () => share() : null,
            ),
          ),
        ],
      ),
    );
  }
}
