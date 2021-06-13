import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:team_todo_app/features/teams/team/components/todo_board/finish.dart';
import 'package:team_todo_app/utils/constants.dart';

import 'doing.dart';
import 'todo.dart';

class TodoBoard extends StatelessWidget {
  const TodoBoard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: DefaultTabController(
            length: 3,
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  child: TabBar(tabs: [
                    Tab(child: Text('Todo')),
                    Tab(child: Text('Doing')),
                    Tab(child: Text('Finish')),
                  ], labelColor: Colors.black),
                ),
                SizedBox(
                  height: kDefaultPadding / 2,
                ),
                Expanded(
                  child: TabBarView(children: [
                    Todo(),
                    Doing(),
                    Finish(),
                  ]),
                )
              ],
            )),
      ),
    );
  }
}
