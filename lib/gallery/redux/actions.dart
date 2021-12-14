import 'package:equatable/equatable.dart';
import 'package:flutter_sample_redux/gallery/enum/type_photo.dart';
import 'package:flutter_sample_redux/gallery/redux/model/photo_entity.dart';

class FetchByTypePhotoAction extends Equatable {
  final TypePhoto typePhoto;

  const FetchByTypePhotoAction(this.typePhoto);

  @override
  List<Object> get props => [typePhoto];
}

class AddAllPhotosAction extends Equatable {
  final List<PhotoEntity> photos;
  final bool isClear;

  const AddAllPhotosAction(this.photos, {this.isClear = false});

  @override
  List<Object> get props => [photos];
}

class FistLoadingAction extends Equatable {
  final TypePhoto typePhoto;

  const FistLoadingAction(this.typePhoto);

  @override
  List<Object> get props => [typePhoto];
}

class PaginationLoadingAction {
  final bool isLoadingPagination;

  PaginationLoadingAction(this.isLoadingPagination);
}

class AddErrorAction extends Equatable {
  final List<PhotoEntity>? photos;
  final String? message;
  final String? description;
  final bool showDialog;

  const AddErrorAction({
    this.photos,
    this.message,
    this.description,
    this.showDialog = false,
  });

  @override
  List<Object> get props => [showDialog];
}

class CallRefreshAction extends Equatable {
  final TypePhoto typePhoto;

  const CallRefreshAction(this.typePhoto);

  @override
  List<Object> get props => [typePhoto];
}

class RefreshLoadingAction {
  const RefreshLoadingAction();
}
