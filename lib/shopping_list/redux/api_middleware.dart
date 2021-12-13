import 'package:flutter_sample_redux/shopping_list/data/api_client.dart';
import 'package:flutter_sample_redux/shopping_list/model/shopping_state.dart';
import 'package:flutter_sample_redux/shopping_list/model/cart_item.dart';
import 'package:flutter_sample_redux/shopping_list/redux/actions.dart';
import 'package:redux/redux.dart';

class ApiMiddleware extends MiddlewareClass<ShoppingState> {
  final ApiClient apiClient;

  ApiMiddleware(this.apiClient);

  @override
  Future call(Store<ShoppingState> store, action, NextDispatcher next) async {
    if (action is FetchCartItemsAction) {
      return _fetchCartItems(store, action);
    }

    next(action);
  }

  Future _fetchCartItems(
    Store<ShoppingState> store,
    FetchCartItemsAction action,
  ) async {
    action.callback(true);
    List<CartItem> cartItems = await apiClient.fetchCartItems();
    store.dispatch(ItemLoadedAction(cartItems));
    action.callback(false);
  }
}
