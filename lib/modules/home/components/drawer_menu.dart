import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:team_todo_app/base/base_get_widget.dart';
import 'package:team_todo_app/constants/constants.dart';
import 'package:team_todo_app/constants/routes.dart';
import 'package:team_todo_app/constants/sizes.dart';
import 'package:team_todo_app/constants/styles.dart';
import 'package:team_todo_app/modules/auth/controller.dart';
import 'package:team_todo_app/modules/team/components/my_teams/my_teams.dart';

import '../controller.dart';

class HomeDrawerMenu extends BaseGetWidget<HomeController> {
  Future<void> showExitAlertDialog() async {
    showAlertDialog("Do you want to sign out?", () async {
      AuthController authController = Get.find();
      await authController.signOut();
      Get.toNamed('/auth');
    });
  }

  @override
  Widget build(BuildContext context) {
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
            Padding(
              padding: const EdgeInsets.all(Sizes.s8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  MyTeams(
                    onTeamSelected: (team) => Navigator.of(context).pop(),
                  ),
                  Row(
                    children: [
                      Icon(Icons.logout),
                      TextButton(
                        onPressed: showExitAlertDialog,
                        child: Text(
                          "Sign out",
                          style: Styles.textTitle,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
