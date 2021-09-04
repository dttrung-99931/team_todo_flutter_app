import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'controller.dart';
import 'exceptions/no_internet.dart';
import 'utils/utils.dart';
import 'global_binding.dart';
import 'constants/constants.dart';
import 'modules/auth/controller.dart';
import 'modules/auth/pages.dart';
import 'modules/home/pages.dart';
import 'modules/teams/pages.dart';

void main() async => startApp();

// Start app
// @param teamID if not null, going imediately to team screen after app starting
void startApp({String teamID}) {
  // handling global error
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    FlutterError.onError = handleError;

    await setup(teamID: teamID);

    var loginContrller = Get.find<AuthController>();
    if (loginContrller.hasLoggedIn()) {
      runApp(App("/"));
    } else {
      runApp(App("/auth"));
    }
  }, (error, stacktrace) {
    handleAsyncError(error);
  });
}

// Setup global dependencies and data
Future<void> setup({String teamID}) async {
  await Firebase.initializeApp();
  GlobalBinding().dependencies();
  if (teamID != null) {
    var mainController = Get.find<MainController>();
    await mainController.selectTeamByID(teamID);
  }
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
