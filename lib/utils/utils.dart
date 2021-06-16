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
