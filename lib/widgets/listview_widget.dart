import 'package:flutter/cupertino.dart';

class ListViewWidget extends ListView {
  final List<Widget> children;
  final String noDataTitle;
  final bool shrinkWrap;
  final bool isInScrollView;

  ListViewWidget({
    @required this.children,
    this.shrinkWrap = false,
    this.isInScrollView = false,
    this.noDataTitle = 'No data',
  }) : super(
          children: children,
          shrinkWrap: shrinkWrap,
          physics: isInScrollView ? ClampingScrollPhysics() : null,
        );

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
