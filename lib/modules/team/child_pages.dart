import 'package:get/get.dart';
import 'components/actions/binding.dart';
import 'components/actions/list_screen.dart';
import 'components/join_requests/binding.dart';
import 'components/join_requests/list_screen.dart';
import 'components/members/binding.dart';
import 'components/members/list_screen.dart';
import '../../constants/routes.dart';
import 'components/team_search/binding.dart';
import 'components/team_search/screen.dart';

final teamChildPages = [
  GetPage(
    name: RouteNames.JOIN_REQUEST,
    page: () => JoinRequestScreen(),
    binding: JoinRequestBinding(),
  ),
  GetPage(
    name: RouteNames.MEMBERS,
    page: () => MemberListScreen(),
    binding: MembersBinding(),
  ),
  GetPage(
    name: RouteNames.ACTIONS,
    page: () => TeamActionListScreen(),
    binding: TeamActionBinding(),
  ),
  GetPage(
    name: RouteNames.TEAM_SEARCH,
    page: () => TeamSearchScreen(),
    binding: TeamSearchBinding(),
  )
];
