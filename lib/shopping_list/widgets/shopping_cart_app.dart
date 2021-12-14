import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_sample_redux/shopping_list/add_item/add_item_dialog.dart';
import 'package:flutter_sample_redux/shopping_list/bottom_bar/bottom_cart_bar.dart';
import 'package:flutter_sample_redux/shopping_list/list/shopping_list.dart';
import 'package:flutter_sample_redux/shopping_list/model/shopping_state.dart';
import 'package:flutter_sample_redux/shopping_list/redux/actions.dart';

class ShoppingCartScreen extends StatelessWidget {
  const ShoppingCartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoreBuilder<ShoppingState>(
        onInit: (store) => store.dispatch(FetchItemsAction()),
        builder: (context, store) => ShoppingCart(store.state),
      ),
    );
  }
}

class ShoppingCart extends StatelessWidget {
  final ShoppingState store;

  const ShoppingCart(this.store, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ShoppingList'),
      ),
      body: const ShoppingList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openAddItemDialog(context),
        child: const Icon(Icons.add),
      ),
      bottomSheet: const BottomCartBar(),
      endDrawer: Container(
        width: 240.0,
        color: Colors.white,
        child: const Text('ReduxDevTools'),
      ),
    );
  }

  void _openAddItemDialog(BuildContext context) {
    showDialog(context: context, builder: (context) => const AddItemDialog());
  }
}
