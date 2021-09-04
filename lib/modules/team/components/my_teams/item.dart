import 'package:flutter/material.dart';
import 'package:team_todo_app/constants/styles.dart';
import 'package:team_todo_app/modules/teams/model.dart';

class MyTeamItem extends StatelessWidget {
  final TeamModel team;
  final Function onPressed;
  final bool isSelected;

  const MyTeamItem({
    @required this.team,
    @required this.onPressed,
    @required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            Text(team.name, style: Styles.textTitle),
            if (isSelected) Icon(Icons.arrow_left_sharp, color: Colors.black45)
          ],
        ),
      ),
    );
  }
}
