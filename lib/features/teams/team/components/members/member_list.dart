import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:team_todo_app/core/on_item_clicked.dart';

import 'member_item.dart';
import 'member_model.dart';

class MemberList extends StatelessWidget {
  MemberList({
    @required this.members,
    @required this.onMemberEdited,
    Key key,
  }) : super(key: key);

  final List<MemberModel> members;
  final OnItemClicked<MemberModel> onMemberEdited;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: members
          .map((e) => MemberItem(
                member: e,
                onMemberEdited: onMemberEdited,
              ))
          .toList(),
    );
  }
}
