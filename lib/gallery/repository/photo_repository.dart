import 'package:dio/dio.dart';
import 'package:flutter_sample_redux/gallery/base/base_dio_request.dart';
import 'package:flutter_sample_redux/gallery/constants/api_constants.dart';
import 'package:flutter_sample_redux/gallery/enum/type_photo.dart';
import 'package:flutter_sample_redux/gallery/extensions/type_photo_extensions.dart';
import 'package:flutter_sample_redux/gallery/redux/model/pagination_response.dart';
import 'package:flutter_sample_redux/gallery/redux/model/photo_entity.dart';

abstract class PhotoRepository<T> {
  Future<PaginationResponse<PhotoEntity>> fetchPhoto({required TypePhoto typePhoto, int? page, int? limit = 14});

  late int countOfPages;

  late int page;
}

class ApiPhotoRepository<T> extends PhotoRepository<T> {
  final Dio dio;

  ApiPhotoRepository({required this.dio});

  int _page = 1;
  int _countOfPages = 1;

  @override
  int get countOfPages => _countOfPages;

  @override
  set countOfPages(int countOfPages) => _countOfPages = countOfPages;

  @override
  int get page => _page;

  @override
  set page(int page) => _page = page;

  @override
  Future<PaginationResponse<PhotoEntity>> fetchPhoto({
    required TypePhoto typePhoto,
    int? page,
    int? limit = 14,
  }) async {
    final queryParameters = {
      ApiConstants.queryParametersPage: page ?? _page,
      ApiConstants.queryParametersLimit: limit,
      typePhoto.typePhotoByString.toLowerCase(): true,
    };

    return ApiRequestHandler.sendRequest<PaginationResponse<PhotoEntity>>(
      request: dio.get(ApiConstants.photos, queryParameters: queryParameters),
      converter: (json) {
        final PaginationResponse<PhotoEntity> response = PaginationResponse<PhotoEntity>.fromJson(json);
        if (response.items.isNotEmpty) {
          _page++;
          _countOfPages = response.countOfPages;
        }
        return response;
      },
    );
  }
}
