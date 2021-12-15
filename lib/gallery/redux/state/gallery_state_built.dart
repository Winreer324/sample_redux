import 'package:built_value/built_value.dart';
import 'package:flutter_sample_redux/gallery/redux/model/photo_entity.dart';

part 'gallery_state_built.g.dart';

abstract class GalleryStateBuilt<PhotoGeneric>
    implements Built<GalleryStateBuilt<PhotoGeneric>, GalleryStateBuiltBuilder<PhotoGeneric>> {
  // static Serializer<GalleryStateBuilt> get serializer => _$galleryStateBuiltSerializer;

  List<PhotoEntity> get photos;

  bool get isLoading;

  bool get isLoadingPagination;

  bool get isLoadingRefresh;

  GalleryStateBuilt._();

  factory GalleryStateBuilt.loading() => GalleryStateBuilt<PhotoGeneric>((b) => b..isLoading = true);

  factory GalleryStateBuilt.loadingPagination() =>
      GalleryStateBuilt<PhotoGeneric>((b) => b..isLoadingPagination = true);

  factory GalleryStateBuilt.loadingRefresh() => GalleryStateBuilt<PhotoGeneric>((b) => b..isLoadingRefresh = true);

  factory GalleryStateBuilt([void Function(GalleryStateBuiltBuilder<PhotoGeneric> b)? updates]) =>
      _$GalleryStateBuilt<PhotoGeneric>((b) => b
        ..photos = []
        ..isLoading = false
        ..isLoadingPagination = false
        ..isLoadingRefresh = false
        ..update(updates));
}
