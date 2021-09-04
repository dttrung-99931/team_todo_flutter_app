import 'package:get/get.dart';
import 'package:team_todo_app/constants/routes.dart';

import 'binding.dart';
import 'components/team/components/actions/binding.dart';
import 'components/team/components/actions/list_screen.dart';
import 'list_screen.dart';
import 'components/team/binding.dart';
import 'components/team/components/join_requests/binding.dart';
import 'components/team/components/join_requests/list_screen.dart';
import 'components/team/components/members/binding.dart';
import 'components/team/components/members/list_screen.dart';
import 'components/team/screen.dart';
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
