import 'dart:convert';

import '../../cart/cart_ctrl/cart_ctrl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../product_details_repo/product_details_repo.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/constants/error_handling.dart';
import '../../../controller/user_controller.dart';
import '../../../models/product_model.dart';
import '../../../models/user_model.dart';

class ProductDetailsCtrl extends GetxController implements GetxService {
  final ProductDetailsRepo productDetailsRepo;
  ProductDetailsCtrl({
    required this.productDetailsRepo,
  });

  Rx<double> avgRating = Rx(0);
  Rx<double> myRating = Rx(0);

  void addToCart({
    required ProductModel product,
    required int ord,
  }) async {
    try {
      http.Response res = await productDetailsRepo.addToCart(
        product: product,
        ord: ord,
      );

      httpErrorHandle(
        res: res,
        onSuccess: () {},
      );
      update();
    } catch (e) {
      Get.snackbar('', '222222222222222222');
    }
  }

  void rateProduct({
    required ProductModel product,
    required double rating,
  }) async {
    try {
      http.Response res = await productDetailsRepo.rateProduct(
          product: product, rating: rating);

      httpErrorHandle(
        res: res,
        onSuccess: () {},
      );
      update();
    } catch (e) {
      Get.snackbar('', e.toString());
    }
  }

  /////////////////////////

  late CartCtrl _cart = CartCtrl(
    cartRepo: Get.find(),
  );

  final Rx<int> _quantity = 0.obs;
  Rx<int> get quantity => _quantity;

  void setQuantity(bool isIncrement, int productQuantity) {
    if (isIncrement) {
      _quantity.value = checkQuantity(_quantity.value + 1, productQuantity);
    } else {
      _quantity.value = checkQuantity(_quantity.value - 1, productQuantity);
    }
  }

  int checkQuantity(int quantity, int productQuantity) {
    if (quantity < 0) {
      Get.snackbar(
        'Item count',
        "You can't reduce more !",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      return 0;
    } else if (quantity > productQuantity) {
      Get.snackbar(
        'Item count',
        "You ordered more than the available quantity !",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      return productQuantity;
    } else {
      return quantity;
    }
  }

  void addItem(ProductModel product) {
    _cart.addItem(product.id, product, quantity.value);
    _quantity.value = _cart.getQuantity(product);
    update();
  }

  initProduct(ProductModel product, CartCtrl cart) {
    _cart = cart;
    _quantity.value = _cart.getQuantity(product);
    update();
  }

  int get totalItems {
    return _cart.totalItems;
  }
}
