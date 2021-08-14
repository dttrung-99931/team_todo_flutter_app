import 'package:team_todo_app/base/firestore_service.dart';
import 'package:team_todo_app/constants/constants.dart';
import 'package:team_todo_app/modules/team/components/team/components/action/action_model.dart';

import 'model.dart';

class TaskService extends FirestoreService {
  
  String _selectedTeamID;
  set selectedTeamID(teamID) => _selectedTeamID = teamID;
  String get selectedTeamID {
    if (_selectedTeamID == null) {
      throw Exception('selectedTeamID must be set before using TaskService');
    }
    return _selectedTeamID;
  }

  @override
  String getCollectionPath() {
    return "teams/$selectedTeamID/tasks";
  }

  Future<TaskModel> getTaskOfAction(String actionID) async {
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
      return getTaskOfAction(action.taskID).then((value) => action.task = value);
    });
    await Future.wait(futures);
  }

  Future<void> addTask(TaskModel task) async {
    final taskRef = collection.doc();
    task.id = taskRef.id;
    await taskRef.set(task.toMap());
  }

  Future<List<TaskModel>> getasks() async {
    final querySnap = await getQuerySnap();
    return querySnap.docs.map((e) => TaskModel.fromMap(e.data())).toList();
  }

  Future<void> updateTask(
    TaskModel task, {
    Map<String, String> updatedFields,
    String notiTitle,
  }) async {
    task.statusChangedDate = DateTime.now();
    getDocRef(task.id).update(task.toMap());
  }

  Future<void> deleteTask(String teamID, String taskID) async {
    await getDocRef(taskID).delete();
  }

  Future<TaskModel> getTask(String taskID) async {
    var taskSnap = await getDocSnap(taskID);
    return TaskModel.fromMap(taskSnap.data());
  }
}
