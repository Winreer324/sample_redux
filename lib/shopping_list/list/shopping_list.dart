import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_sample_redux/shopping_list/list/shopping_list_item.dart';
import 'package:flutter_sample_redux/shopping_list/model/cart_item.dart';
import 'package:flutter_sample_redux/shopping_list/model/shopping_state.dart';
import 'package:flutter_sample_redux/shopping_list/redux/actions.dart';
import 'package:redux/redux.dart';

class ShoppingList extends StatefulWidget {
  const ShoppingList({Key? key}) : super(key: key);

  @override
  _ShoppingListState createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<ShoppingState, ShoppingListViewModel>(
      converter: (store) => ShoppingListViewModel.build(store),
      builder: (context, viewModel) {
        return Column(
          children: <Widget>[
            FlatButton(
              onPressed: () => viewModel.onRefresh(_onViewStateChanged),
              child: const Text('Refresh'),
            ),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: viewModel.cartItems.length,
                      itemBuilder: (context, index) => ShoppingListItem(viewModel.cartItems[index]),
                    ),
            ),
          ],
        );
      },
    );
  }

  void _onViewStateChanged(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }
}

class ShoppingListViewModel {
  final List<CartItem> cartItems;
  final Function(OnStateChanged) onRefresh;

  ShoppingListViewModel({required this.cartItems, required this.onRefresh});

  static ShoppingListViewModel build(Store<ShoppingState> store) {
    return ShoppingListViewModel(
      cartItems: store.state.cartItems,
      onRefresh: (callback) {
        store.dispatch(FetchCartItemsAction(callback));
      },
    );
  }
}

typedef OnStateChanged = Function(bool isLoading);
