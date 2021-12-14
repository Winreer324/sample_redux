import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_sample_redux/gallery/redux/gallery_state.dart';
import 'package:flutter_sample_redux/gallery/resources/resources.dart';
import 'package:flutter_sample_redux/gallery/widgets/animation_loader.dart';
import 'package:flutter_sample_redux/gallery/widgets/custom_refresh_indicator.dart';

class RefreshWidget<T> extends StatefulWidget {
  final Function() callRefresh;
  final Widget child;
  final bool isLoading;
  final ScrollController scrollController;

  const RefreshWidget({
    Key? key,
    required this.callRefresh,
    required this.scrollController,
    required this.child,
    this.isLoading = false,
  }) : super(key: key);

  @override
  _RefreshWidgetState<T> createState() => _RefreshWidgetState<T>();
}

class _RefreshWidgetState<T> extends State<RefreshWidget> {
  Completer<void>? _refreshCompleter;

  @override
  void initState() {
    _refreshCompleter = Completer<void>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<GalleryState<T>, GalleryState<T>>(
      converter: (store) => store.state,
      onWillChange: (previousState, newState) {
        if (previousState?.isLoadingRefresh == true) {
          _updateRefresh();
        }
      },
      builder: (context, state) {
        if (state.photos.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return CustomRefreshIndicator(
          onRefresh: () async {
            widget.callRefresh();
            return _refreshCompleter?.future ?? Future.value();
          },
          builderHeader: (_, value, showIndeterminateIndicator) {
            return AnimationLoader(
              color: AppColors.baseColor,
              valueRotate: value,
              showIndeterminateIndicator: showIndeterminateIndicator,
            );
          },
          child: widget.child,
        );
      },
    );
  }

  void _updateRefresh() {
    if (mounted) {
      setState(() {
        _refreshCompleter?.complete();
        _refreshCompleter = Completer();
      });
    }
  }
}
