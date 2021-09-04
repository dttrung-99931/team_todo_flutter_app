import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:team_todo_app/constants/sizes.dart';
import 'package:team_todo_app/modules/nteam/screen.dart';
import 'package:team_todo_app/modules/nteam/controller.dart';

import '../../base/base_get_widget.dart';
import '../../constants/constants.dart';
import '../auth/controller.dart';
import 'controller.dart';

class HomeScreen extends BaseGetWidget<HomeController> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _teamController = Get.find<TeamController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      key: scaffoldKey,
      body: Obx(
        () => _teamController.selectedTeam != null
            ? Padding(
                padding: const EdgeInsets.only(top: Sizes.s4),
                child: TeamScreen(),
              )
            : buildCenterProgressBar(),
      ),
      appBar: buildAppBar(),
      endDrawer: buildDrawer(),
    ));
  }

  Widget buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      leading: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
        child: Padding(
          padding: const EdgeInsets.all(1),
          child: CircleAvatar(
            backgroundColor: kPrimarySwatch,
            child: Text('T'),
          ),
        ),
      ),
      title: Obx(
        () => _teamController.selectedTeam != null
            ? Text(
                _teamController.selectedTeam.name,
                style: TextStyle(color: kPrimarySwatch),
              )
            : buildProgressBar(),
      ),
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
