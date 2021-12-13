import 'package:flutter_sample_redux/shopping_list/model/shopping_state.dart';
import 'package:flutter_sample_redux/shopping_list/model/cart_item.dart';
import 'package:flutter_sample_redux/shopping_list/redux/actions.dart';

ShoppingState appShoppingStateReducers(ShoppingState state, dynamic action) {
  if (action is AddItemAction) {
    return addItem(state.cartItems, action);
  } else if (action is ToggleItemStateAction) {
    return toggleItemState(state.cartItems, action);
  } else if (action is RemoveItemAction) {
    return removeItem(state.cartItems, action);
  } else if (action is ItemLoadedAction) {
    return loadItems(action);
  }

  return state;
}

ShoppingState addItem(List<CartItem> items, AddItemAction action) {
  return ShoppingState(List.from(items)..add(action.item));
}

ShoppingState toggleItemState(List<CartItem> items, ToggleItemStateAction action) {
  return ShoppingState(items
      .map((item) =>
          item.name == action.item ? CartItem(action.item, !item.checked) : item)
      .toList());
}

ShoppingState removeItem(List<CartItem> items, RemoveItemAction action) {
  return ShoppingState(List.from(items)..removeWhere((item) => item.name == action.item.name));
}

ShoppingState loadItems(ItemLoadedAction action) {
  return ShoppingState(action.items);
}