import 'package:dio/dio.dart';
import 'package:flutter_sample_redux/gallery/base/base_dio_request.dart';
import 'package:flutter_sample_redux/gallery/constants/api_constants.dart';
import 'package:flutter_sample_redux/gallery/enum/type_photo.dart';
import 'package:flutter_sample_redux/gallery/redux/model/pagination_response.dart';
import 'package:flutter_sample_redux/gallery/redux/model/photo_entity.dart';
import 'package:flutter_sample_redux/gallery/extensions/type_photo_extensions.dart';

abstract class PhotoRepository {
  Future<PaginationResponse<PhotoEntity>> fetchPhoto({
    required TypePhoto typePhoto,
    required int page,
    required int limit,
  });
}

class ApiPhotoRepository extends PhotoRepository {
  final Dio dio;

  ApiPhotoRepository({required this.dio});

  @override
  Future<PaginationResponse<PhotoEntity>> fetchPhoto({
    required TypePhoto typePhoto,
    required int page,
    required int limit,
  }) async {
    final queryParameters = {
      ApiConstants.queryParametersPage: page,
      ApiConstants.queryParametersLimit: limit,
      typePhoto.typePhotoByString.toLowerCase(): true,
    };

    return ApiRequestHandler.sendRequest<PaginationResponse<PhotoEntity>>(
      request: dio.get(ApiConstants.photos, queryParameters: queryParameters),
      converter: (json) => PaginationResponse<PhotoEntity>.fromJson(json),
    );
  }
}
