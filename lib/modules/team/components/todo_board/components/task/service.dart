import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../../../base/firestore_service.dart';
import '../../../../../../constants/constants.dart';
import '../../../../../../exceptions/not_found.dart';
import '../../../actions/model.dart';

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

  Future<TaskModel> getByID(String taskID) async {
    var querySnap = await queryByID(taskID);
    if (querySnap.docs.length != 0) {
      return TaskModel.fromMap(querySnap.docs[0].data());
    }
    return null;
  }

  Future<QuerySnapshot<Map<String, dynamic>>> queryByID(String taskID) async {
    return await getCollectionGroup(Collections.tasks)
        .where(Fields.id, isEqualTo: taskID)
        .get();
  }

  /// Load [ActionModel.task] for actions
  Future<void> loadTasksForActions(List<ActionModel> actions) async {
    var futures = actions
        .where((action) => action.type != ActionModel.TYPE_DEL_TASK)
        .map((action) {
      return getByID(action.taskID).then((value) => action.task = value);
    });
    await Future.wait(futures);
  }

  Future<String> addTask(TaskModel task) async {
    final taskRef = collection.doc();
    task.id = taskRef.id;
    await taskRef.set(task.toMap());
    return task.id;
  }

  Future<List<TaskModel>> getTasks() async {
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

  Future<void> deleteTask(String taskID) async {
    await getDocRef(taskID).delete();
  }

  Future<TaskModel> getTaskOfSelectedTeam(String taskID) async {
    var taskSnap = await getDocSnap(taskID);
    if (taskSnap.exists) {
      return TaskModel.fromMap(taskSnap.data());
    }
    return null;
  }

  Future<bool> containTask(String taskID) async {
    return (await getDocSnap(taskID)).exists;
  }
}
