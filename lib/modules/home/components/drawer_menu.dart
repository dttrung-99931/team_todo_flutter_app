import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:team_todo_app/base/base_get_widget.dart';
import 'package:team_todo_app/constants/constants.dart';
import 'package:team_todo_app/constants/images.dart';
import 'package:team_todo_app/constants/routes.dart';
import 'package:team_todo_app/constants/sizes.dart';
import 'package:team_todo_app/constants/styles.dart';
import 'package:team_todo_app/modules/auth/controller.dart';
import 'package:team_todo_app/modules/team/components/my_teams/my_teams.dart';
import 'package:team_todo_app/modules/user/controller.dart';
import 'package:team_todo_app/widgets/character_avatar.dart';
import 'package:team_todo_app/widgets/composed_button.dart';
import 'package:team_todo_app/widgets/language_switch.dart';

import '../controller.dart';

class HomeDrawerMenu extends BaseGetWidget<HomeController> {
  final _userController = Get.find<UserController>();

  Future<void> showExitAlertDialog() async {
    showAlertDialog('confirm-sign-out'.tr, () async {
      AuthController authController = Get.find();
      await authController.signOut();

      // Navigate to auth screen by
      // removing all current routes and push the auth route the nav stack
      Navigator.of(Get.context).popUntil((route) => false);
      Navigator.of(Get.context).pushNamed(RouteNames.AUTH);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      child: Drawer(
        child: ListView(
          children: [
            buildDrawerHeader(),
            buildDrawerMenu(),
          ],
        ),
      ),
    );
  }

  Padding buildDrawerMenu() {
    return Padding(
      padding: const EdgeInsets.all(Sizes.s8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          MyTeams(
            onTeamSelected: (team) => Get.back(),
          ),
          SizedBox(height: Sizes.s4),
          Row(
            children: [
              Expanded(
                child: ComposedButtonWidget(
                  iconData: Icons.logout,
                  title: 'sign-out'.tr,
                  onPressed: showExitAlertDialog,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  DrawerHeader buildDrawerHeader() {
    return DrawerHeader(
      padding: EdgeInsets.all(Sizes.s12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Obx(() {
            return Row(
              children: [
                CharacterAvatar(name: _userController.user.email),
                SizedBox(width: Sizes.s8),
                Text(
                  _userController.user.email,
                  style: Styles.textTitle.copyWith(color: Colors.white70),
                ),
              ],
            );
          }),
          Align(
            alignment: Alignment.centerRight,
            child: LanguageSwitch(),),
        ],
      ),
      decoration: BoxDecoration(
        color: kPrimarySwatch,
      ),
    );
  }
}
