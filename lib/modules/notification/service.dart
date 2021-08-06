import 'package:get/get.dart';
import 'package:team_todo_app/base/firestore_service.dart';
import 'package:team_todo_app/modules/team/action/action_model.dart';
import 'package:team_todo_app/modules/team/action/service.dart';
import 'package:team_todo_app/modules/team/team/components/todo_board/task/service.dart';
import 'package:team_todo_app/modules/user/service.dart';

import 'model.dart';

class NotificationService extends FirestoreService {
  final _userService = Get.find<UserService>();
  final _actionService = Get.find<ActionService>();

  @override
  String getCollectionPath() {
    return "users/${_userService.userID}/notifications";
  }

  Future<List<NotificationModel>> getAllNotis() async {
    var notiDocs = await getAllDocSnaps();
    var notis =
        notiDocs.map((doc) => NotificationModel.fromMap(doc.data())).toList();
    var taskNotis = notis
        .where((noti) => noti.type == NotificationModel.TYPE_TASK)
        .toList();
    await _actionService.loadActionsForTaskNotis(taskNotis);
    return notis;
  }
}
