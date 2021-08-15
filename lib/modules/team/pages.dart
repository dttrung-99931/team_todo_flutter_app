import 'package:get/get.dart';

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
          name: '/actions',
          page: () => TeamActionListScreen(),
          binding: TeamActionBinding(),
        )
      ],
    ),
    GetPage(
      name: "/team-preview",
      page: () => TeamPreviewScreen(),
    ),
  ],
);
