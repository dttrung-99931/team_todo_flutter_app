import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:team_todo_app/modules/team/components/my_teams/my_teams.dart';
import '../../constants/sizes.dart';
import '../team/screen.dart';
import '../team/controller.dart';

import '../../base/base_get_widget.dart';
import '../../constants/constants.dart';
import '../auth/controller.dart';
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
}

