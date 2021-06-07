import 'package:get/get.dart';
import 'package:team_todo_app/core/base_controller.dart';
import 'package:team_todo_app/features/auth/auth_service.dart';
import 'package:team_todo_app/utils/utils.dart';

import 'team_model.dart';
import 'teams_service.dart';

class TeamsController extends BaseController {
  final _teamService = Get.find<TeamsService>();
  final _myTeams = RxList<TeamModel>();
  List<TeamModel> get myTeams => _myTeams.toList();

  @override
  Future<void> onInit() async {
    isLoading = true;
    try {
      final teams = await _teamService.getMyTeams();
      _myTeams.assignAll(teams);
    } catch (e) {
      logd('Load my teams error $e');
    }
    isLoading = false;
    super.onInit();
  }

  Future<void> add(TeamModel team) async {
    isLoading = true;
    var createdTeam = await _teamService.add(team);
    _myTeams.add(createdTeam);
    isLoading = false;
  }

  Future<void> delete(String teamID) async {
    await _teamService.delete(teamID);
    _myTeams.removeWhere((team) => team.id == teamID);
  }

  Future<void> update_(TeamModel teamModel) async {
    isLoading = true;
    await _teamService.update(teamModel);
    final index = _myTeams.indexWhere((element) => element.id == element.id);
    _myTeams.setAll(index, [teamModel]);
    isLoading = false;
  }
}
