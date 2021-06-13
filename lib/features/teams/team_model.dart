import 'dart:convert';

import 'package:flutter/foundation.dart';

class TeamModel {
  String id;
  String ownerUserID;
  List<String> userIDs;
  List<String> pendingUserIDs;
  String name;
  String description;

  TeamModel({
    this.id,
    this.ownerUserID,

    /// @TODO need to set default value = [], and remove @required
    @required this.userIDs,
    @required this.pendingUserIDs,
    @required this.name,
    @required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ownerUserID': ownerUserID,
      'userIDs': userIDs,
      'pendingUserIDs': pendingUserIDs,
      'name': name,
      'description': description,
    };
  }

  factory TeamModel.fromMap(Map<String, dynamic> map) {
    return TeamModel(
      id: map['id'],
      ownerUserID: map['ownerUserID'],
      userIDs: List<String>.from(map['userIDs']),
      pendingUserIDs: List<String>.from(map['pendingUserIDs']),
      name: map['name'],
      description: map['description'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TeamModel.fromJson(String source) =>
      TeamModel.fromMap(json.decode(source));
}
