import 'package:get/get.dart';
import 'package:team_todo_app/base/base_controller.dart';
import 'package:team_todo_app/modules/user/service.dart';

import 'model.dart';
import 'service.dart';

class NotificationController extends BaseController {
  final _notifications = RxList<NotificationModel>();
  List<NotificationModel> get notifications => _notifications.toList();

  // final _userService = Get.find<UserService>();
  final _notiService = Get.find<NotificationService>();

  @override
  Future<void> onInit() async {
    super.onInit();
    var notis = await _notiService.getAllNotis();
    print(notis);
    _notifications.assignAll(notis);
  }
}
