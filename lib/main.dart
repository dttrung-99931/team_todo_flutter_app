import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:team_todo_app/exceptions/no_internet.dart';
import 'package:team_todo_app/utils/utils.dart';
import 'global_binding.dart';
import 'constants/constants.dart';
import 'modules/auth/controller.dart';
import 'modules/auth/pages.dart';
import 'modules/home/pages.dart';
import 'modules/team/pages.dart';

void main() async {
  // handling global error
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    FlutterError.onError = handleError;
    await init();
    injectDependencies();
    AuthController loginContrller = Get.find();
    if (loginContrller.hasLoggedIn()) {
      runApp(App("/"));
    } else {
      runApp(App("/auth"));
    }
  }, (error, stacktrace) {
    handleAsyncError(error);
  });
}

void handleAsyncError(Object error) {
  if (error is NoInternetException) {
    logd('No internet exception');
  } else {
    logd('Unknown exception $error');
  }
}

void handleError(FlutterErrorDetails details) {
  logd('Error $details');
}

Future<void> init() async {
  await Firebase.initializeApp();
}

void injectDependencies() {
  GlobalBinding().dependencies();
}

class App extends StatelessWidget {
  final String initialRoute;

  App(this.initialRoute);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: kPrimarySwatch),
    );
    return GetMaterialApp(
      initialRoute: initialRoute,
      getPages: [
        authPages,
        homePages,
        teamListPages,
      ],
      defaultTransition: Transition.cupertino,
      transitionDuration: Duration(milliseconds: 800),
      debugShowCheckedModeBanner: false,
      theme: kAppTheme,
    );
  }
}
