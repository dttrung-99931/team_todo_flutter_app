import 'package:get/get.dart';
import 'package:team_todo_app/base/firestore_service.dart';
import 'package:team_todo_app/constants/constants.dart';
import 'package:team_todo_app/modules/notification/model.dart';
import 'package:team_todo_app/modules/team/components/team/components/todo_board/components/task/service.dart';
import 'package:team_todo_app/modules/user/service.dart';

import 'action_model.dart';

class ActionService extends FirestoreService {
  final _userService = Get.find<UserService>();
  final _taskService = Get.find<TaskService>();

  /// Used to build collection path
  /// It must be not null before using this service
  String teamID;

  @override
  String getCollectionPath() {
    if (teamID == null) {
      throw Exception("teamID must have value before using ActionService");
    }
    return "teams/$teamID/actions";
  }

  Future<ActionModel> getAction(String actionID) async {
    var querySnap = await getCollectionGroup(Collections.actions)
        .where(Fields.id, isEqualTo: actionID)
        .get();
    if (querySnap.docs.length != 0) {
      return ActionModel.fromMap(querySnap.docs[0].data());
    }
    return null;
  }

  /// Load [NotificationModel.action] for notis
  Future<void> loadActionsForTaskNotis(
    List<NotificationModel> taskNotis,
  ) async {
    var futures = taskNotis.map((noti) {
      return getAction(noti.referenceID).then((value) => noti.action = value);
    });
    await Future.wait(futures);
    var actions = taskNotis.map((e) => e.action).toList();
    await Future.wait(<Future>[
      _taskService.loadTasksForActions(actions),
      _userService.loadUsersForActions(actions),
    ]);
  }

  Future<void> addAction(
    String type,
    String taskID, {
    Map<String, String> updatedFields = const {},
    String notiTitle = 'Task notification',
  }) async {
    var docRef = collection.doc();
    var action = ActionModel(
      taskID: taskID,
      type: type,
      date: DateTime.now(),
      userID: _userService.userID,
      updatedFields: updatedFields,
      id: docRef.id,
    );
    await docRef.set(action.toMap());
  }

}
