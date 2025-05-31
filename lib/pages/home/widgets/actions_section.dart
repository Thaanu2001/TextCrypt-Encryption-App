import 'package:encrypt_decrypt_app/pages/home/widgets/save_text_popup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../../constants/string_constants.dart';
import '../../../controllers/home_controller.dart';

class ActionsSection extends GetView<HomeController> {
  const ActionsSection({Key? key}) : super(key: key);

  @override
  String? get tag => homeControllerTag;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
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
                  foregroundColor: Colors.grey,
                  backgroundColor: Color(0xff171717),
                ),
                child: Icon(
                  Icons.paste,
                  color: Colors.white,
                ),
                onPressed: () => controller.pasteFunction(),
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
                  foregroundColor: Colors.grey,
                  backgroundColor: Color(0xff171717),
                ),
                child: Icon(
                  Icons.backspace_outlined,
                  color: Colors.white,
                ),
                onPressed: () => controller.clearFunction(),
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
                  foregroundColor: Colors.grey,
                  backgroundColor: Color(0xff171717),
                ),
                child: Icon(
                  Icons.copy,
                  color:
                      (controller.isDone.value) ? Colors.white : Colors.white38,
                ),
                onPressed: (controller.isDone.value)
                    ? () => controller.copyFunction()
                    : null,
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
                  foregroundColor: Colors.grey,
                  backgroundColor: Color(0xff171717),
                ),
                child: Icon(
                  CupertinoIcons.share,
                  color:
                      (controller.isDone.value) ? Colors.white : Colors.white38,
                ),
                onPressed: (controller.isDone.value)
                    ? () => controller.shareFunction()
                    : null,
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
                  foregroundColor: Colors.grey,
                  backgroundColor: Color(0xff171717),
                ),
                child: Icon(
                  CupertinoIcons.bookmark,
                  color: (controller.canSaveText.value)
                      ? Colors.white
                      : Colors.white38,
                ),
                onPressed: (controller.canSaveText.value)
                    ? () => saveTextPopup(
                          context,
                          text: controller.textController.text,
                        )
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
