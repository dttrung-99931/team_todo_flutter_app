import 'package:get/get.dart';

import '../../../../base/base_controller.dart';
import '../../../../utils/utils.dart';
import '../../model.dart';
import '../../service.dart';

class TeamSearchController extends BaseController {
  final _teamservice = Get.find<TeamService>();

  final _suggestedTeams = RxList<TeamModel>();
  List<TeamModel> get suggestedTeams => _suggestedTeams.toList();

  final _searchTeams = RxList<TeamModel>();
  List<TeamModel> get searchTeams => _searchTeams.toList();

  final _areSuggestedTeamsShown = RxBool(true);
  bool get areSuggestedTeamsShown => _areSuggestedTeamsShown.value;

  final _isSearchTextSubmitted = RxBool(false);
  bool get isSearchTextSubmitted => _isSearchTextSubmitted.value;

  @override
  void onInit() {
    loadSuggestTeams();
    super.onInit();
  }

  Future<void> loadSuggestTeams() async {
    isLoading = true;
    final teams = await _teamservice.getSuggestTeams(10);
    logd(teams);
    _suggestedTeams.assignAll(teams);
    isLoading = false;
  }

  void onSearchTextSubmitted(String searchText) {
    _isSearchTextSubmitted.value = true;
    search(searchText);
  }

  void onSearchTextChanged(String value) {
    _areSuggestedTeamsShown.value = value.isEmpty;
    _isSearchTextSubmitted.value = false;
    _searchTeams.clear();
  }

  void search(String searchText) {
    load(() async {
      _areSuggestedTeamsShown.value = false;
      final teams = await _teamservice.getByName(searchText);
      _searchTeams.assignAll(teams);
    });
  }
}
