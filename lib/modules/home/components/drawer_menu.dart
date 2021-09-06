import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:team_todo_app/base/base_get_widget.dart';
import 'package:team_todo_app/constants/constants.dart';
import 'package:team_todo_app/constants/routes.dart';
import 'package:team_todo_app/constants/sizes.dart';
import 'package:team_todo_app/constants/styles.dart';
import 'package:team_todo_app/modules/auth/controller.dart';
import 'package:team_todo_app/modules/team/components/my_teams/my_teams.dart';
import 'package:team_todo_app/modules/user/controller.dart';
import 'package:team_todo_app/widgets/character_avatar.dart';

import '../controller.dart';

class HomeDrawerMenu extends BaseGetWidget<HomeController> {
  final _userController = Get.find<UserController>();

  Future<void> showExitAlertDialog() async {
    showAlertDialog("Do you want to sign out?", () async {
      AuthController authController = Get.find();
      await authController.signOut();
      
      // Navigate to auth screen by 
      // removing all current routes and push the auth route the nav stack
      Get.offNamedUntil(RouteNames.AUTH, (route) => true);
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
                  title: 'Sign out',
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
          })
        ],
      ),
      decoration: BoxDecoration(
        color: kPrimarySwatch,
      ),
    );
  }
}

class ComposedButtonWidget extends StatelessWidget {
  final IconData iconData;
  final Function onPressed;
  final double iconSize;
  final Color color;
  final EdgeInsets padding;
  final String title;

  const ComposedButtonWidget({
    @required this.iconData,
    @required this.title,
    this.onPressed,
    this.iconSize = Sizes.s20,
    this.color = kPrimarySwatch,
    this.padding = const EdgeInsets.all(Sizes.s4),
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: padding,
        child: Row(
          children: [
            if (iconData != null) Icon(iconData, size: iconSize),
            if (iconData != null) SizedBox(width: Sizes.s8),
            Text(
              title,
              style: Styles.textTitle.copyWith(
                color: kPrimarySwatch,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
