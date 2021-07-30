import 'package:get/get.dart';
import 'package:team_todo_app/features/teams/team/components/todo_board/todo_board_controller.dart';

import 'team/components/join_requests/join_request_binding.dart';
import 'team/components/join_requests/join_request_screen.dart';
import 'team/components/members/members_binding.dart';
import 'team/components/members/memebers_screen.dart';
import 'team/components/notifications/binding.dart';
import 'team/components/notifications/list.dart';
import 'team/team_screen.dart';

final teamsPage = GetPage(
    name: "/team",
    page: () => TeamScreen(),
    binding: BindingsBuilder.put(() => TodoBoardController()),
    children: [
      GetPage(
        name: '/join-requests',
        page: () => JoinRequestScreen(),
        binding: JoinRequestBinding(),
      ),
      GetPage(
        name: '/members',
        page: () => MembersScreen(),
        binding: MembersBinding(),
      ),
      GetPage(
        name: '/notifications',
        page: () => TeamNotificationsScreen(),
        binding: TeamNotificationsBinding(),
      )
    ]);
