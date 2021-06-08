import 'package:flutter/material.dart';
import 'package:team_todo_app/core/base_get_widget.dart';
import 'components/my_teams.dart';
import 'team_exploration/team_explore.dart';
import 'teams_controller.dart';

class TeamsScreen extends BaseGetWidget<TeamsController> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Teams"),
            bottom: TabBar(
              tabs: [
                Tab(
                  child: Text('My teams'),
                ),
                Tab(
                  child: Text('Explore'),
                )
              ],
            ),
          ),
          body: TabBarView(children: [
            MyTeams(),
            TeamExplore(),
          ]),
        ),
      ),
    );
  }
}
