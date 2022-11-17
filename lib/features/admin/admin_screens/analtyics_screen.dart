import '../admin_ctrl/admin_ctrl.dart';
import '../admin_models/sales.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/routes/app_pages.dart';
import '../../auth/auth_ctrl/auth_ctrl.dart';

class AnalyticsScreen extends GetView<AdminCtrl> {
  AnalyticsScreen({Key? key}) : super(key: key);

  int? totalSales;
  List<Sales>? earnings;

  getEarnings() async {
    var earningData = await controller.getEarnings();
    totalSales = earningData['totalEarnings'];
    earnings = earningData['sales'];
  }

  @override
  Widget build(BuildContext context) {
    getEarnings();
    return 
    // earnings == null || totalSales == null
    //     ? const CustomLoader()
        Column(
            children: [
              ElevatedButton(
            onPressed: () {
              Get.find<AuthCtrl>().clearSharedData();
              Get.offNamed(Routes.SIGN_IN);
            },
            child: const Text('signOut')),
              Text(
                '\$$totalSales',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // SizedBox(
              //   height: 250,
              //   child: CategoryProductsChart(seriesList: [
              //     charts.Series(
              //       id: 'Sales',
              //       data: earnings!,
              //       domainFn: (Sales sales, _) => sales.label,
              //       measureFn: (Sales sales, _) => sales.earning,
              //     ),
              //   ]),
              // )
            ],
          );
  }
}
