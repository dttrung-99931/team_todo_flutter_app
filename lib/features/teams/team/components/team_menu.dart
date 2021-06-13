import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:team_todo_app/core/base_get_widget.dart';

import '../../teams_controller.dart';

class TeamMenu extends BaseGetWidget<TeamsController> {
  TeamMenu({Key key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildMenuItem("Members", Icons.people_outlined, () {
                Get.toNamed('/team/members');
              }),
              _buildMenuItem("Join requests", Icons.person_add_alt_1_outlined,
                  () {
                Get.toNamed('/team/join-requests',
                    arguments: controller.selectedTeam);
              }),
              _buildMenuItem(
                  "Notifications", Icons.notifications_outlined, () {}),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(String title, IconData iconData, Function onTap) {
    return Card(
      elevation: 6,
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(shape: BoxShape.circle),
          width: 96,
          height: 96,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconData,
                size: 36,
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                title,
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
