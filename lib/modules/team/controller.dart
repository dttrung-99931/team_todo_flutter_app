import 'dart:async';

import 'package:get/get.dart';
import '../../controller.dart';
import '../notification/model.dart';
import '../notification/service.dart';
import '../../base/base_controller.dart';
import '../../utils/utils.dart';

import 'model.dart';
import 'service.dart';

class TeamController extends BaseController {
  final _teamService = Get.find<TeamService>();
  final _notiService = Get.find<NotificationService>();
  final _mainController = Get.find<MainController>();

  final _myTeams = RxList<TeamModel>();
  List<TeamModel> get myTeams => _myTeams.toList();

  Rx<TeamModel> get selectedTeamObs => _mainController.selectedTeamObs;
  TeamModel get selectedTeam => selectedTeamObs.value;

  // new action IDs of the selected team
  final _newActionIDs = RxList<String>();
  List<String> get newActionIDs => _newActionIDs.toList();
  StreamSubscription newActionLisnerCanceler;

  final _refeshSuggestTeams = RxBool();
  bool get refeshSuggestTeams => _refeshSuggestTeams.value;

  @override
  Future<void> onInit() async {
    // Test handling error
    // Errror will not be catched by FlutterError.onError
    // bacause this function is async.
    // throw Exception('Error from home menu');
    // throw NoInternetException();
    super.onInit();
    await loadMyTeams();
    newActionLisnerCanceler = listenNewAction();
  }

  @override
  void onClose() {
    newActionLisnerCanceler.cancel();
  }

  Future<void> loadMyTeams() async {
    load(() async {
      try {
        final teams = await _teamService.getMyTeams();
        _myTeams.assignAll(teams);
        onMyTeamsLoad();
      } catch (e) {
        logd('Load my teams error $e');
      }
    });
  }

  void onMyTeamsLoad() {
    if (myTeams.isNotEmpty) {
      selectTeam(myTeams.first);
    }
  }

  StreamSubscription<NotificationModel> listenNewAction() {
    return _notiService.newNotiStream.listen((newNoti) async {
      if (newNoti.type == NotificationModel.TYPE_ACTION) {
        var containsAction = await _teamService.containsAction(
          selectedTeam.id,
          newNoti.referenceID,
        );
        if (containsAction) {
          _newActionIDs.add(newNoti.referenceID);
        }
      }
    });
  }

  /// Add a team
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

  Future<void> unjoinAppUserFromTeam(String teamID) async {
    await _teamService.unjoinAppUserFromTeam(teamID);
    _myTeams.removeWhere((element) => element.id == teamID);
  }

  Future<void> selectTeamByID(String teamID) async {
    selectTeam(await _teamService.getByID(teamID));
  }

  void selectTeam(TeamModel team) {
    selectedTeamObs.value = team;
    // _userService
    //     .getNewActionIDs(_teamsService.appUserID, team.id)
    //     .then((value) => _newTeamActionIDs.assignAll(value));
  }

  void updateSelectedTeam(TeamModel updated) {
    selectedTeamObs.value = updated;
    syncSelectedTeamWithMyTeams();
  }

  void syncSelectedTeamWithMyTeams() {
    final index =
        _myTeams.indexWhere((element) => element.id == selectedTeam.id);
    _myTeams[index] = selectedTeam;
    _myTeams.refresh();
  }

  bool isTeamOwner() {
    return _teamService.appUserID == selectedTeam.ownerUserID;
  }

  void clearNewActionIDs() {
    _newActionIDs.clear();
  }
}
