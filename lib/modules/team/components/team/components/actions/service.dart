import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:team_todo_app/base/firestore_service.dart';
import 'package:team_todo_app/constants/constants.dart';
import 'package:team_todo_app/modules/notification/model.dart';
import 'package:team_todo_app/modules/team/components/team/components/todo_board/components/task/service.dart';
import 'package:team_todo_app/modules/user/service.dart';

import 'model.dart';

class ActionService extends FirestoreService {
  final _userService = Get.find<UserService>();
  final _taskService = Get.find<TaskService>();

  final _newAction = Rx<ActionModel>();
  Stream<ActionModel> get newActionStream => _newAction.stream;
  StreamSubscription<QuerySnapshot> actionsChangedSubscription;

  String _selectedTeamID;
  set selectedTeamID(teamID) {
    if (teamID == _selectedTeamID) return;
    _selectedTeamID = teamID;
    listenActionsChanged();
  }

  void listenActionsChanged() {
    actionsChangedSubscription?.cancel();
    actionsChangedSubscription = collection.snapshots().listen((event) {
      event.docChanges.forEach((element) {
        if (element.type == DocumentChangeType.added) {
          _newAction.value = ActionModel.fromMap(element.doc.data());
        }
      });
    });
  }

  String get selectedTeamID {
    if (_selectedTeamID == null) {
      throw Exception('selectedTeamID must be set before using TaskService');
    }
    return _selectedTeamID;
  }

  @override
  String getCollectionPath() {
    return "teams/$selectedTeamID/actions";
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

  Future<String> addAction(
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
    return docRef.id;
  }

  Future<List<ActionModel>> getActions() async {
    final querySnap =
        await collection.orderBy(Fields.date, descending: true).get();
    var actions = querySnap.docs
        .map(
          (e) => ActionModel.fromMap(e.data()),
        )
        .toList();
    return actions;
  }

  // Future<List<ActionModel>> getActionsIn(
  //     String teamID, List<String> actionIDs) async {
  //   final querySnap = await getDocRef(teamID)
  //       .collection(Collections.actions)
  //       .where(FieldPath.documentId, whereIn: actionIDs)
  //       .get();
  //   var actions = querySnap.docs
  //       .map(
  //         (e) => ActionModel.fromMap(e.data()),
  //       )
  //       .toList();
  //   var futures = actions.map(
  //     (e) => getTask(teamID, e.taskID).then((task) => e.task = task),
  //   );
  //   await Future.wait(futures);
  //   return actions;
  // }
}
