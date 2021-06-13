import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:team_todo_app/core/on_item_clicked.dart';
import 'package:team_todo_app/utils/constants.dart';
import 'package:team_todo_app/utils/utils.dart';

import 'member_model.dart';

class MemberItem extends StatelessWidget {
  final MemberModel member;
  final OnItemClicked<MemberModel> onMemberEdited;

  MemberItem({
    @required this.member,
    @required this.onMemberEdited,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (onMemberEdited != null) {
            onMemberEdited(member, ClickAction.Click);
          }
        },
        child: Card(
          child: ListTile(
            leading: Container(
              decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: member.isTeamOwner
                            ? kPrimarySwatch
                            : Colors.transparent,
                        width: 1)),
              ),
              child: CircleAvatar(
                backgroundColor: _getRandomColor(),
              ),
            ),
            title: Text(member.user.email),
            trailing: buildPopupMenuButton(),
            contentPadding: EdgeInsets.fromLTRB(
                kDefaultPadding, kDefaultPadding / 2, 0, kDefaultPadding / 2),
          ),
        ));
  }

  PopupMenuButton buildPopupMenuButton() {
    return PopupMenuButton(
      icon: Icon(Icons.more_vert_outlined),
      itemBuilder: (context) {
        return [buildPopupMenuItem('Remove', ClickAction.Remove)];
      },
      onSelected: (value) => onMemberEdited(member, value),
    );
  }

  PopupMenuItem buildPopupMenuItem(String title, ClickAction action) {
    return PopupMenuItem<ClickAction>(value: action, child: Text(title));
  }

  Color _getRandomColor() {
    return kPrimarySwatch[(random(9) + 1) * 100];
  }
}
