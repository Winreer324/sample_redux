import 'package:flutter_sample_redux/di/injection.dart';
import 'package:flutter_sample_redux/gallery/repository/photo_repository.dart';
import 'package:redux/redux.dart';
import 'package:redux_dev_tools/redux_dev_tools.dart';

import '../middleware/api_middleware.dart';
import '../state/gallery_state.dart';
import '../reducers/reducers.dart';

Future<Store<GalleryState<PhotoGeneric>>> createGalleryReduxStore<PhotoGeneric>() async {
  return DevToolsStore<GalleryState<PhotoGeneric>>(
    appGalleryStateReducers,
    initialState: GalleryState.empty(),
    middleware: [
      ApiGalleryMiddleware<PhotoGeneric>(photoRepository: injection<PhotoRepository<PhotoGeneric>>()),
    ],
  );
}

