import 'package:built_redux/built_redux.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:flutter_sample_redux/gallery/enum/type_photo.dart';

import '../model/photo_entity.dart';

part 'actions_build.g.dart';

abstract class GalleryBuildActions extends ReduxActions {
  GalleryBuildActions._();

  factory GalleryBuildActions() = _$GalleryBuildActions;

  ActionDispatcher<TypePhoto> get fetchByTypePhotoAction;

  ActionDispatcher<AddAllPhotosActionPayload> get addAllPhotosAction;

  ActionDispatcher<TypePhoto> get fistLoadingAction;

  ActionDispatcher<bool> get paginationLoadingAction;

  ActionDispatcher<TypePhoto> get callRefreshAction;

  ActionDispatcher<bool> get refreshLoadingAction;
}

abstract class AddAllPhotosActionPayload implements Built<AddAllPhotosActionPayload, AddAllPhotosActionPayloadBuilder> {
  static Serializer<AddAllPhotosActionPayload> get serializer => _$addAllPhotosActionPayloadSerializer;

  bool get isClear;

  List<PhotoEntity> get photos;

  AddAllPhotosActionPayload._();

  factory AddAllPhotosActionPayload(bool isClear, List<PhotoEntity> photos) => _$AddAllPhotosActionPayload._(
        photos: photos,
        isClear: isClear,
      );
}

// class AddErrorAction extends Equatable {
//   final List<PhotoEntity>? photos;
//   final String? message;
//   final String? description;
//   final bool showDialog;
//
//   const AddErrorAction({
//     this.photos,
//     this.message,
//     this.description,
//     this.showDialog = false,
//   });
//
//   @override
//   List<Object> get props => [showDialog];
// }
