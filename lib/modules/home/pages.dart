import 'package:get/get.dart';
import 'package:team_todo_app/constants/routes.dart';
import 'package:team_todo_app/modules/team/components/team/child_pages.dart';
import 'binding.dart';
import 'screen.dart';

final homePages = GetPage(
  name: RouteNames.HOME,
  page: () => HomeScreen(),
  binding: HomeBinding(),
  children: teamChildPages,
);
