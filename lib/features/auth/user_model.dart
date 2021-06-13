import 'dart:convert';

class UserModel {
  final String id;
  final String email;
  final List<String> teamIDs;

  UserModel({this.id, this.email, this.teamIDs = const []});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'teamIDs': teamIDs,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      email: map['email'],
      teamIDs: List<String>.from(map['teamIDs']),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
