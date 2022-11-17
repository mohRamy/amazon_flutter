import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/api/api_client.dart';

import '../../../core/utils/app_strings.dart';
import '../../../core/utils/constants/global_variables.dart';
import '../../../models/cart_model.dart';
import '../../../models/product_model.dart';

class CartRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  CartRepo({
    required this.apiClient,
    required this.sharedPreferences,
  });
  Future<http.Response> removeFromCart({
    required ProductModel product,
  }) async {
    return await apiClient
        .deleteData('$uri/api/remove-from-cart/${product.id}');
  }

  ///////////////////////////////

  List<String> cart = [];
  List<String> cartHistory = [];

  void addToCartList(List<CartModel> cartList) {
    String time = DateTime.now().toString();
    cart = [];
    for (var element in cartList) {
      element.time = time;
      cart.add(jsonEncode(element));
    }
    sharedPreferences.setStringList(AppString.CART_KEY, cart);
  }

  void addToCartHistoryList() {
    if (sharedPreferences.containsKey(AppString.CART_HISTORY_KEY)) {
      cartHistory =
          sharedPreferences.getStringList(AppString.CART_HISTORY_KEY)!;
    }

    for (int i = 0; i < cart.length; i++) {
      cartHistory.add(cart[i]);
    }
    removeCart();
    sharedPreferences.setStringList(AppString.CART_HISTORY_KEY, cartHistory);
  }

  List<CartModel> getCartList() {
    List<String> carts = [];

    if (sharedPreferences.containsKey(AppString.CART_KEY)) {
      carts = sharedPreferences.getStringList(AppString.CART_KEY) ?? [];
    }

    List<CartModel> cartList = [];
    for (var element in carts) {
      cartList.add(CartModel.fromJson(jsonDecode(element)));
    }
    return cartList;
  }

  List<CartModel> getCartHistoryList() {
    List<String> cartsHistory = [];
    if (sharedPreferences.containsKey(AppString.CART_HISTORY_KEY)) {
      cartsHistory =
          sharedPreferences.getStringList(AppString.CART_HISTORY_KEY) ?? [];
    }
    List<CartModel> cartListHistory = [];
    for (var element in cartsHistory) {
      cartListHistory.add(CartModel.fromJson(jsonDecode(element)));
    }
    return cartListHistory;
  }

  void removeCart() {
    cart = [];
    sharedPreferences.remove(AppString.CART_KEY);
  }

  void clearCartHistory() {
    removeCart();
    cartHistory = [];
    sharedPreferences.remove(AppString.CART_HISTORY_KEY);
  }
}
