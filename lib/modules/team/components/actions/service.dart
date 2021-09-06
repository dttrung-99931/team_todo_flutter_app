import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../../../base/firestore_service.dart';
import '../../../../constants/constants.dart';
import '../../../../exceptions/not_found.dart';
import '../../../notification/model.dart';
import '../todo_board/components/task/service.dart';
import '../../../user/service.dart';

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

  Future<ActionModel> getByID(String actionID) async {
    var querySnap = await queryByID(actionID);
    if (querySnap.docs.length != 0) {
      return ActionModel.fromMap(querySnap.docs[0].data());
    }
    return null;
  }

  // Group query action by action ID
  Future<QuerySnapshot<Map<String, dynamic>>> queryByID(String actionID) async {
    return await getCollectionGroup(Collections.actions)
        .where(Fields.id, isEqualTo: actionID)
        .get();
  }

  Future<String> getTeamIDOfAction(String actionID) async {
    var querySnap = await queryByID(actionID);
    if (querySnap.docs.isNotEmpty) {
      var actionRef = querySnap.docs.first.reference;
      var actionCollectionRef = actionRef.parent;
      var teamRef = actionCollectionRef.parent;
      return teamRef.id;
    }
    throw NotFoundException(); // why exception throwing is not catched
  }

  /// Load [NotificationModel.action] for notis
  Future<void> loadActionsForTaskNotis(
    List<NotificationModel> taskNotis,
  ) async {
    var futures = taskNotis.map((noti) {
      return getByID(noti.referenceID).then((value) => noti.action = value);
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
    final docs = await getActionDocs();
    var actions = docsToModels(docs);
    return actions;
  }

  List<ActionModel> docsToModels(List<DocumentSnapshot<Map<String, dynamic>>> docs) {
    return docs
      .map(
        (e) => ActionModel.fromMap(e.data()),
      )
      .toList();
  }

  Future<List<DocumentSnapshot<Map<String, dynamic>>>> getActionDocs({
    DocumentSnapshot startAfterDoc,
    int pageSize = kPageSize,
  }) async {
    var query = collection.orderBy(Fields.date, descending: true);
    if (startAfterDoc != null) {
      query = query.startAfterDocument((startAfterDoc));
    }
    query = query.limit(pageSize);

    var querySnap = await query.get();

    return querySnap.docs;
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
