import 'dart:convert';

import 'package:flutter/foundation.dart';

class Action {
  static const TYPE_ADD_TASK = "ADD_TASK";
  static const TYPE_DEL_TASK = "DEL_TASK";
  static const TYPE_UPDATE_TASK = "UPDATE_TASK";

  final String type;
  final String taskID;
  final DateTime date;

  Action({
    @required this.type,
    @required this.taskID,
    @required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'taskID': taskID,
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory Action.fromMap(Map<String, dynamic> map) {
    return Action(
      type: map['type'],
      taskID: map['taskID'],
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Action.fromJson(String source) => Action.fromMap(json.decode(source));
}
