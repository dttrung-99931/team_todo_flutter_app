import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../../../../../base/on_item_clicked.dart';

import 'item.dart';
import '../model.dart';

class MemberList extends StatelessWidget {
  MemberList({
    @required this.members,
    @required this.onMemberEdited,
    Key key,
  }) : super(key: key);

  final List<MemberModel> members;
  final OnItemEdited<MemberModel> onMemberEdited;

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
