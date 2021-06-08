import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:team_todo_app/utils/constants.dart';
import 'package:team_todo_app/utils/utils.dart';

import '../team_model.dart';

class TeamItem extends StatelessWidget {
  final TeamModel team;
  final Function(TeamModel team) onTeamSelected;

  TeamItem({@required this.team, this.onTeamSelected});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTeamSelected != null) {
          onTeamSelected(team);
        }
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
