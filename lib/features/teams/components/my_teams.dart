import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:team_todo_app/features/teams/components/upsert_team_dialog.dart';

import 'team_list.dart';

class MyTeams extends StatelessWidget {
  const MyTeams({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Get.dialog(UpsertTeamDialog());
            }),
        body: TeamList());
  }
}
