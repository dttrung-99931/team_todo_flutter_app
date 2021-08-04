import 'package:get/get.dart';
import 'package:team_todo_app/base/firestore_service.dart';
import 'package:team_todo_app/modules/user/service.dart';

import 'model.dart';

class NotificationService extends FirestoreService {
  final _userService = Get.find<UserService>();

  @override
  String getCollectionPath() {
    return "users/${_userService.userID}/notifications";
  }

  Future<List<NotificationModel>> getAllNotis() async {
    var notiDocs = await getAllDocSnaps();
    var notis =
        notiDocs.map((doc) => NotificationModel.fromMap(doc.data())).toList();
    return notis;
  }
}
