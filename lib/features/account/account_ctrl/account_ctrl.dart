import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


import '../../../config/routes/app_pages.dart';
import '../account_repo/account_repo.dart';

import '../../../core/utils/constants/error_handling.dart';
import '../../../models/order_model.dart';

class AccountCtlr extends GetxController implements GetxService {
  final AccountRepo accountRepo;
  AccountCtlr({
    required this.accountRepo,
  });

  List<OrderModel>? orders;

  @override
  void onInit() {
    fetchMyOrder();
    super.onInit();
  }

  void fetchMyOrder() async {
    orders = await fetchMyOrders();
    update();
  }

  Future<List<OrderModel>> fetchMyOrders() async {
    List<OrderModel> orderList = [];

    http.Response res = await accountRepo.fetchMyOrders();
    httpErrorHandle(
      res: res,
      onSuccess: () {
        for (var i = 0; i < jsonDecode(res.body).length; i++) {
          orderList.add(
            OrderModel.fromJson(
              jsonEncode(
                jsonDecode(res.body)[i],
              ),
            ),
          );
        }
      },
    );
    update();
    return orderList;
  }

  void logOut() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setString('x-auth-token', '');
      Get.offNamedUntil(Routes.SIGN_IN, (route) => false);
    } catch (e) {
      Get.snackbar('', e.toString());
    }
  }
}
