import 'package:alice/alice.dart';
import 'package:flutter/foundation.dart';

class ApiConstants {
  static const String basePathMedia = 'http://gallery.dev.webant.ru/media/';
  static const String baseUrl = "http://gallery.dev.webant.ru/api/";
  static Alice alice = Alice(showNotification: !kReleaseMode, showInspectorOnShake: true, darkTheme: true);
  static const int limitItems = 14;
  static const int defaultPage = 1;

  /// end point
  static const String photos = 'photos';

  /// keys
  static const String queryParametersPage = 'page';
  static const String queryParametersLimit = 'limit';
  static const String newType = 'New';
  static const String popularType = 'Popular';

  /// common
  static const String detail = 'detail';
  static const String errorDescription = 'error_description';
  static const String errorType = 'error';

  static const int timeoutDurationInMilliseconds = 60 * 1000;
}
