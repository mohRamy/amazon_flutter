import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../cart_repo/cart_repo.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/constants/error_handling.dart';
import '../../../controller/user_controller.dart';
import '../../../models/cart_model.dart';
import '../../../models/product_model.dart';
import '../../../models/user_model.dart';
import '../../product_details/product_details_repo/product_details_repo.dart';

class CartCtrl extends GetxController implements GetxService {
  final CartRepo cartRepo;
  CartCtrl({
    required this.cartRepo,
  });

  final ProductDetailsRepo productDetailsRepo =
      ProductDetailsRepo(apiClient: Get.find());

  void removeFromCart({
    required ProductModel product,
  }) async {
    UserCtrl userController = Get.find<UserCtrl>();

    try {
      http.Response res = await cartRepo.removeFromCart(product: product);

      httpErrorHandle(
        res: res,
        onSuccess: () {
          UserModel user =
              userController.user.copyWith(cart: jsonDecode(res.body)['cart']);
          userController.setUserFromModel(user);
        },
      );
      update();
    } catch (e) {
      Get.snackbar('', e.toString());
    }
  }

  ///////////////////////////////////////

  late Map<String, CartModel> _items = {};
  Map<String, CartModel> get items => _items;

  List<CartModel> storageItems = [];

  void addItem(String? id, ProductModel product, int quantity) {
    if (_items.containsKey(id)) {
      if (quantity > 0) {
        _items.update(
          id!,
          (value) {
            return CartModel(
              id: value.id,
              name: value.name,
              price: value.price,
              image: value.image,
              isExist: true,
              quantity: quantity,
              time: DateTime.now().toString(),
              rating: value.rating,
              product: product,
            );
          },
        );
      } else {
        _items.remove(id);
      }
    } else {
      if (quantity > 0) {
        _items.putIfAbsent(id!, () {
          return CartModel(
            id: product.id,
            image: product.images[0],
            name: product.name,
            price: product.price,
            isExist: true,
            quantity: quantity,
            time: DateTime.now().toString(),
            rating: product.rating,
            product: product,
          );
        });
      } else {
        Get.snackbar('no Add', 'no Add');
      }
    }
    cartRepo.addToCartList(getItems);
    update();
  }

  int getQuantity(ProductModel product) {
    int quantity = 0;
    if (_items.containsKey(product.id)) {
      _items.forEach((key, value) {
        if (key == product.id) {
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }

  int get totalItems {
    Rx<int> totalQuantity = 0.obs;
    _items.forEach((key, value) {
      totalQuantity.value += value.quantity!;
    });
    return totalQuantity.value;
  }

  List<CartModel> get getItems {
    return _items.entries.map((e) {
      return e.value;
    }).toList();
  }

  int get totalAmount {
    int total = 0;
    _items.forEach((key, value) {
      total += value.quantity! * value.price!;
    });
    return total;
  }

  int get totalOldAmount {
    int totalOld = 0;
    _items.forEach((key, value) {
      totalOld += value.quantity! * value.product!.oldPrice;
    });
    return totalOld;
  }

  void addToCartList() {
    cartRepo.addToCartList(getItems);
    update();
  }

  List<CartModel> getCartList() {
    setCart = cartRepo.getCartList();
    return storageItems;
  }

  set setCart(List<CartModel> items) {
    storageItems = items;
    for (int i = 0; i < storageItems.length; i++) {
      _items.putIfAbsent(storageItems[i].id!, () => storageItems[i]);
    }
    update();
  }

  void addToCartHistoryList() {
    cartRepo.addToCartHistoryList();
    clear();
    update();
  }

  void clear() {
    _items.clear();
    update();
  }

  List<CartModel> getCartHistoryList() {
    return cartRepo.getCartHistoryList();
  }

  set setItems(Map<String, CartModel> setItems) {
    _items = {};
    _items = setItems;
    update();
  }

  void clearCartHistory() {
    cartRepo.clearCartHistory();
    update();
  }

  final Rx<int> quantity = 0.obs;

  final Rx<bool> _isValid = false.obs;
  Rx<bool> get isValid => _isValid;

  void setQuantity(bool isIncrement, int productQuantity) {
    if (isIncrement) {
      quantity.value = checkQuantity(quantity.value + 1, productQuantity);
    } else {
      quantity.value = checkQuantity(quantity.value - 1, productQuantity);
    }
  }

  int checkQuantity(int quantity, int productQuantity) {
    if (quantity > productQuantity) {
      Get.snackbar(
        'Item count',
        "You ordered more than the available quantity \n available quantity is $productQuantity !",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      _isValid.value = false;
      return productQuantity;
    } else {
      _isValid.value = true;
      return quantity;
    }
  }
}
