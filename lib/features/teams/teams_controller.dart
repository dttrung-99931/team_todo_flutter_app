import 'package:get/get.dart';
import 'package:team_todo_app/core/base_controller.dart';
import 'package:team_todo_app/utils/utils.dart';

import 'team_model.dart';
import 'teams_service.dart';

class TeamsController extends BaseController {
  final _teamsService = Get.find<TeamsService>();

  final _myTeams = RxList<TeamModel>();
  List<TeamModel> get myTeams => _myTeams.toList();

  final _selectedTeam = Rx<TeamModel>();
  TeamModel get selectedTeam => _selectedTeam.value;

  final _refeshSuggestTeams = RxBool();
  bool get refeshSuggestTeams => _refeshSuggestTeams.value;

  @override
  Future<void> onInit() async {
    isLoading = true;
    try {
      await loadMyTeams();
    } catch (e) {
      logd('Load my teams error $e');
    }
    isLoading = false;
    super.onInit();
  }

  Future<void> loadMyTeams() async {
    final teams = await _teamsService.getMyTeams();
    _myTeams.assignAll(teams);
  }

  Future<void> add(TeamModel team) async {
    isLoading = true;
    var createdTeam = await _teamsService.add(team);
    _myTeams.add(createdTeam);
    isLoading = false;
  }

  Future<void> delete(String teamID) async {
    await _teamsService.delete(teamID);
    _myTeams.removeWhere((team) => team.id == teamID);
  }

  Future<void> update_(TeamModel teamModel) async {
    isLoading = true;
    await _teamsService.update(teamModel);
    final index = _myTeams.indexWhere((element) => element.id == element.id);
    _myTeams.setAll(index, [teamModel]);
    isLoading = false;
  }

  Future<void> unjoinAppUserFromTeam(String teamID) async {
    await _teamsService.unjoinAppUserFromTeam(teamID);
    _myTeams.removeWhere((element) => element.id == teamID);
  }

  void selectTeam(TeamModel team) {
    _selectedTeam.value = team;
  }

  void updateSelectedTeam(TeamModel updated) {
    _selectedTeam.value = updated;
    syncSelectedTeamWithMyTeams();
  }

  void syncSelectedTeamWithMyTeams() {
    final index =
        _myTeams.indexWhere((element) => element.id == selectedTeam.id);
    _myTeams[index] = selectedTeam;
    _myTeams.refresh();
  }

  bool isTeamOwner() {
    return _teamsService.appUserID == selectedTeam.ownerUserID;
  }
}
