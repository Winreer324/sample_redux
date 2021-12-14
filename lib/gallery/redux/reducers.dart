import 'package:flutter_sample_redux/gallery/redux/model/photo_entity.dart';

import 'actions.dart';
import 'gallery_state.dart';

GalleryState<PhotoGeneric> appGalleryStateReducers<PhotoGeneric>(GalleryState<PhotoGeneric> state, dynamic action) {
  if (action is AddAllPhotosAction) {
    return _addAllPhotosAction<PhotoGeneric>(state, action);
  }
  if (action is PaginationLoadingAction) {
    return _paginationLoadingAction<PhotoGeneric>(state, action);
  }
  if (action is AddErrorAction) {
    return _addErrorAction<PhotoGeneric>(state, action);
  }
  if (action is RefreshLoadingAction) {
    return _refreshLoadingAction<PhotoGeneric>(state, action);
  }

  return state;
}

GalleryState<PhotoGeneric> _addAllPhotosAction<PhotoGeneric>(
    GalleryState<PhotoGeneric> state, AddAllPhotosAction action) {
  final List<PhotoEntity> photos = [];

  if (!action.isClear) {
    photos.addAll(state.photos);
  }
  photos.addAll(action.photos);
  return state.copyWith(
    isLoading: false,
    photos: photos,
    isLoadingRefresh: false,
    isLoadingPagination: false,
  );
}

GalleryState<PhotoGeneric> _addErrorAction<PhotoGeneric>(GalleryState<PhotoGeneric> state, AddErrorAction action) {
  return state.copyWith(
    isLoading: false,
    photos: state.photos,
    isLoadingRefresh: false,
    isLoadingPagination: false,
  );
}

GalleryState<PhotoGeneric> _paginationLoadingAction<PhotoGeneric>(
    GalleryState<PhotoGeneric> state, PaginationLoadingAction action) {
  return state.copyWith(
    isLoadingPagination: action.isLoadingPagination,
    photos: state.photos,
  );
}

GalleryState<PhotoGeneric> _refreshLoadingAction<PhotoGeneric>(
    GalleryState<PhotoGeneric> state, RefreshLoadingAction action) {
  return state.copyWith(
    photos: state.photos,
    isLoadingRefresh: true,
  );
}
