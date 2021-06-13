import 'package:get/get.dart';

import 'team/components/join_requests/join_request_binding.dart';
import 'team/components/join_requests/join_request_screen.dart';
import 'team/components/members/members_binding.dart';
import 'team/components/members/memebers_screen.dart';
import 'team/team_screen.dart';

final teamsPage = GetPage(name: "/team", page: () => TeamScreen(), children: [
  GetPage(
      name: '/join-requests',
      page: () => JoinRequestScreen(),
      binding: JoinRequestBinding()),
  GetPage(
      name: '/members', page: () => MembersScreen(), binding: MembersBinding())
]);
