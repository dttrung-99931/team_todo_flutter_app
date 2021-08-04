import 'package:get/get.dart';
import 'package:team_todo_app/modules/notification/page.dart';

import 'binding.dart';
import 'screen.dart';

final homePages = GetPage(
    name: "/",
    page: () => HomeScreen(),
    binding: HomeBinding(),
    children: [notificationPage]);
