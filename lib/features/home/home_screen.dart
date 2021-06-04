import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'components/body.dart';
import 'home_controller.dart';

class HomeScreen extends GetWidget<HomeController> {
  final globalkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      key: globalkey,
      body: Body(),
      appBar: _buildAppBar(),
    ));
  }

  Widget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: Colors.grey[500]),
        ),
      ),
      title: Text("Sale management", style: TextStyle(color: Colors.black)),
      actions: [
        IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            globalkey.currentState.openEndDrawer();
          },
        )
      ],
    );
  }

  // Widget _buildDrawer() {
  //   return Container(
  //     width: 220,
  //     child: Drawer(
  //       child: ListView(
  //         children: [
  //           DrawerHeader(
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Obx(
  //                   () => Text(
  //                     controller.user?.supermarketName ?? "[Supermarket name]",
  //                     style: TextStyle(fontSize: 22),
  //                   ),
  //                 ),
  //                 Obx(() => Text(
  //                       controller.user?.username ?? "[Employee name]",
  //                       style: TextStyle(
  //                           fontSize: 18,
  //                           fontWeight: FontWeight.w300,
  //                           fontStyle: FontStyle.italic),
  //                     )),
  //               ],
  //             ),
  //             decoration: BoxDecoration(
  //               color: Colors.grey[400],
  //             ),
  //           ),
  //           ListTile(
  //               onTap: () {
  //                 _showExitAlertDialog();
  //               },
  //               title: Text(
  //                 "Sign out",
  //                 style: TextStyle(fontSize: 16),
  //               )),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // void _showExitAlertDialog() {
  //   var alertDialog = AlertDialog(
  //     actions: [
  //       TextButton(
  //         onPressed: () async {
  //           LoginController loginController = Get.find();
  //           await loginController.signOut();
  //           Get.toNamed("/login");
  //         },
  //         child: Text("OK"),
  //       )
  //     ],
  //     title: Text("Do you want to sign out?"),
  //   );
  //   Get.dialog(alertDialog);
  // }
}
