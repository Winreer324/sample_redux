import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_sample_redux/gallery/constants/api_constants.dart';
import 'package:flutter_sample_redux/gallery/exception/exception.dart';
import 'package:flutter_sample_redux/gallery/helpers/internet_connection.dart';

class ApiRequestHandler {
  static Future<E> sendRequest<E>({
    required Future<Response<dynamic>> request,
    required E Function(Map<String, dynamic>) converter,
  }) async {
    final hasConnect = await InternetConnection.hasInternetConnectivity();
    if (hasConnect) {
      try {
        final Response response = await request;

        if (!response.statusCode.toString().startsWith('2')) {
          throw _handleError(errorResponse: response);
        } else {
          return converter(response.data);
        }
      } on DioError catch (e) {
        throw _handleError(dioError: e);
      } catch (_) {
        throw UnknownError();
      }
    } else {
      throw NoInternetConnection();
    }
  }

  static Exception _handleError({Response<dynamic>? errorResponse, DioError? dioError}) {
    if (dioError?.type == DioErrorType.connectTimeout ||
        dioError?.type == DioErrorType.receiveTimeout ||
        dioError?.type == DioErrorType.sendTimeout) {
      return TimeoutError();
    }

    final Response<dynamic>? error = (errorResponse != null) ? errorResponse : dioError?.response;

    if (error == null) {
      return UnknownError();
    }

    switch (error.statusCode) {
      case 400:
        String? errorType;
        String? detail;
        if (error.data is String) {
          final Map<String, dynamic>? data = jsonDecode(error.data);
          if (data?.containsKey(ApiConstants.detail) ?? false) {
            detail = data![ApiConstants.detail];
          }
        } else if (error.data?.containsKey(ApiConstants.errorDescription) ?? false) {
          detail = error.data![ApiConstants.errorDescription];
          errorType = error.data![ApiConstants.errorType];
        }
        return UnknownError();
      case 401:
        String? detail;
        String? errorType;
        if (error.data is String) {
          final Map<String, dynamic>? data = jsonDecode(error.data);
          if (data?.containsKey(ApiConstants.detail) ?? false) {
            detail = data![ApiConstants.detail];
          }
        } else if (error.data?.containsKey(ApiConstants.errorDescription) ?? false) {
          detail = error.data![ApiConstants.errorDescription];
          errorType = error.data![ApiConstants.errorType];
        }

        return Unauthorized();
      case 403:
        return Forbidden(jsonDecode(error.data)[ApiConstants.detail]);
      case 404:
        return NotFound(jsonDecode(error.data)[ApiConstants.detail]);
      case 409:
        return Conflict(jsonDecode(error.data)[ApiConstants.detail]);
      case 500:
      case 502:
        return ServiceUnavailable();
      default:
        return UnknownError();
    }
  }
}
