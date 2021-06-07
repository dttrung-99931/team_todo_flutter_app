import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:team_todo_app/core/firestore_service.dart';
import 'package:team_todo_app/features/teams/team_model.dart';
import 'package:team_todo_app/utils/constants.dart';

class TeamsService extends FirestoreService {
  CollectionReference get _teams => collection(Collections.teams);

  Future<DocumentReference> addTeam(TeamModel team) {
    try {
      return _teams.add(team.toMap());
    } catch (e) {
      print('Add team error $e');
      return null;
    }
  }

  Future<List<TeamModel>> getTeams(List<String> teamIDs) async {
    final querySnapshot =
        await _teams.where(FieldPath.documentId, whereIn: teamIDs).get();
    return querySnapshot.docs.map((e) => TeamModel.fromMap(e.data())).toList();
  }
}
