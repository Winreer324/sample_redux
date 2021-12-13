import 'package:flutter_sample_redux/shopping_list/data/api_client.dart';
import 'package:flutter_sample_redux/shopping_list/model/shopping_state.dart';
import 'package:flutter_sample_redux/shopping_list/redux/api_middleware.dart';
import 'package:flutter_sample_redux/shopping_list/redux/logging_middleware.dart';
import 'package:flutter_sample_redux/shopping_list/redux/prefs_middleware.dart';
import 'package:redux/redux.dart';
import 'package:redux_dev_tools/redux_dev_tools.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'reducers.dart';

Future<Store<ShoppingState>> createShoppingReduxStore() async {
  final apiClient = ApiClient();
  final sharedPreferences = await SharedPreferences.getInstance();

  return DevToolsStore<ShoppingState>(
    appShoppingStateReducers,
    initialState: ShoppingState.empty(),
    middleware: [
      ApiMiddleware(apiClient),
      PrefsMiddleware(sharedPreferences),
      LoggingMiddleware(),
    ],
  );
}
