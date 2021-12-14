import 'package:data_connection_checker/data_connection_checker.dart';

class NetworkInfo {
  final DataConnectionChecker dataConnectionChecker;

  NetworkInfo(this.dataConnectionChecker);

  Future<bool> get isConnected => dataConnectionChecker.hasConnection;
}
