import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:team_todo_app/translation/app_translation.dart';
import 'constants/constants.dart';
import 'modules/auth/pages.dart';
import 'modules/home/pages.dart';

class App extends StatelessWidget {
  final String initialRoute;

  App(this.initialRoute);

  @override
  Widget build(BuildContext context) {
    // Change status bar bg color
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: kPrimarySwatch),
    );
    return GetMaterialApp(
      initialRoute: initialRoute,
      getPages: [
        authPages,
        homePages,
      ],
      defaultTransition: Transition.cupertino,
      transitionDuration: Duration(milliseconds: 800),
      debugShowCheckedModeBanner: false,
      theme: kAppTheme,
      // Config translation
      translations: AppTranslation(),
      locale: AppTranslation.defaultLocale,
    );
  }
}
