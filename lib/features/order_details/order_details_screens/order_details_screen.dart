import 'package:amazon_flutter/core/utils/app_colors.dart';
import 'package:amazon_flutter/core/widgets/big_text.dart';

import '../../../core/utils/dimensions.dart';
import '../../../core/utils/hex_color.dart';
import '../../../core/widgets/app_icon.dart';
import '../../../core/widgets/small_text.dart';
import '../../../models/order_model.dart';
import '../../admin/admin_ctrl/admin_ctrl.dart';
import '../../../controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../config/routes/app_pages.dart';

class OrderDetailScreen extends GetView<AdminCtrl> {
  OrderDetailScreen({
    Key? key,
  }) : super(key: key);

  int currentStep = 0;

  void navigateToSearchScreen(String query) {
    Get.toNamed(Routes.SEARCH, arguments: query);
  }

  void changeOrderStatus(int status) {
    controller.changeOrderStatus(
      status: status + 1,
      order: Get.arguments,
      onSuccess: () {
        currentStep += 1;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    OrderModel myOrder = Get.arguments;
    currentStep = myOrder.status;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: BigText(
          text: 'Order Details',
          color: Colors.white,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'View order details',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: Dimensions.height10),
              Container(
                  padding: EdgeInsets.only(
                    right: Dimensions.width10,
                    left: Dimensions.width20,
                    top: Dimensions.width10,
                    bottom: Dimensions.width10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 1,
                        offset: const Offset(0, 2),
                        color: Colors.grey.withOpacity(0.2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Order Date:'),
                          Text(DateFormat().format(
                            DateTime.fromMillisecondsSinceEpoch(
                                myOrder.orderedAt),
                          )),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Order Id:'),
                          Text(myOrder.id),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Order Total:'),
                          Text(myOrder.totalPrice.toString()),
                        ],
                      ),
                    ],
                  ),
                ),
              
              
              SizedBox(height: Dimensions.height20),
              const Text(
                'Purchase Details',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: Dimensions.height10),
              Container(
                padding: EdgeInsets.only(
                    right: Dimensions.width10,
                    left: Dimensions.width20,
                    top: Dimensions.width10,
                    bottom: Dimensions.width10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 1,
                        offset: const Offset(0, 2),
                        color: Colors.grey.withOpacity(0.2),
                      ),
                    ],
                  ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    for (int i = 0; i < myOrder.products.length; i++)
                      Row(
                        children: [
                          Container(
                                          height: Dimensions.height20 * 4,
                                          width: Dimensions.height20 * 4,
                                          margin: EdgeInsets.only(
                                              right: Dimensions.width10 / 2),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.radius15 / 2),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                myOrder.products[i].images[0],
                                              ),
                                            ),
                                          ),
                                        ),
                          
                          const SizedBox(width: 5),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  myOrder.products[i].name,
                                  style: TextStyle(
                                    fontSize: Dimensions.iconSize16 + 2,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  'Qty: ${myOrder.quantity[i]}',
                                  style: TextStyle(fontSize: Dimensions.iconSize16 + 2),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              SizedBox(height: Dimensions.height20),
              const Text(
                'Tracking',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: Dimensions.height10),
              Container(
                padding: EdgeInsets.only(
                    right: Dimensions.width10,
                    left: Dimensions.width20,
                    top: Dimensions.width10,
                    bottom: Dimensions.width10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 1,
                        offset: const Offset(0, 2),
                        color: Colors.grey.withOpacity(0.2),
                      ),
                    ],
                  ),
                child: Stepper(
                  currentStep: currentStep,
                  controlsBuilder: (context, details) {
                    return const SizedBox();
                    // if (user.type == 'admin') {
                    //   return CustomButton(
                    //     text: 'Done',
                    //     onTap: () => changeOrderStatus(details.currentStep),
                    //   );
                    // }
                    // return const SizedBox();
                  },
                  steps: [
                    Step(
                      title: const Text('Pending'),
                      content: const Text(
                        'Your order is yet to be delivered',
                      ),
                      isActive: currentStep > 0,
                      state: currentStep > 0
                          ? StepState.complete
                          : StepState.indexed,
                    ),
                    Step(
                      title: const Text('Completed'),
                      content: const Text(
                        'Your order has been delivered, you are yet to sign.',
                      ),
                      isActive: currentStep > 1,
                      state: currentStep > 1
                          ? StepState.complete
                          : StepState.indexed,
                    ),
                    Step(
                      title: const Text('Received'),
                      content: const Text(
                        'Your order has been delivered and signed by you.',
                      ),
                      isActive: currentStep > 2,
                      state: currentStep > 2
                          ? StepState.complete
                          : StepState.indexed,
                    ),
                    Step(
                      title: const Text('Delivered'),
                      content: const Text(
                        'Your order has been delivered and signed by you!',
                      ),
                      isActive: currentStep >= 3,
                      state: currentStep >= 3
                          ? StepState.complete
                          : StepState.indexed,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
