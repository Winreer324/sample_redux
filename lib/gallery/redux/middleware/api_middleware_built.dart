import 'package:built_redux/built_redux.dart';
import 'package:flutter_sample_redux/gallery/enum/type_photo.dart';
import 'package:flutter_sample_redux/gallery/redux/actions/actions_build.dart';
import 'package:flutter_sample_redux/gallery/redux/model/pagination_response.dart';
import 'package:flutter_sample_redux/gallery/redux/model/photo_entity.dart';
import 'package:flutter_sample_redux/gallery/redux/state/gallery_state_built.dart';
import 'package:flutter_sample_redux/gallery/repository/photo_repository.dart';

Middleware<GalleryStateBuilt, GalleryStateBuiltBuilder, GalleryBuildActions> createStoreTodosMiddleware({
  required PhotoRepository photoRepository,
}) {
  return (MiddlewareBuilder<GalleryStateBuilt, GalleryStateBuiltBuilder, GalleryBuildActions>()
        ..add(GalleryBuildActionsNames.fistLoadingAction, _fetchItems(photoRepository))
        ..add(GalleryBuildActionsNames.fetchByTypePhotoAction, _fetchItems(photoRepository))
        ..add(GalleryBuildActionsNames.callRefreshAction, _fetchItems(photoRepository, isRefresh: true)))
      .build();
}

MiddlewareHandler<GalleryStateBuilt, GalleryStateBuiltBuilder, GalleryBuildActions, void> _fetchItems(
  PhotoRepository photoRepository, {
  bool isRefresh = false,
}) {
  return (MiddlewareApi<GalleryStateBuilt, GalleryStateBuiltBuilder, GalleryBuildActions> api, ActionHandler next,
      Action<void> action) async {
    try {
      if (isRefresh) {
        photoRepository.page = 1;
        photoRepository.countOfPages = 1;
        api.actions.refreshLoadingAction(true);
      }
      if (photoRepository.page <= photoRepository.countOfPages) {
        if (api.state.photos.isNotEmpty && !isRefresh) {
          api.actions.paginationLoadingAction(true);
        }

        PaginationResponse<PhotoEntity> response = await photoRepository.fetchPhoto(
          typePhoto: TypePhoto.newPhoto,
        );

        if (api.state.photos.isNotEmpty && !isRefresh) {
          api.actions.paginationLoadingAction(false);
        }
        //
        api.actions.addAllPhotosAction(AddAllPhotosActionPayload(isRefresh, response.items));
      } else {
        api.actions.addAllPhotosAction(AddAllPhotosActionPayload(false, []));
      }
    } catch (e) {
      if (api.state.photos.isNotEmpty && !isRefresh) {
        api.actions.paginationLoadingAction(false);
      }
      // store.dispatch(AddErrorAction(message: e.toString()));
    } finally {
      if (isRefresh) {
        api.actions.refreshLoadingAction(false);
      }
    }

    next(action);
  };
}
