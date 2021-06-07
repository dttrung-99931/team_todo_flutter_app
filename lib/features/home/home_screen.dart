import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:team_todo_app/core/base_get_widget.dart';
import 'package:team_todo_app/features/auth/auth_controller.dart';
import 'package:team_todo_app/utils/constants.dart';
import 'components/body.dart';
import 'home_controller.dart';

class HomeScreen extends BaseGetWidget<HomeController> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      key: scaffoldKey,
      body: Body(),
      appBar: _buildAppBar(),
      endDrawer: _buildDrawer(),
    ));
  }

  Widget _buildAppBar() {
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

  Widget _buildDrawer() {
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
                onTap: _showExitAlertDialog,
                title: Text(
                  "Sign out",
                  style: TextStyle(fontSize: 16),
                )),
          ],
        ),
      ),
    );
  }

  Future<void> _showExitAlertDialog() async {
    showAlertDialog("Do you want to sign out?", () {
      AuthController authController = Get.find();
      authController.signOut();
      Get.toNamed('/auth');
    });
  }
}
