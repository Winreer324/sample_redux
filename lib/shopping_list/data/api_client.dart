import 'package:flutter_sample_redux/shopping_list/model/cart_item.dart';

class ApiClient {
  Future<List<CartItem>> fetchCartItems() {
    return Future.delayed(const Duration(seconds: 3), () {
      return [
        CartItem('Big red apple', false),
        CartItem('The quick brown fox', true),
        CartItem('The lazy dog', false),
      ];
    });
  }
}
