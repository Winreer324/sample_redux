import 'dart:async';
import 'dart:convert';

import 'package:flutter_sample_redux/shopping_list/model/shopping_state.dart';
import 'package:flutter_sample_redux/shopping_list/redux/actions.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String APP_STATE_KEY = "APP_STATE";

class PrefsMiddleware extends MiddlewareClass<ShoppingState> {
  final SharedPreferences preferences;

  PrefsMiddleware(this.preferences);

  @override
  Future<void> call(Store<ShoppingState> store, action, NextDispatcher next) async {
    if (action is AddItemAction ||
        action is ToggleItemStateAction ||
        action is RemoveItemAction) {
      await _saveStateToPrefs(store.state);
    }

    if (action is FetchItemsAction) {
      await _loadStateFromPrefs(store);
    }

    next(action);
  }

  Future _saveStateToPrefs(ShoppingState state) async {
    var stateString = json.encode(state.toJson());
    await preferences.setString(APP_STATE_KEY, stateString);
  }

  Future _loadStateFromPrefs(Store<ShoppingState> store) async {
    String? stateString = preferences.getString(APP_STATE_KEY);
    if (stateString == null) return;
    ShoppingState state = ShoppingState.fromJson(json.decode(stateString));
    store.dispatch(ItemLoadedAction(state.cartItems));
  }
}
