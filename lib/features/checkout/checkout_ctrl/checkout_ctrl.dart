import 'package:amazon_flutter/config/routes/app_pages.dart';
import 'package:amazon_flutter/core/utils/app_colors.dart';
import 'package:amazon_flutter/core/utils/components/components.dart';
import 'package:amazon_flutter/features/cart/cart_repo/cart_repo.dart';
import 'package:get/get.dart';

import 'package:amazon_flutter/features/checkout/checkout_repo/checkout_repo.dart';
import 'package:http/http.dart' as http;

import '../../../core/utils/constants/error_handling.dart';

class CheckoutCtrl extends GetxController implements GetxService {
  final CheckoutRepo orderRepo;
  CheckoutCtrl({
    required this.orderRepo,
  });

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void checkout({
    required List<String> productsId,
    required List<int> userQuants,
    required int totalPrice,
    required String address,
  }) async {
    try {
      _isLoading = true;
      update();
      http.Response res = await orderRepo.checkout(
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
            title: 'Order',
            color: AppColors.mainColor,
          );
          Get.toNamed(Routes.NAV_HOME_SCREEN);
        },
      );
      _isLoading = false;
      update();
    } catch (e) {
      Components.showCustomSnackBar(e.toString());
    }
  }
}
