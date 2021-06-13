import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Todo extends StatelessWidget {
  const Todo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.white, child: Center(child: Text('Todo')));
  }
}
