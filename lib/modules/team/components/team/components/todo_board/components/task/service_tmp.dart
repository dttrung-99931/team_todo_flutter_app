import 'package:team_todo_app/base/firestore_service.dart';
import 'package:team_todo_app/constants/constants.dart';
import 'package:team_todo_app/modules/team/components/team/components/action/action_model.dart';

import 'model.dart';

class TaskServicess extends FirestoreService {
  /// Used to build collection path
  /// It must be not null before using this service
  String teamID;

  @override
  String getCollectionPath() {
    if (teamID == null) {
      throw Exception("teamID must have value before using ActionService");
    }
    return "teams/$teamID/tasks";
  }

  Future<TaskModel> getTask(String actionID) async {
    var querySnap = await getCollectionGroup(Collections.tasks)
        .where(Fields.id, isEqualTo: actionID)
        .get();
    if (querySnap.docs.length != 0) {
      return TaskModel.fromMap(querySnap.docs[0].data());
    }
    return null;
  }

  /// Load [ActionModel.task] for actions
  Future<void> loadTasksForActions(List<ActionModel> actions) async {
    var futures = actions.map((action) {
      return getTask(action.taskID).then((value) => action.task = value);
    });
    await Future.wait(futures);
  }
}
