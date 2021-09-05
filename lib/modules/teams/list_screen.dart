import 'package:flutter/material.dart';

import '../../base/base_get_widget.dart';
import 'components/my_team_list.dart';
import '../team/components/team_search/screen.dart';
import '../team/controller.dart';

class TeamListScreen extends BaseGetWidget<TeamController> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // Test handling error
    // throw Exception('Exception from Team controller');
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
            TeamSearchScreen(),
          ]),
        ),
      ),
    );
  }
}
