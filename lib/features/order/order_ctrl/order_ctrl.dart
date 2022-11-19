import 'package:amazon_flutter/config/routes/app_pages.dart';
import 'package:amazon_flutter/core/utils/app_colors.dart';
import 'package:amazon_flutter/core/utils/components/components.dart';
import 'package:amazon_flutter/features/cart/cart_repo/cart_repo.dart';
import 'package:get/get.dart';

import 'package:amazon_flutter/features/order/order_repo/order_repo.dart';
import 'package:http/http.dart' as http;

import '../../../core/utils/constants/error_handling.dart';
import '../../../models/product_model.dart';

class OrderCtrl extends GetxController implements GetxService {
  final OrderRepo orderRepo;
  OrderCtrl({
    required this.orderRepo,
  });

  void placeOrder({
    required List<String> productsId,
    required List<int> userQuants,
    required int totalPrice,
    required String address,
  }) async {
    try {
      print(productsId[0]);
      http.Response res = await orderRepo.placeOrder(
        productsId: productsId,
        userQuants: userQuants,
        totalPrice: totalPrice,
        address: address,
      );
      

      httpErrorHandle(
        res: res,
        onSuccess: () {
          Get.find<CartRepo>().removeCart();
          Components.showCustomSnackBar(
            'add Order Successed',
            color: AppColors.mainColor,
          );
          Get.toNamed(Routes.NAV_HOME_SCREEN);
        },
      );
    } catch (e) {
      Components.showCustomSnackBar(e.toString());
    }
  }
}
