import 'package:get/get.dart';
import 'package:team_todo_app/modules/notification/list_screen.dart';
import 'package:team_todo_app/modules/notification/service.dart';

import 'controller.dart';

final notificationPage = GetPage(
  name: "/notifications",
  page: () => NotificationListScreen(),
  binding: BindingsBuilder(() {
    Get.put(NotificationService());
    Get.put(NotificationController());
  }),
);
