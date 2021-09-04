import 'package:get/get.dart';
import 'package:team_todo_app/constants/routes.dart';

import 'binding.dart';
import '../nteam/components/actions/binding.dart';
import '../nteam/components/actions/list_screen.dart';
import 'list_screen.dart';
import '../nteam/binding.dart';
import '../nteam/components/join_requests/binding.dart';
import '../nteam/components/join_requests/list_screen.dart';
import '../nteam/components/members/binding.dart';
import '../nteam/components/members/list_screen.dart';
import '../nteam/screen.dart';
import 'components/team_preview/screen.dart';

final teamListPages = GetPage(
  name: "/teams",
  page: () => TeamListScreen(),
  binding: TeamListBinding(),
  children: [
    GetPage(
      name: RouteNames.TEAM,
      page: () => TeamScreen(),
      binding: TeamBinding(),
    ),
    GetPage(
      name: RouteNames.TEAM_PREVIEW,
      page: () => TeamPreviewScreen(),
    ),
  ],
);
