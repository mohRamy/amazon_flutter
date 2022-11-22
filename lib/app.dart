import 'package:amazon_flutter/core/utils/app_colors.dart';
import 'package:amazon_flutter/features/admin/admin_ctrl/admin_ctrl.dart';
import 'package:amazon_flutter/features/cart/cart_repo/cart_repo.dart';
import 'package:amazon_flutter/features/final_order/final_order_ctrl/final_order_ctrl.dart';
import 'package:amazon_flutter/features/checkout/checkout_screen/checkout_screen.dart';

import 'controller/user_controller.dart';
import 'features/auth/auth_repo/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/utils/app_strings.dart';
import 'features/auth/auth_ctrl/auth_ctrl.dart';

import '../../../config/routes/app_pages.dart';

class ShoppingApp extends StatelessWidget {
  ShoppingApp({
    Key? key,
  }) : super(key: key);

  AuthCtrl authCtrl = Get.find<AuthCtrl>();
  AuthRepo authRepo = Get.find<AuthRepo>();
  UserCtrl userctrl = Get.find<UserCtrl>();


  String initRoute() {
      if (authRepo.getUserType() == "admin") {
        return Routes.NAV_ADMIN_SCREEN;
      } else {
        return Routes.NAV_HOME_SCREEN;
      }
  }

  @override
  Widget build(BuildContext context) {
    if (Get.find<AuthRepo>().userLoggedIn()) {
      Get.find<AuthCtrl>().getUserData();
    }
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppString.APP_NAME,
      theme: ThemeData(
        primaryColor: AppColors.mainColor,
        appBarTheme: AppBarTheme(
          elevation: 0,
          backgroundColor: AppColors.mainColor,
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
        ),
        useMaterial3: true, 
      ),
      initialRoute: initRoute(),
      getPages: AppPages.routes,
    );
  }
}
