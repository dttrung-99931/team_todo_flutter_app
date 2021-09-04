import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:team_todo_app/base/firestore_service.dart';
import 'package:team_todo_app/constants/constants.dart';
import 'package:team_todo_app/modules/team/components/team/components/actions/service.dart';
import 'package:team_todo_app/modules/user/service.dart';

import 'model.dart';

class NotificationService extends FirestoreService {
  final _userService = Get.find<UserService>();
  final _actionService = Get.find<ActionService>();

  final _newNoti = Rx<NotificationModel>();
  Stream<NotificationModel> get newNotiStream => _newNoti.stream;
  StreamSubscription<QuerySnapshot> notisChangedSubscription;
  // Indicates whether ignored first noti change event
  // that always fired right after subscribing document changes even there's no changes
  var ignoredFirstNotisEvent = false;

  @override
  void onInit() {
    super.onInit();
    notisChangedSubscription?.cancel();
    notisChangedSubscription = collection.snapshots().listen((event) {
      if (!ignoredFirstNotisEvent) {
        ignoredFirstNotisEvent = true;
        return;
      }
      event.docChanges.forEach((element) {
        if (element.type == DocumentChangeType.added) {
          _newNoti.value = NotificationModel.fromMap(element.doc.data());
        }
      });
    });
  }

  @override
  void onClose() {
    notisChangedSubscription.cancel();
    super.onClose();
  }

  @override
  String getCollectionPath() {
    return "users/${_userService.userID}/notifications";
  }

  Future<List<NotificationModel>> getAllNotis() async {
    var notiQuery =
        await collection.orderBy(Fields.date, descending: true).get();
    var notis = notiQuery.docs
        .map((doc) => NotificationModel.fromMap(doc.data()))
        .toList();
    var taskNotis = notis
        .where((noti) => noti.type == NotificationModel.TYPE_ACTION)
        .toList();
    // @TODO: load relative data for other noti type
    await _actionService.loadActionsForTaskNotis(taskNotis);
    return notis;
  }

  Future<void> updateNotisSeen(List<String> notiIDs) async {
    final futures = notiIDs.map(
      (notiID) => collection.doc(notiID).update({Fields.isSeen: true}),
    );
    await Future.wait(futures);
  }

  Future<List<NotificationModel>> loadTaskNotis(List<String> taskIDs) async {
    final querySnap = await collection
        .where(Fields.type, isEqualTo: NotificationModel.TYPE_ACTION)
        .where(Fields.referenceID, whereIn: taskIDs)
        .get();
    return querySnap.docs
        .map((e) => NotificationModel.fromMap(e.data()))
        .toList();
  }

  Future<bool> containNotSeenActionNoti(String actionID) async {
    final querySnap = await collection
        .where(Fields.referenceID, isEqualTo: actionID)
        .where(Fields.isSeen, isEqualTo: false)
        .get();
    return querySnap.docs.isNotEmpty;
  }

  Future<NotificationModel> getByID(String notiID) async {
    final notiSnap = await getDocSnap(notiID);
    return NotificationModel.fromMap(notiSnap.data());
  }

  buildPushNotiBody(String notiID) async {
    final noti = await getByID(notiID);
    if (noti.type == NotificationModel.TYPE_ACTION) {
      final action = await _actionService.getAction(noti.referenceID);
      final user = await _userService.getByID(action.userID);
      return user.email;
    }

    // @TODO: Handle buiding noti for other type

    return '[Unhandled body for noti type ${noti.type}]';
  }

  //   Future<void> addNotiForMembers(
  //     String actionId, String teamID, String notiTitle) async {
  //   var teamMemberIDs = await getTeamMemberIDs(teamID);
  //   var futures = teamMemberIDs.map<Future>(
  //       (userID) => addNotiForMember(userID, teamID, actionId, notiTitle));
  //   await Future.wait(futures);
  // }

  // Future<void> addNotiForMember(
  //   String userID,
  //   String teamID,
  //   String actionId,
  //   String notiTitle,
  // ) async {
  //   _userService.addTaskNoti(userID, teamID, actionId).then((notiId) async {
  //     // Not send noti to the sender user
  //     // if (userID == _userService.userID) return;

  //     var fcmToken = await _userService.getFcmToken(userID);
  //     if (isNotNullAndEmpty(fcmToken)) {
  //       await _notiSenderService.send(fcmToken, notiId, notiTitle);
  //     }
  //   });
  // }

  // getTeamMemberIDs(String teamID) async {
  //   var team = await getById(teamID);
  //   return team.userIDs;
  // }

}
