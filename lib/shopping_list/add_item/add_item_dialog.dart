import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_sample_redux/shopping_list/model/shopping_state.dart';
import 'package:flutter_sample_redux/shopping_list/model/cart_item.dart';
import 'package:flutter_sample_redux/shopping_list/redux/actions.dart';

class AddItemDialog extends StatelessWidget {
  const AddItemDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<ShoppingState, OnItemAddedCallback>(
      converter: (store) {
        return (itemName) => store.dispatch(
              AddItemAction(CartItem(itemName, false)),
            );
      },
      builder: (context, callback) {
        return AddItemDialogWidget(callback);
      },
    );
  }
}

class AddItemDialogWidget extends StatefulWidget {
  final OnItemAddedCallback callback;

  const AddItemDialogWidget(this.callback, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AddItemDialogWidgetState();
}

class AddItemDialogWidgetState extends State<AddItemDialogWidget> {
  String? itemName;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(16.0),
      content: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              autofocus: true,
              decoration: const InputDecoration(labelText: 'Item name', hintText: 'eg. Red Apples'),
              onChanged: _handleTextChanged,
            ),
          )
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
            child: const Text('CANCEL'),
            onPressed: () {
              Navigator.pop(context);
            }),
        ElevatedButton(
            child: const Text('ADD'),
            onPressed: () {
              Navigator.pop(context);
              widget.callback(itemName ?? '');
            }),
      ],
    );
  }

  void _handleTextChanged(String newItemName) {
    setState(() {
      itemName = newItemName;
    });
  }
}

typedef OnItemAddedCallback = Function(String itemName);
