import 'package:get/get.dart';
import 'package:team_todo_app/core/base_controller.dart';
import 'package:team_todo_app/features/auth/user_service.dart';
import 'package:team_todo_app/features/teams/team/components/members/member_model.dart';

import '../../../team_model.dart';
import '../../../teams_controller.dart';
import '../../../teams_service.dart';

class MembersController extends BaseController {
  final _members = RxList<MemberModel>();
  final _userService = Get.find<UserService>();
  final _teamsController = Get.find<TeamsController>();
  final _teamsService = Get.find<TeamsService>();
  List<MemberModel> get members => _members.toList();
  TeamModel _team;

  @override
  Future<void> onInit() async {
    _team = _teamsController.selectedTeam;
    await _loadMembers();
    super.onInit();
  }

  Future<void> _loadMembers() async {
    _members.assignAll(await _teamsService.loadTeamMemebers(_team));
  }

  Future<void> removeMember(String id) async {
    await _teamsService.unjoinMember(_team.id, id);
    _members.removeWhere((element) => element.user.id == id);
    _team.userIDs.remove(id);
    _teamsController.updateSelectedTeam(_team);
  }

  Future<void> addMember(String email) async {
    load(() async {
      final user = await _userService.getByEmail(email);
      if (user == null) {
        await showSnackbar('Not found');
      } else if (members
          .where((element) => element.user.email == email)
          .isNotEmpty) {
        await showSnackbar('This user has joined team');
      } else {
        await _teamsService.joinTeam(_team.id, user.id);
        _members.add(MemberModel(user, false));
        _team.userIDs.add(user.id);
        _teamsController.updateSelectedTeam(_team);
        Get.back();
      }
    });
  }

  bool isTeamOwner() {
    return _teamsService.appUserID == _team.ownerUserID;
  }
}
