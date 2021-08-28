import 'dart:math';

import 'dart:ui';

import 'package:flutter/material.dart';

int random(int max) {
  return Random().nextInt(max);
}

String formatDate(DateTime dateTime, [bool showTime = false]) {
  var date = '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  if (showTime) {
    date += ' ${dateTime.hour}:${dateTime.minute}';
  }
  return date;
}

void logd(Object msg, [String tag = ""]) {
  var logMsg = "";
  if (tag != "") {
    logMsg = "@@ $tag $msg";
  } else {
    logMsg = "@@ $msg";
  }
  print(logMsg);
}

/// Return map containing diff (key,value)s between map1 and map2
Map<String, dynamic> diff(
    Map<String, dynamic> map1, Map<String, dynamic> map2) {
  var diff = Map<String, String>();
  map1.forEach((key, value) {
    if (map2.containsKey(key) && value != map2[key]) {}
  });
  return diff;
}

bool isNotNullAndEmpty(String str) {
  return str?.isNotEmpty ?? false;
}

class Utils {
  static Color stringToColor(String str) {
    var value = 0;
    for (int i = 0; i < str.length; i++) {
      value += str[i].codeUnitAt(0) - 48;
    }
    final colorIndex = value % 5;
    return [
      Colors.purple,
      Colors.cyanAccent,
      Colors.amberAccent,
      Colors.lime,
      Colors.orange
    ][colorIndex];
  }
}
