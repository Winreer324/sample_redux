import 'dart:async';

import 'package:data_connection_checker/data_connection_checker.dart';

class InternetConnection {
  static Future<bool> hasInternetConnectivity() async {
    final hasConnection = await DataConnectionChecker().hasConnection;

    return hasConnection;
  }
}
