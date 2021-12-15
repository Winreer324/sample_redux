import 'package:built_redux/built_redux.dart';
import 'package:flutter_sample_redux/gallery/redux/state/gallery_state_built.dart';
import 'package:flutter_sample_redux/gallery/repository/photo_repository.dart';

import '../actions/actions_build.dart';
import '../middleware/api_middleware_built.dart';
import '../reducers/reducers_built.dart';

Store<GalleryStateBuilt<PhotoGeneric>, GalleryStateBuiltBuilder<PhotoGeneric>, GalleryBuildActions>
    storeBuilt<PhotoGeneric>(PhotoRepository photoRepository) =>
        Store<GalleryStateBuilt<PhotoGeneric>, GalleryStateBuiltBuilder<PhotoGeneric>, GalleryBuildActions>(
          reducerBuilder<PhotoGeneric>().build(),
          GalleryStateBuilt<PhotoGeneric>.loading(),
          GalleryBuildActions(),
          middleware: [
            createStoreTodosMiddleware(photoRepository: photoRepository),
          ],
        );
