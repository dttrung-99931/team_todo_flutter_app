import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:team_todo_app/modules/team/action_model.dart';

class NotificationModel {
  static const TYPE_TASK = "TASK_NOTI";

  final String id;
  final String type;
  // If type = Task => referenceID is actionID,....
  final String referenceID;
  final DateTime date;
  final bool isSeen;

  ActionModel action;

  NotificationModel({
    @required this.id,
    @required this.type,
    @required this.referenceID,
    @required this.date,
    this.isSeen = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'referenceID': referenceID,
      'date': date.millisecondsSinceEpoch,
      'isSeen': isSeen,
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['id'],
      type: map['type'],
      referenceID: map['referenceID'],
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      isSeen: map['isSeen'],
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromJson(String source) =>
      NotificationModel.fromMap(json.decode(source));

  String typeDisplay() {}
}
