import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:team_todo_app/widgets/listview.dart';

import '../../model.dart';
import 'item.dart';

class TeamList extends StatelessWidget {
  final List<TeamModel> teams;
  final Function(TeamModel team) onTeamSelected;
  final String noDataTitle;

  const TeamList({
    @required this.teams,
    this.onTeamSelected,
    this.noDataTitle = '',
  });

  @override
  Widget build(BuildContext context) {
    return ListViewWidget(
      shrinkWrap: true,
      noDataTitle: noDataTitle,
      children: teams
          .map((e) => TeamItem(
                team: e,
                onTeamSelected: onTeamSelected,
              ))
          .toList(),
    );
  }
}
