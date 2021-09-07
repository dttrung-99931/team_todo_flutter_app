import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'app.dart';
import 'controller.dart';
import 'modules/error_handler/exception_handler.dart';
import 'modules/auth/controller.dart';
import 'global_binding.dart';

void main() async => startApp();

// Start app
// @param teamID if not null, then select the team by the teamID after app starting
void startApp({String teamID}) {
  // Run app in a zooned guarded to catch global exceptions
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await setup(teamID: teamID);

    var loginController = Get.find<AuthController>();
    if (loginController.hasLoggedIn()) {
      runApp(App("/"));
    } else {
      runApp(App("/auth"));
    }
  }, (error, stacktrace) {
    ExceptionHandler.handleAsyncError(error, stacktrace);
  });
}

Future<void> setup({String teamID}) async {
  // Setup error handler
  FlutterError.onError = ExceptionHandler.handleSyncError;
  // Setup error ui builder that builds ui to notify errors to users 
  ErrorWidget.builder = ExceptionHandler.errorWidgetBuilder;

  await Firebase.initializeApp();
  GlobalBinding().dependencies();

  // Handle selecting team
  if (teamID != null) {
    var mainController = Get.find<MainController>();
    await mainController.selectTeamByID(teamID);
  }
}
