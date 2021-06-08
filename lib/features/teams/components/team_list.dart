import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../team_model.dart';
import 'team_item.dart';

class TeamList extends StatelessWidget {
  final List<TeamModel> teams;
  final Function(TeamModel team) onTeamSelected;
  const TeamList({@required this.teams, this.onTeamSelected});

  @override
  Widget build(BuildContext context) {
    print('build team list');
    return _buildTeamList();
  }

  Widget _buildTeamList() {
    return teams.length != 0
        ? ListView(
            children: teams
                .map((e) => TeamItem(
                      team: e,
                      onTeamSelected: onTeamSelected,
                    ))
                .toList(),
          )
        : Center(
            child: Text('No teams'),
          );
  }
}
