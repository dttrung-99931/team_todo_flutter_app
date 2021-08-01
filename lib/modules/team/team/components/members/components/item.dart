import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/state_manager.dart';

import '../../../../../../base/on_item_clicked.dart';
import '../../../../../../constants/constants.dart';
import '../../../../../../utils/utils.dart';
import '../model.dart';
import '../controller.dart';

class MemberItem extends GetWidget<MembersController> {
  final MemberModel member;
  final OnItemEdited<MemberModel> onMemberEdited;

  MemberItem({
    @required this.member,
    @required this.onMemberEdited,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (onMemberEdited != null) {
            onMemberEdited(member, EditAction.Click);
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
        return buildMenuItems();
      },
      onSelected: (value) => onMemberEdited(member, value),
    );
  }

  Color _getRandomColor() {
    return kPrimarySwatch[(random(9) + 1) * 100];
  }

  List<PopupMenuItem<EditAction>> buildMenuItems() {
    final List<PopupMenuItem<EditAction>> items = [];
    if (controller.isTeamOwner()) {
      items.add(PopupMenuItem<EditAction>(
          value: EditAction.Delete, child: Text('Remove')));
    }
    return items;
  }
}
