import 'package:flutter_sample_redux/gallery/constants/api_constants.dart';
import 'package:flutter_sample_redux/gallery/enum/type_photo.dart';

extension TypePhotoExtensions on TypePhoto {
  String get typePhotoByString {
    switch (this) {
      case TypePhoto.newPhoto:
        return ApiConstants.newType;
      case TypePhoto.popularPhoto:
        return ApiConstants.popularType;
      default:
        return '';
    }
  }
}
