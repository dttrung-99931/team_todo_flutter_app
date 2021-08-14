import 'package:get/get.dart';
import 'package:team_todo_app/base/base_controller.dart';
import 'package:team_todo_app/modules/home/controller.dart';
import 'package:team_todo_app/modules/user/service.dart';

import '../common/services/firebase_messaging_service.dart';
import 'model.dart';
import 'service.dart';

class NotificationController extends BaseController {
  final _notifications = RxList<NotificationModel>();
  List<NotificationModel> get notifications => _notifications.toList();

  final _notiService = Get.find<NotificationService>();
  final _messagingService = Get.find<FirebaseMessagingService>();

  @override
  Future<void> onInit() async {
    super.onInit();
    loadNotis();
    await _messagingService.setup();
  }

  void loadNotis() {
    load(() async {
      var notis = await _notiService.getAllNotis();
      _notifications.assignAll(notis);
      var seenNotiIDs =
          notis.where((element) => !element.isSeen).map((e) => e.id).toList();
      await _notiService.updateNotisSeen(seenNotiIDs);
      final _homeController = Get.find<HomeController>();
      _homeController.loadNewNotiNum();
    });
  }
}