import 'package:flutter_sample_redux/shopping_list/model/shopping_state.dart';
import 'package:redux/redux.dart';
import 'package:redux_dev_tools/redux_dev_tools.dart';

class LoggingMiddleware extends MiddlewareClass<ShoppingState> {
  @override
  void call(Store<ShoppingState> store, action, NextDispatcher next) {
    next(action);

    if (action is! DevToolsAction) {
      print('Action: $action');
      print('State: ${store.state.toJson()}');
    }
  }
}
