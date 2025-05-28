import 'package:flutter/material.dart';

import '../../constants/theme_constants.dart';

customPopup({
  required BuildContext context,
  required String topic,
  Widget? body,
  double? width,
  Widget Function(BuildContext)? builder,
}) {
  return showDialog(
    context: context,
    useRootNavigator: false,
    builder: (BuildContext context) {
      return Container(
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.center,
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: AlertDialog(
            backgroundColor: AppTheme.backgroundColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(AppTheme.defaultBorderRadius),
              ),
            ),
            contentPadding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
            content: SizedBox(
              width: MediaQuery.of(context).size.width *
                  ((width == null) ? 0.5 : width),
              child: Column(
                children: [
                  //* Close Button
                  Container(
                    alignment: Alignment.topRight,
                    padding: const EdgeInsets.fromLTRB(10, 5, 5, 0),
                    // margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: InkWell(
                      child: Icon(
                        Icons.close_rounded,
                        color: AppTheme.white,
                      ),
                      onTap: () => Navigator.pop(context),
                    ),
                  ),
                  //* Topic
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: Text(
                      topic,
                      style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  body ?? builder!(context),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
