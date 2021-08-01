import 'package:get/get.dart';

import 'binding.dart';
import 'list_screen.dart';
import 'team/components/join_requests/binding.dart';
import 'team/components/join_requests/list_screen.dart';
import 'team/components/members/binding.dart';
import 'team/components/members/list_screen.dart';
import 'team/components/notifications/binding.dart';
import 'team/components/notifications/list_screen.dart';
import 'team/screen.dart';
import 'team_preview/screen.dart';

final teamListPages = GetPage(
    name: "/teams",
    page: () => TeamListScreen(),
    binding: TeamListBinding(),
    children: [
      GetPage(name: "team", page: () => TeamScreen(), children: [
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
          page: () => TeamNotificationsScreen(),
          binding: TeamNotificationsBinding(),
        )
      ]),
      GetPage(
        name: "/team-preview",
        page: () => TeamPreviewScreen(),
      ),
    ]);
