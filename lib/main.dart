import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'features/auth/auth-controller.dart';
import 'features/auth/auth_screen.dart';
import 'features/home/home_binding.dart';
import 'features/home/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  injectDependencies();
  LoginController loginContrller = Get.find();
  if (await loginContrller.hasLoggedIn()) {
    runApp(App("/"));
  } else {
    runApp(App("/login"));
  }
}

Future<void> init() async {
  await Firebase.initializeApp();
}

void injectDependencies() {
  Get.put(LoginController());
}

class App extends StatelessWidget {
  final String initialRoute;

  App(this.initialRoute);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: initialRoute,
      getPages: [
        GetPage(name: "/login", page: () => LoginScreen()),
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
      theme: ThemeData(
          primarySwatch: Colors.grey,
          scaffoldBackgroundColor: Colors.grey[300]),
    );
  }
}
