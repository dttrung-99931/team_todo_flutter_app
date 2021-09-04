import 'package:get/get.dart';
import '../../constants/routes.dart';

import 'binding.dart';
import 'list_screen.dart';
import '../team/binding.dart';
import '../team/screen.dart';
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
