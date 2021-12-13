import 'package:equatable/equatable.dart';
import 'package:flutter_sample_redux/shopping_list/model/cart_item.dart';

class ShoppingState extends Equatable {
  final List<CartItem> cartItems;

  const ShoppingState(this.cartItems);

  ShoppingState.fromJson(Map<String, dynamic> json)
      : cartItems = (json['cartItems'] as List).map((i) => CartItem.fromJson(i as Map<String, dynamic>)).toList();

  factory ShoppingState.empty() => const ShoppingState([]);

  Map<String, dynamic> toJson() => {'cartItems': cartItems};

  @override
  String toString() => "$cartItems";

  @override
  List<Object> get props => [cartItems];
}
