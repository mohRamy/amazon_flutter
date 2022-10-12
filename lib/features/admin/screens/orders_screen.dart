import 'package:amazon_flutter/common/widgets/loader.dart';
import 'package:amazon_flutter/features/account/widgets/single_product.dart';
import 'package:amazon_flutter/features/admin/services/admin_services.dart';
import 'package:flutter/material.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  // List<Order>? orders;
  // final AdminServices adminServices = AdminServices();

  // @override
  // void initState() {
  //   super.initState();
  //   fetchOrders();
  // }

  // void fetchOrders() async {
  //   orders = await adminServices.fetchAllOrders(context);
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return 
        GridView.builder(
            itemCount: 4,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: (context, index) {
              // final orderData = orders![index];
              return GestureDetector(
                onTap: () {
                  // Navigator.pushNamed(
                  //   context,
                  //   OrderDetailScreen.routeName,
                  //   arguments: orderData,
                  // );
                },
                child: Container(),
                // child: SizedBox(
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
