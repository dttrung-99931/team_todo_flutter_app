import 'dart:convert';

import 'package:flutter/foundation.dart';
import '../../../../../user/model.dart';

class TaskModel {
  String id;
  String title;
  String description;
  String assigneeUserID;
  String creatorUserID;
  DateTime startDate;
  DateTime dueDate;
  String status;
  DateTime statusChangedDate;

  UserModel assigneeUser;
  
  TaskModel({
    @required this.title,
    @required this.creatorUserID,
    @required this.status,
    @required this.statusChangedDate,
    this.id,
    this.assigneeUserID,
    this.description,
    this.startDate,
    this.dueDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'creatorUserID': creatorUserID,
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
      creatorUserID: map['creatorUserID'],
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
