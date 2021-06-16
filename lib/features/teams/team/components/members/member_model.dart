import 'package:team_todo_app/features/auth/user_model.dart';

class MemberModel {
  final UserModel user;
  final bool isTeamOwner;

  MemberModel(this.user, this.isTeamOwner);

  @override
  String toString() {
    return user.email;
  }
}
