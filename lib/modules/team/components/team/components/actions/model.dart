import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:team_todo_app/modules/user/model.dart';

import '../todo_board/components/task/model.dart';

class ActionModel {
  static const TYPE_ADD_TASK = "ADD_TASK";
  static const TYPE_DEL_TASK = "DEL_TASK";
  static const TYPE_UPDATE_TASK = "TYPE_UPDATE_TASK";

  final String id;
  final String userID;
  final String type;
  final String taskID;
  final DateTime date;
  final Map<String, String> updatedFields;

  TaskModel task;
  UserModel user;
  
  ActionModel({
    @required this.id,
    @required this.taskID,
    @required this.type,
    @required this.date,
    @required this.userID,
    this.updatedFields = const {},
  });

  String typeDisplay() {
    switch (type) {
      case TYPE_ADD_TASK:
        return "Thêm";
      case TYPE_DEL_TASK:
        return "Xóa";
      case TYPE_UPDATE_TASK:
        return "Sửa";
      default:
        return "";
    }
  }

  IconData getIconActionType() {
    switch (type) {
      case TYPE_ADD_TASK:
        return Icons.add_outlined;
      case TYPE_DEL_TASK:
        return Icons.delete_outlined;
      case TYPE_UPDATE_TASK:
        return Icons.edit_outlined;
      default:
        return Icons.question_answer_outlined;
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userID': userID,
      'type': type,
      'taskID': taskID,
      'date': date.millisecondsSinceEpoch,
      'updatedFields': updatedFields,
    };
  }

  factory ActionModel.fromMap(Map<String, dynamic> map) {
    return ActionModel(
      id: map['id'],
      userID: map['userID'],
      type: map['type'],
      taskID: map['taskID'],
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      updatedFields: Map<String, String>.from(map['updatedFields']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ActionModel.fromJson(String source) =>
      ActionModel.fromMap(json.decode(source));

  String actionDisplay() {
    return "${typeDisplay()} ${task?.title}";
  }
}
