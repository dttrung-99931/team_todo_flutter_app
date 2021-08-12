import 'dart:math';

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

void logd(Object msg) {
  print('@@ $msg');
}

/// Return map containing diff (key,value)s between map1 and map2
Map<String, String> diff(Map<String, String> map1, Map<String, String> map2) {
  var diff = Map<String, String>();
  map1.forEach((key, value) {
    if (map2.containsKey(key) && value != map2[key]) {}
  });
  return diff;
}

bool isNotNullAndEmpty(String str) {
  return str?.isNotEmpty ?? false;
}
