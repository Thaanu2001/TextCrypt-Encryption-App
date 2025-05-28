import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'constants/theme_constants.dart';
import 'routes/routes.dart';

void main() {
  runApp(Main(initialRoute: Routes.initial));
}

class Main extends StatelessWidget {
  final String initialRoute;
  const Main({Key? key, required this.initialRoute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.transparent,
      ),
      child: GetMaterialApp(
        title: 'TextCrypt',
        debugShowCheckedModeBanner: false,
        defaultTransition: Transition.cupertino,
        initialRoute: initialRoute,
        getPages: Routes.pages,
        theme: AppTheme.appTheme,
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: const TextScaler.linear(1),
            ),
            child: child as Widget,
          );
        },
      ),
    );
  }
}
