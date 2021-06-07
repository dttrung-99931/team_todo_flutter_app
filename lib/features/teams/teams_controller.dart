import 'package:get/get.dart';
import 'package:team_todo_app/core/base_controller.dart';
import 'package:team_todo_app/features/auth/auth_service.dart';
import 'package:team_todo_app/features/auth/user_service.dart';

import 'team_model.dart';
import 'teams_service.dart';

class TeamsController extends BaseController {
  final _teamService = Get.find<TeamsService>();
  final _userService = Get.find<UserService>();
  final _authService = Get.find<AuthService>();
  final _myTeams = RxList<TeamModel>();
  List<TeamModel> get myTeams => _myTeams.toList();

  @override
  Future<void> onInit() async {
    isLoading = true;
    try {
      final teamIDs =
          await _userService.getJoinedTeamIDs(_authService.user.uid);
      final teams = await _teamService.getTeams(teamIDs);
      _myTeams.assignAll(teams);
    } catch (e) {
      print('Load my teams error $e');
    }
    isLoading = false;
    super.onInit();
  }

  Future<void> addTeam(TeamModel team) async {
    isLoading = true;
    var docRef = await _teamService.addTeam(team);
    print(_authService.user.uid);
    await _userService.addTeam(_authService.user.uid, docRef.id);
    isLoading = false;
  }
}
