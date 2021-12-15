import 'package:equatable/equatable.dart';
import 'package:flutter_sample_redux/gallery/redux/model/photo_entity.dart';

class GalleryState<PhotoGeneric> extends Equatable {
  final List<PhotoEntity> photos;
  final bool isLoading;
  final bool isLoadingPagination;
  final bool isLoadingRefresh;

  const GalleryState({
    required this.photos,
    this.isLoading = true,
    this.isLoadingPagination = false,
    this.isLoadingRefresh = false,
  });

  factory GalleryState.empty() => GalleryState<PhotoGeneric>(photos: const []);

  GalleryState<PhotoGeneric> copyWith({
    List<PhotoEntity>? photos,
    bool? isLoading,
    bool? isLoadingPagination,
    bool? isLoadingRefresh,
  }) {
    return GalleryState<PhotoGeneric>(
      photos: photos ?? this.photos,
      isLoading: isLoading ?? this.isLoading,
      isLoadingPagination: isLoadingPagination ?? this.isLoadingPagination,
      isLoadingRefresh: isLoadingRefresh ?? this.isLoadingRefresh,
    );
  }

  @override
  List<Object> get props => [photos, isLoading, isLoadingPagination];
}
