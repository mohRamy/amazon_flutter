import 'package:amazon_flutter/controller/user_ctrl.dart';
import 'package:amazon_flutter/core/widgets/app_icon.dart';
import 'package:amazon_flutter/core/widgets/big_text.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/dimensions.dart';

import '../../../core/widgets/custom_button.dart';
import '../../../models/order_model.dart';
import '../../admin/admin_ctrl/admin_ctrl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../config/routes/app_pages.dart';

class OrderDetailScreen extends GetView<AdminCtrl> {
  const OrderDetailScreen({
    Key? key,
  }) : super(key: key);

  void navigateToSearchScreen(String query) {
    Get.toNamed(Routes.SEARCH, arguments: query);
  }

  @override
  Widget build(BuildContext context) {
    UserCtrl userCtrl = Get.find<UserCtrl>();
    OrderModel myOrder = Get.arguments;
    controller.currentStep = myOrder.status;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          Container(
            color: AppColors.mainColor,
            width: double.maxFinite,
            height: Dimensions.height10 * 10,
            padding: EdgeInsets.only(
              top: Dimensions.height45,
              left: Dimensions.width20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(
                  onTap: () => Get.back(),
                  icon: Icons.arrow_back_ios,
                  backgroundColor: AppColors.yellowColor,
                ),
                BigText(
                  text: 'Order Details',
                  color: Colors.white,
                ),
                Container(
                  width: Dimensions.height45,
                ),
              ],
            ),
          ),
          MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: Expanded(
              child: ListView(
                children: [
                  SingleChildScrollView(
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Order Date:'),
                                    Text(
                                        DateFormat("MM/dd/yyyy hh:mm a").format(
                                      DateTime.fromMillisecondsSinceEpoch(
                                          myOrder.orderedAt),
                                    )),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Order Id:'),
                                    Text(myOrder.id),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                for (int i = 0;
                                    i < myOrder.products.length;
                                    i++)
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            height: Dimensions.height20 * 4,
                                            width: Dimensions.height20 * 4,
                                            margin: EdgeInsets.only(
                                                right: Dimensions.width10 / 2),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
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
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  myOrder.products[i].name,
                                                  style: TextStyle(
                                                    fontSize:
                                                        Dimensions.iconSize16 +
                                                            2,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                Text(
                                                  'Qty: ${myOrder.quantity[i]}',
                                                  style: TextStyle(
                                                      fontSize: Dimensions
                                                              .iconSize16 +
                                                          2),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: Dimensions.height10),
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
                            child: GetBuilder<AdminCtrl>(builder: (adminCtrl) {
                              return Stepper(
                                currentStep: adminCtrl.currentStep,
                                controlsBuilder: (context, details) {
                                  if (userCtrl.user.type == 'admin') {
                                    return adminCtrl.currentStep < 3
                                        ? CustomButton(
                                            buttomText: 'Done',
                                            onPressed: () {
                                              controller.changeOrderStatus(
                                                status: details.currentStep + 1,
                                                order: Get.arguments,
                                              );
                                            },
                                          )
                                        : CustomButton(
                                            buttomText: 'Delete',
                                            onPressed: () {
                                              controller.deleteOrder(
                                                  order: myOrder);
                                            },
                                          );
                                  }
                                  return const SizedBox();
                                },
                                steps: [
                                  Step(
                                    title: const Text('Pending'),
                                    content: Text(
                                      userCtrl.user.type == 'admin'?
                                      'Order is yet to be delivered'
                                      :'Your order is yet to be delivered',
                                    ),
                                    isActive: adminCtrl.currentStep > 0,
                                    state: adminCtrl.currentStep > 0
                                        ? StepState.complete
                                        : StepState.indexed,
                                  ),
                                  Step(
                                    title: const Text('Completed'),
                                    content: Text(
                                      userCtrl.user.type == 'admin'
                                          ? 'Order has been delivered, Custom are yet to sign.'
                                          : 'Your order has been delivered, you are yet to sign.',
                                    ),
                                    isActive: adminCtrl.currentStep > 1,
                                    state: adminCtrl.currentStep > 1
                                        ? StepState.complete
                                        : StepState.indexed,
                                  ),
                                  Step(
                                    title: const Text('Received'),
                                    content: Text(
                                      userCtrl.user.type == 'admin'
                                          ? 'Order has been delivered and signed by customer.'
                                          : 'Your order has been delivered and signed by you.',
                                    ),
                                    isActive: adminCtrl.currentStep > 2,
                                    state: adminCtrl.currentStep > 2
                                        ? StepState.complete
                                        : StepState.indexed,
                                  ),
                                  Step(
                                    title: const Text('Delivered'),
                                    content: Text(
                                      userCtrl.user.type == 'admin'
                                          ? 'Order has been delivered and signed by customer!'
                                          : 'Your order has been delivered and signed by you!',
                                    ),
                                    isActive: adminCtrl.currentStep >= 3,
                                    state: adminCtrl.currentStep >= 3
                                        ? StepState.complete
                                        : StepState.indexed,
                                  ),
                                ],
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
