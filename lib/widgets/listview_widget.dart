import 'package:flutter/cupertino.dart';
import 'package:team_todo_app/utils/ui_utils.dart';

// ignore: must_be_immutable
class ListViewWidget extends StatefulWidget {
  final List<Widget> children;
  final String noDataTitle;
  final bool shrinkWrap;
  final bool isInScrollView;
  final double loadMoreOffset;
  final canLoadMore;
  bool isLoadingMore;
  Function onLoadMore;

  ListViewWidget({
    @required this.children,
    this.shrinkWrap = false,
    this.isInScrollView = false,
    this.noDataTitle = 'No data',
    this.loadMoreOffset = 200,
    this.onLoadMore,
    this.canLoadMore = true,
  }) {
    isLoadingMore = false;
  }

  @override
  _ListViewWidgetState createState() => _ListViewWidgetState();
}

class _ListViewWidgetState extends State<ListViewWidget> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  Future<void> _scrollListener() async {
    if (!widget.isLoadingMore &&
        widget.canLoadMore &&
        _scrollController.position.extentAfter < widget.loadMoreOffset) {
      await widget.onLoadMore?.call();
      // Make sure the setState call before disposed
      if (this.mounted) {
        setState(() {
          widget.isLoadingMore = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.children.isEmpty) {
      return Center(
        child: Text(widget.noDataTitle),
      );
    }
    return ListView(
      controller: _scrollController,
      children: [
        ...widget.children,
        if (widget.isLoadingMore) UIUtils.buildCenterProgressBar()
      ],
      shrinkWrap: widget.shrinkWrap,
      physics: widget.isInScrollView ? ClampingScrollPhysics() : null,
    );
  }
}
