import 'package:flutter_sample_redux/gallery/enum/type_photo.dart';
import 'package:flutter_sample_redux/gallery/redux/actions/actions.dart';
import 'package:flutter_sample_redux/gallery/repository/photo_repository.dart';
import 'package:redux/redux.dart';

import '../state/gallery_state.dart';
import '../model/pagination_response.dart';
import '../model/photo_entity.dart';

class ApiGalleryMiddleware<PhotoGeneric> extends MiddlewareClass<GalleryState> {
  final PhotoRepository photoRepository;

  ApiGalleryMiddleware({required this.photoRepository});

  int limit = 14;
  int page = 1;
  int countOfPage = 1;

  @override
  Future call(Store<GalleryState> store, action, NextDispatcher next) async {
    if (action is FetchByTypePhotoAction) {
      return _fetchItems(store, action.typePhoto);
    }

    if (action is FistLoadingAction) {
      return _fetchItems(store, action.typePhoto);
    }

    if (action is CallRefreshAction) {
      return _fetchItems(store, action.typePhoto, isRefresh: true);
    }

    next(action);
  }

  Future<void> _fetchItems(
    Store<GalleryState> store,
    TypePhoto typePhoto, {
    bool isRefresh = false,
  }) async {
    try {
      if (isRefresh) {
        page = 1;
        countOfPage = 1;
        store.dispatch(const RefreshLoadingAction());
      }
      if (page <= countOfPage) {
        if (store.state.photos.isNotEmpty && !isRefresh) {
          store.dispatch(PaginationLoadingAction(true));
        }

        PaginationResponse<PhotoEntity> response = await photoRepository.fetchPhoto(
          typePhoto: typePhoto,
          page: page,
          limit: limit,
        );

        page++;
        countOfPage = response.countOfPages;

        if (store.state.photos.isNotEmpty && !isRefresh) {
          store.dispatch(PaginationLoadingAction(false));
        }

        store.dispatch(AddAllPhotosAction(response.items, isClear: isRefresh));
      } else {
        store.dispatch(const AddAllPhotosAction([],));
      }
    } catch (e) {
      if (store.state.photos.isNotEmpty && !isRefresh) {
        store.dispatch(PaginationLoadingAction(false));
      }
      store.dispatch(AddErrorAction(message: e.toString()));
    }
  }
}
