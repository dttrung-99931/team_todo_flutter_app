import 'package:get/get.dart';

import '../../../../base/base_controller.dart';
import '../../../user/service.dart';
import '../../../team/model.dart';
import '../../controller.dart';
import '../../../team/service.dart';
import 'model.dart';

class JoinRequestController extends BaseController {
  final _userService = Get.find<UserService>();
  final _teamService = Get.find<TeamService>();
  final _teamsController = Get.find<TeamController>();
  final _joinRequests = RxList<JoinRequestModel>();
  TeamModel _team;
  List<JoinRequestModel> get joinRequests => _joinRequests.toList();

  @override
  Future<void> onInit() async {
    _team = _teamsController.selectedTeam;
    await _loadJoinRequests();
    super.onInit();
  }

  Future _loadJoinRequests() async {
    final pendingUserIDs = _team.pendingUserIDs;
    final requestingUsers = await _userService.getUsers(pendingUserIDs);
    final joinReuqests = requestingUsers
        .map((e) => JoinRequestModel(
            userID: e.id, email: e.email, requestDate: DateTime.now()))
        .toList();
    _joinRequests.assignAll(joinReuqests);
  }

  Future<void> onRequestConfirmed(
      JoinRequestModel request, bool isAccepted) async {
    isLoading = true;
    if (isAccepted) {
      await _teamService.joinTeam(_team.id, request.userID);
    }
    await _teamService.removeJoinTeamRequest(_team.id, request.userID);
    _joinRequests.removeWhere((element) => element.userID == request.userID);
    updateSelectedTeam();
    isLoading = false;
  }

  void updateSelectedTeam() {
    _team.pendingUserIDs = joinRequests.map((e) => e.userID).toList();
    _teamsController.updateSelectedTeam(_team);
  }
}
