import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:team_todo_app/utils/constants.dart';
import 'package:team_todo_app/utils/utils.dart';

import '../team_model.dart';

class TeamItem extends StatelessWidget {
  final TeamModel team;

  TeamItem(this.team);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/team', arguments: team);
      },
      child: Card(
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: _getRandomColor(),
          ),
          title: Text(team.name),
        ),
      ),
    );
  }

  Color _getRandomColor() {
    return kPrimarySwatch[(random(9) + 1) * 100];
  }
}
