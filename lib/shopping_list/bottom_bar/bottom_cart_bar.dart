import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_sample_redux/shopping_list/model/shopping_state.dart';
import 'package:redux/redux.dart';

class BottomCartBar extends StatelessWidget {
  const BottomCartBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<ShoppingState, int>(
      converter: (Store<ShoppingState> store) =>
          store.state.cartItems.where((item) => item.checked).length,
      builder: (BuildContext context, int cartItemsLength) {
        return Container(
          color: Colors.grey[800],
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                Text(
                  '$cartItemsLength selected items',
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
