import 'package:get/get.dart';
import 'package:team_todo_app/modules/notification/list_screen.dart';

final notificationPage = GetPage(
  name: "/notifications",
  page: () => NotificationListScreen(),
);
