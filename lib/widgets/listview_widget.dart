import 'package:flutter/cupertino.dart';

class ListViewWidget extends ListView {
  final List<Widget> children;

  ListViewWidget({this.children}) : super(children: children);

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) {
      return Center(
        child: Text('No data'),
      );
    }
    return super.build(context);
  }
}
