import 'dart:convert';

import 'package:flutter/foundation.dart';

class UserTeamModel {
  final String teamID;
  final List<String> newActionIDs;

  UserTeamModel({
    @required this.teamID,
    @required this.newActionIDs,
  });

  Map<String, dynamic> toMap() {
    return {
      'teamID': teamID,
      'newActionIDs': newActionIDs,
    };
  }

  factory UserTeamModel.fromMap(Map<String, dynamic> map) {
    return UserTeamModel(
      teamID: map['teamID'],
      newActionIDs: List<String>.from(map['newActionIDs']),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserTeamModel.fromJson(String source) =>
      UserTeamModel.fromMap(json.decode(source));
}
