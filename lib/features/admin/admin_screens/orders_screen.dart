import '../../../core/widgets/custom_loader.dart';
import '../admin_ctrl/admin_ctrl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/routes/app_pages.dart';

class AdminOrderScreen extends GetView<AdminCtrl> {
  const AdminOrderScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return controller.orders == null
        ? const CustomLoader()
        : GridView.builder(
            itemCount: controller.orders.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: (context, index) {
              final orderData = controller.orders[index];
              return GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.ORDER_DETAIL, arguments: orderData);
                },
                child: Container(),
                // SizedBox(
                //   height: 140,
                //   child: SingleProduct(
                //     image: orderData.products[0].images[0],
                //   ),
                // ),
              );
            },
          );
  }
}
