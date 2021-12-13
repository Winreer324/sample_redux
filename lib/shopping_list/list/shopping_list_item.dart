import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_sample_redux/shopping_list/model/cart_item.dart';
import 'package:flutter_sample_redux/shopping_list/model/shopping_state.dart';
import 'package:flutter_sample_redux/shopping_list/redux/actions.dart';

class ShoppingListItem extends StatelessWidget {
  final CartItem item;

  const ShoppingListItem(this.item);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.name),
      leading: StoreConnector<ShoppingState, OnStateChanged>(converter: (store) {
        return (item) => store.dispatch(ToggleItemStateAction(item.name));
      }, builder: (context, callback) {
        return Checkbox(
            value: item.checked,
            onChanged: (bool? newValue) {
              callback(CartItem(item.name, newValue ?? false));
            });
      }),
      trailing: StoreConnector<ShoppingState, OnRemoveIconClicked>(
        converter: (store) {
          return (item) => store.dispatch(RemoveItemAction(item));
        },
        builder: (context, callback) {
          return IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              callback(CartItem(item.name, item.checked));
            },
          );
        },
      ),
    );
  }
}

typedef OnStateChanged = Function(CartItem item);

typedef OnRemoveIconClicked = Function(CartItem item);
