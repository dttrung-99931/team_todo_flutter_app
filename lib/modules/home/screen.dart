import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:team_todo_app/constants/font_sizes.dart';
import 'package:team_todo_app/constants/routes.dart';
import 'package:team_todo_app/widgets/character_avatar.dart';
import '../../constants/sizes.dart';
import '../team/screen.dart';
import '../team/controller.dart';

import '../../base/base_get_widget.dart';
import '../../constants/constants.dart';
import 'components/drawer_menu.dart';
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
      endDrawer: HomeDrawerMenu(),
    ),);
  }

  Widget buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      leading: Container(
        padding: const EdgeInsets.all(Sizes.s10),
        child: Obx(() {
          return CharacterAvatar(
            name: _teamController.selectedTeam != null
                ? _teamController.selectedTeam.name
                : '.',
            color: kPrimarySwatch[400],
          );
        }),
      ),
      titleSpacing: Sizes.s2,
      title: Obx(
        () => _teamController.selectedTeam != null
            ? Text(
                _teamController.selectedTeam.name,
                style: TextStyle(
                  color: kPrimarySwatch,
                  fontSize: FontSizes.s20,
                ),
              )
            : buildProgressBar(),
      ),
      actions: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () {
                toNamedRelative(RouteNames.TEAM_SEARCH);
              },
              child: Container(
                margin: EdgeInsets.only(top: Sizes.s4),
                padding: EdgeInsets.all(Sizes.s8),
                child: Icon(
                  Icons.search,
                  color: kPrimarySwatch,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                scaffoldKey.currentState.openEndDrawer();
              },
              child: Container(
                padding: EdgeInsets.all(Sizes.s8),
                child: Icon(
                  Icons.menu,
                  color: kPrimarySwatch,
                  // size: 16,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
