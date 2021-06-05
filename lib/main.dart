import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'features/auth/auth-controller.dart';
import 'features/auth/auth_binding.dart';
import 'features/auth/auth_screen.dart';
import 'features/home/home_binding.dart';
import 'features/home/home_screen.dart';
import 'utils/constants.dart';

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
        GetPage(name: "/auth", page: () => AuthScreen()),
        GetPage(
          name: "/",
          page: () => HomeScreen(),
          binding: HomeBinding(),
        ),
        // GetPage(
        //   name: "/orders",
        //   page: () => OrdersScreen(),
        // ),
        // GetPage(
        //   name: "/order-detail",
        //   page: () => OrderDetailScreen(),
        // ),
      ],
      defaultTransition: Transition.cupertino,
      transitionDuration: Duration(milliseconds: 800),
      debugShowCheckedModeBanner: false,
      theme: kAppTheme,
    );
  }
}
