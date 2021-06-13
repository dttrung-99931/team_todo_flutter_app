import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:team_todo_app/features/teams/team_model.dart';

import 'team_menu.dart';
import 'todo_board/todo_board.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [TeamMenu(), TodoBoard()],
    );
  }
}
