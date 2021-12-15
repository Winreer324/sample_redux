// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:built_redux/built_redux.dart';
import 'package:flutter_sample_redux/gallery/redux/model/photo_entity.dart';

import '../actions/actions_build.dart';
import '../state/gallery_state_built.dart';

ReducerBuilder<GalleryStateBuilt<PhotoGeneric>, GalleryStateBuiltBuilder<PhotoGeneric>> reducerBuilder<PhotoGeneric>() =>
    ReducerBuilder<GalleryStateBuilt<PhotoGeneric>, GalleryStateBuiltBuilder<PhotoGeneric>>()
      ..add(GalleryBuildActionsNames.addAllPhotosAction, _addAllPhotosAction)
      ..add(GalleryBuildActionsNames.paginationLoadingAction, _paginationLoadingAction)
      ..add(GalleryBuildActionsNames.refreshLoadingAction, _refreshLoadingAction);

void _addAllPhotosAction<PhotoGeneric>(
  GalleryStateBuilt<PhotoGeneric> state,
  Action<AddAllPhotosActionPayload> action,
  GalleryStateBuiltBuilder builder,
) {
  final List<PhotoEntity> photos = [];

  if (!action.payload.isClear) {
    photos.addAll(state.photos);
  }
  photos.addAll(action.payload.photos);

  builder
    ..isLoading = false
    ..isLoadingRefresh = false
    ..photos = photos;
}

void _paginationLoadingAction<PhotoGeneric>(
    GalleryStateBuilt<PhotoGeneric> state, Action<bool> action, GalleryStateBuiltBuilder builder) {
  builder.isLoadingPagination = action.payload;
}

void _refreshLoadingAction<PhotoGeneric>(
    GalleryStateBuilt<PhotoGeneric> state, Action<bool> action, GalleryStateBuiltBuilder builder) {
  builder.isLoadingRefresh = action.payload;
}
