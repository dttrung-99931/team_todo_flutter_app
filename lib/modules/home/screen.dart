import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../base/base_get_widget.dart';
import '../../constants/constants.dart';
import '../auth/controller.dart';
import 'components/body.dart';
import 'controller.dart';

class HomeScreen extends BaseGetWidget<HomeController> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      key: scaffoldKey,
      body: Body(),
      appBar: buildAppBar(),
      endDrawer: buildDrawer(),
    ));
  }

  Widget buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: kPrimarySwatch),
        ),
      ),
      title: Text("Team todo app", style: TextStyle(color: kPrimarySwatch)),
      actions: [
        IconButton(
          icon: Icon(
            Icons.menu,
            color: kPrimarySwatch,
          ),
          onPressed: () {
            scaffoldKey.currentState.openEndDrawer();
          },
        )
      ],
    );
  }

  Widget buildDrawer() {
    return Container(
      width: 220,
      child: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [],
              ),
              decoration: BoxDecoration(
                color: kPrimarySwatch,
              ),
            ),
            ListTile(
                onTap: showExitAlertDialog,
                title: Text(
                  "Sign out",
                  style: TextStyle(fontSize: 16),
                )),
          ],
        ),
      ),
    );
  }

  Future<void> showExitAlertDialog() async {
    showAlertDialog("Do you want to sign out?", () async {
      AuthController authController = Get.find();
      await authController.signOut();
      Get.toNamed('/auth');
    });
  }
}
