import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:team_todo_app/base/base_get_widget.dart';
import 'package:team_todo_app/modules/setting/controller.dart';
import 'package:team_todo_app/translation/app_translation.dart';
import 'constants/constants.dart';
import 'modules/auth/pages.dart';
import 'modules/home/pages.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class App extends BaseGetWidget<SettingController> {
  final String initialRoute;

  App(this.initialRoute);

  @override
  Widget build(BuildContext context) {
    // Change status bar bg color
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: kPrimarySwatch),
    );

    // Wrap GetMaterialApp with ScreenUtilInit to use scale ui units in GetMaterialApp's widget children:
    // 10.w -> 10 scale with units
    // 10.h -> 10 scale height units
    // 10.r -> 10 scale radius units
    // 10.sp -> 10 scale fontsize units
    // 0.3.sw -> 30% size of width
    // 0.2.sh -> 30% size of height
    return ScreenUtilInit(
      builder: () => GetMaterialApp(
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
        locale: controller.currentLocale,
      ),
    );
  }
}
