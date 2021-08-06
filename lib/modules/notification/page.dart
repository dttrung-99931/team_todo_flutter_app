import 'package:get/get.dart';
import 'package:team_todo_app/modules/notification/list_screen.dart';
import 'package:team_todo_app/modules/notification/service.dart';
import 'package:team_todo_app/modules/team/action/service.dart';
import 'package:team_todo_app/modules/team/team/components/todo_board/task/service.dart';

import 'controller.dart';

final notificationPage = GetPage(
  name: "/notifications",
  page: () => NotificationListScreen(),
  binding: BindingsBuilder(() {
    // @TODO: make auto injecting dependencies for ActionService
    Get.put(TaskService());
    Get.put(ActionService());
    Get.put(NotificationService());
    Get.put(NotificationController());
  }),
);
