import 'package:get/get.dart';

import 'binding.dart';
import 'list_screen.dart';
import 'team/binding.dart';
import 'team/components/join_requests/binding.dart';
import 'team/components/join_requests/list_screen.dart';
import 'team/components/members/binding.dart';
import 'team/components/members/list_screen.dart';
import 'team/components/activities/binding.dart';
import 'team/components/activities/list_screen.dart';
import 'team/screen.dart';
import 'team_preview/screen.dart';

final teamListPages = GetPage(
  name: "/teams",
  page: () => TeamListScreen(),
  binding: TeamListBinding(),
  children: [
    GetPage(
      name: "/team",
      page: () => TeamScreen(),
      binding: TeamBinding(),
      children: [
        GetPage(
          name: '/join-requests',
          page: () => JoinRequestScreen(),
          binding: JoinRequestBinding(),
        ),
        GetPage(
          name: '/members',
          page: () => MemberListScreen(),
          binding: MembersBinding(),
        ),
        GetPage(
          name: '/notifications',
          page: () => TeamActivityListScreen(),
          binding: TeamActivityBinding(),
        )
      ],
    ),
    GetPage(
      name: "/team-preview",
      page: () => TeamPreviewScreen(),
    ),
  ],
);
