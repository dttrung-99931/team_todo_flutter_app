import 'package:flutter/material.dart';

import '../../base/base_get_widget.dart';
import 'components/my_team_list.dart';
import 'components/team_explore/team_explore.dart';
import 'controller.dart';

class TeamListScreen extends BaseGetWidget<TeamController> {
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
            MyTeamList(),
            TeamExplore(),
          ]),
        ),
      ),
    );
  }
}
