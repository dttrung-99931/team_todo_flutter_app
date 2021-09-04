import '../../../user/model.dart';

class MemberModel {
  final UserModel user;
  final bool isTeamOwner;

  MemberModel(this.user, this.isTeamOwner);

  @override
  String toString() {
    return user.email;
  }
}
