import 'dart:math';

int random(int max) {
  return Random().nextInt(max);
}

void logd(Object msg) {
  print('@@ $msg');
}
