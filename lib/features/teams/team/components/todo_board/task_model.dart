import 'dart:convert';

import 'package:flutter/foundation.dart';

class TaskModel {
  String id;
  String title;
  String description;
  String assigneeUserID;
  DateTime startDate;
  DateTime dueDate;
  String status;
  DateTime statusChangedDate;

  TaskModel({
    this.id,
    @required this.title,
    @required this.assigneeUserID,
    @required this.status,
    @required this.statusChangedDate,
    this.description,
    this.startDate,
    this.dueDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'assigneeUserID': assigneeUserID,
      'startDate': startDate.millisecondsSinceEpoch,
      'dueDate': dueDate.millisecondsSinceEpoch,
      'status': status,
      'statusChangedDate': statusChangedDate.microsecondsSinceEpoch,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      assigneeUserID: map['assigneeUserID'],
      startDate: DateTime.fromMillisecondsSinceEpoch(map['startDate']),
      dueDate: DateTime.fromMillisecondsSinceEpoch(map['dueDate']),
      status: map['status'],
      statusChangedDate:
          DateTime.fromMillisecondsSinceEpoch(map['statusChangedDate']),
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskModel.fromJson(String source) =>
      TaskModel.fromMap(json.decode(source));
}
