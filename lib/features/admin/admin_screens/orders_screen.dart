import '../../../core/widgets/custom_loader.dart';
import '../admin_ctrl/admin_ctrl.dart';
import '../../../models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/routes/app_pages.dart';
import '../../account/widgets/single_product.dart';

class user extends GetView<AdminCtrl> {
  user({Key? key}) : super(key: key);

  List<OrderModel>? orders;

  void fetchOrders() async {
    orders = await controller.fetchAllOrders();
  }

  @override
  Widget build(BuildContext context) {
    fetchOrders();
    return orders == null
        ? const CustomLoader()
        : GridView.builder(
            itemCount: orders!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: (context, index) {
              final orderData = orders![index];
              return GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.ORDER_DETAIL, arguments: orderData);
                },
                child: SizedBox(
                  height: 140,
                  child: SingleProduct(
                    image: orderData.products[0].images[0],
                  ),
                ),
              );
            },
          );
  }
}
