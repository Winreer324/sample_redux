import 'package:flutter_sample_redux/di/injection.dart';
import 'package:redux/redux.dart';
import 'package:redux_dev_tools/redux_dev_tools.dart';

import 'api_middleware.dart';
import 'gallery_state.dart';
import 'reducers.dart';
import 'package:flutter_sample_redux/gallery/redux/model/type_photo_generic.dart';

Future<Store<GalleryState<PhotoGeneric>>> createGalleryReduxStore<PhotoGeneric>() async {
  return DevToolsStore<GalleryState<PhotoGeneric>>(
    appGalleryStateReducers,
    initialState: GalleryState.empty(),
    middleware: [
      ApiGalleryMiddleware(photoRepository: injection()),
    ],
  );
}
