import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'constants/constants.dart';
import 'modules/auth/binding.dart';
import 'modules/auth/controller.dart';
import 'modules/auth/pages.dart';
import 'modules/home/pages.dart';
import 'modules/team/team_preview/screen.dart';
import 'modules/team/pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  injectDependencies();
  AuthController loginContrller = Get.find();
  if (loginContrller.hasLoggedIn()) {
    runApp(App("/"));
  } else {
    runApp(App("/auth"));
  }
}

Future<void> init() async {
  await Firebase.initializeApp();
}

void injectDependencies() {
  AuthBinding().dependencies();
}

class App extends StatelessWidget {
  final String initialRoute;

  App(this.initialRoute);

  @override
  Widget build(BuildContext context) {
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
