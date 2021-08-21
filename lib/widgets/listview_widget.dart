import 'package:flutter/cupertino.dart';

class ListViewWidget extends ListView {
  final List<Widget> children;
  final String noDataTitle;
  ListViewWidget({
    this.children,
    this.noDataTitle = 'No data',
  }) : super(children: children);

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) {
      return Center(
        child: Text(noDataTitle),
      );
    }
    return super.build(context);
  }
}
