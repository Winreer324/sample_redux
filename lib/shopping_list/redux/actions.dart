import 'package:equatable/equatable.dart';
import 'package:flutter_sample_redux/shopping_list/list/shopping_list.dart';
import 'package:flutter_sample_redux/shopping_list/model/cart_item.dart';

class AddItemAction extends Equatable {
  final CartItem item;

  const AddItemAction(this.item);

  @override
  List<Object> get props => [item];
}

class ToggleItemStateAction extends Equatable {
  final String item;

  const ToggleItemStateAction(this.item);

  @override
  List<Object> get props => [item];
}

class FetchItemsAction extends Equatable {
  @override
  List<Object> get props => [];
}

class ItemLoadedAction extends Equatable {
  final List<CartItem> items;

  const ItemLoadedAction(this.items);

  @override
  List<Object> get props => [items];
}

class RemoveItemAction extends Equatable {
  final CartItem item;

  const RemoveItemAction(this.item);

  @override
  List<Object> get props => [item];
}

class FetchCartItemsAction extends Equatable {
  final OnStateChanged callback;

  const FetchCartItemsAction(this.callback);

  @override
  List<Object> get props => [callback];
}
