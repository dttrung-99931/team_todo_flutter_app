import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../../../base/base_get_widget.dart';
import '../../../../../../base/on_item_clicked.dart';
import 'components/add_member_dialog.dart';
import 'components/list.dart';
import 'controller.dart';

class MemberListScreen extends BaseGetWidget<MembersController> {
  MemberListScreen({Key key});

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
