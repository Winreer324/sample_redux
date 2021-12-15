import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_sample_redux/flutter_built_redux.dart';
import 'package:flutter_sample_redux/gallery/redux/actions/actions_build.dart';
import 'package:flutter_sample_redux/gallery/redux/state/gallery_state_built.dart';
import 'package:flutter_sample_redux/gallery/resources/resources.dart';
import 'package:flutter_sample_redux/gallery/widgets/animation_loader.dart';
import 'package:flutter_sample_redux/gallery/widgets/custom_refresh_indicator.dart';

class RefreshWidgetBuilt<T> extends StoreConnector<GalleryStateBuilt<T>, GalleryBuildActions, bool> {
  final Function() callRefresh;
  final Widget child;
  final bool isLoading;

  const RefreshWidgetBuilt({
    Key? key,
    required this.callRefresh,
    required this.child,
    required this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, bool state, GalleryBuildActions actions) {
    return _RefreshWidgetBuiltState(
      loading: state,
      callRefresh: callRefresh,
      child: child,
    );
  }

  @override
  bool connect(GalleryStateBuilt<T> state) => state.isLoadingRefresh;
}

class _RefreshWidgetBuiltState extends StatefulWidget {
  final bool loading;
  final Function() callRefresh;
  final Widget child;

  const _RefreshWidgetBuiltState({
    Key? key,
    required this.loading,
    required this.callRefresh,
    required this.child,
  }) : super(key: key);

  @override
  _RefreshWidgetBuiltStateState createState() => _RefreshWidgetBuiltStateState();
}

class _RefreshWidgetBuiltStateState extends State<_RefreshWidgetBuiltState> {
  Completer<void>? _refreshCompleter;

  @override
  void initState() {
    _refreshCompleter = Completer<void>();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant _RefreshWidgetBuiltState oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!widget.loading) {
      _updateRefresh();
    }
  }

  @override
  Widget build(BuildContext context) {
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
  }

  void _updateRefresh() {
    if (mounted) {
      _refreshCompleter?.complete();
      _refreshCompleter = Completer();
      setState(() {});
    }
  }
}
