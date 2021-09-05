import 'package:flutter/material.dart';
import 'package:team_todo_app/constants/font_sizes.dart';
import 'package:team_todo_app/constants/sizes.dart';
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
        padding: EdgeInsets.only(
          left: Sizes.s8,
          right: Sizes.s8,
          bottom: Sizes.s8,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              team.name,
              style: Styles.textTitle.copyWith(
                fontWeight: isSelected ? FontWeight.w400 : FontWeight.w300,
                fontSize: FontSizes.s14,
              ),
            ),
            if (isSelected) Icon(Icons.arrow_left_sharp, color: Colors.black45)
          ],
        ),
      ),
    );
  }
}
