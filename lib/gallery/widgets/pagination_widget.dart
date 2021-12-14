import 'package:flutter/material.dart';

class PaginationWidget extends StatefulWidget {
  final ScrollController scrollController;
  final Widget child;
  final Function() callbackPagination;

  const PaginationWidget({
    Key? key,
    required this.scrollController,
    required this.child,
    required this.callbackPagination,
  }) : super(key: key);

  @override
  _PaginationWidgetState createState() => _PaginationWidgetState();
}

class _PaginationWidgetState extends State<PaginationWidget> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = widget.scrollController;
    _scrollController.addListener(() {
      if (mounted) {
        if (_scrollController.offset == _scrollController.position.maxScrollExtent) {
          widget.callbackPagination();
        }
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
