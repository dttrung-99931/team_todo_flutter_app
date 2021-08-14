import 'package:get/get.dart';
import 'package:team_todo_app/base/firestore_service.dart';
import 'package:team_todo_app/constants/constants.dart';
import 'package:team_todo_app/modules/team/components/team/components/action/service.dart';
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

  Future<void> updateNotisSeen(List<String> notiIDs) async {
    final futures = notiIDs.map(
      (notiID) => collection.doc(notiID).update({Fields.isSeen: true}),
    );
    await Future.wait(futures);
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
