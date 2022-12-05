import 'package:amazon_flutter/features/order/order_ctrl/order_ctrl.dart';
import 'package:amazon_flutter/features/order/order_repo/order_repo.dart';
import 'package:amazon_flutter/features/checkout/checkout_ctrl/checkout_ctrl.dart';
import 'package:amazon_flutter/features/checkout/checkout_repo/checkout_repo.dart';
import 'package:amazon_flutter/features/profile/profile_ctrl/profile_ctrl.dart';

import '../features/update_profile/update_profile_ctrl/update_profile_ctrl.dart';
import '../features/update_profile/update_profile_repo/update_profile_repo.dart';
import '../features/admin/admin_ctrl/admin_ctrl.dart';
import '../features/admin/admin_repo/admin_repo.dart';
import '../features/auth/auth_ctrl/auth_ctrl.dart';
import '../features/auth/auth_repo/auth_repo.dart';
import '../features/cart/cart_repo/cart_repo.dart';
import '../features/home/home_ctrl/home_ctrl.dart';
import '../features/nav/nav_ctrl/nav_user_ctrl.dart';
import '../features/home/home_repo/home_repo.dart';
import '../features/product_details/product_details_ctrl/product_details_ctrl.dart';
import '../features/product_details/product_details_repo/product_details_repo.dart';
import '../features/search/search_ctrl/search_ctrl.dart';
import '../features/search/search_repo/search_repo.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/api/api_client.dart';
import '../controller/user_controller.dart';
import '../features/nav/nav_ctrl/nav_admin_ctrl.dart';
import '../features/cart/cart_ctrl/cart_ctrl.dart';


Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  //sharedPreferences
  Get.lazyPut(() => sharedPreferences);

  //api client
  Get.lazyPut(() => ApiClient(sharedPreferences: Get.find()));
  
  //repos
  Get.lazyPut(() => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => UpdateProfileRepo(apiClient: Get.find(),sharedPreferences: Get.find()));
  Get.lazyPut(() => AdminRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => HomeRepo(apiClient: Get.find()));
  Get.lazyPut(() => ProductDetailsRepo(apiClient: Get.find()));
  Get.lazyPut(() => SearchRepo(apiClient: Get.find()));
  Get.lazyPut(() => CheckoutRepo(apiClient: Get.find()));
  Get.lazyPut(() => OrderRepo(apiClient: Get.find()));

  //controllers
  Get.lazyPut(() => UserCtrl());
  Get.lazyPut(() => AuthCtrl(apiClient: Get.find(), authRepo: Get.find(), sharedPreferences: sharedPreferences));
  Get.lazyPut(() => NavUserCtrl());
  Get.lazyPut(() => NavAdminCtrl());
  Get.lazyPut(() => UpdateProfileCtrl(addressRepo: Get.find()));
  Get.lazyPut(() => AdminCtrl(adminRepo: Get.find()));
  Get.lazyPut(() => CartCtrl(cartRepo: Get.find()));
  Get.lazyPut(() => HomeCtrl(homeRepo: Get.find()));
  Get.lazyPut(() => ProductDetailsCtrl(productDetailsRepo: Get.find()));
  Get.lazyPut(() => SearchCtrl(searchRepo: Get.find()));
  Get.lazyPut(() => CheckoutCtrl(orderRepo: Get.find()));
  Get.lazyPut(() => OrderCtrl(finalOrderRepo: Get.find()));
  Get.lazyPut(() => ProfileCtrl(sharedPreferences: Get.find()));
}
