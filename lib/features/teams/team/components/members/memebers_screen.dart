import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:team_todo_app/core/base_get_widget.dart';
import 'package:team_todo_app/core/on_item_clicked.dart';
import 'package:team_todo_app/features/teams/team/components/members/add_member_dialog.dart';
import 'package:team_todo_app/features/teams/team/components/members/members_controller.dart';

import 'member_list.dart';

class MembersScreen extends BaseGetWidget<MembersController> {
  MembersScreen({Key key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Members'),
          actions: buildAppBarActions(),
        ),
        body: Obx(() => MemberList(
              members: controller.members,
              onMemberEdited: (model, action) {
                if (action == EditAction.Delete) {
                  showAlertDialog('Delete this member', () {
                    controller.removeMember(model.user.id);
                  });
                }
              },
            )),
      ),
    );
  }

  List<Widget> buildAppBarActions() {
    List<Widget> actions = [];
    if (controller.isTeamOwner()) {
      actions.add(IconButton(
        icon: Icon(Icons.add),
        onPressed: () {
          Get.dialog(AddMemberDialog());
        },
      ));
    }
    return actions;
  }
}
