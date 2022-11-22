import 'package:amazon_flutter/config/routes/app_pages.dart';
import 'package:amazon_flutter/core/widgets/custom_loader.dart';
import 'package:amazon_flutter/core/widgets/small_text.dart';
import 'package:amazon_flutter/features/final_order/final_order_ctrl/final_order_ctrl.dart';
import 'package:amazon_flutter/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/widgets/big_text.dart';
import '../../../core/widgets/no_data_page.dart';

class FinalOrderScreen extends GetView<FinalOrderCtrl> {
  const FinalOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FinalOrderCtrl>(builder: (ctrl) {
      return Column(
        children: [
          Container(
            color: AppColors.mainColor,
            width: double.maxFinite,
            height: Dimensions.height10 * 10,
            padding: EdgeInsets.only(top: Dimensions.height45),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BigText(
                  text: 'Your Order',
                  color: Colors.white,
                ),
              ],
            ),
          ),
          controller.myOrder.isNotEmpty
              ? 
              !controller.isLoading ? 
              MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: Expanded(
                  child: ListView(
                    children: [
                      Container(
                          margin: EdgeInsets.only(
                            top: Dimensions.height10,
                            left: Dimensions.width20,
                            right: Dimensions.width20,
                          ),
                          child:  ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: controller.myOrder.length,
                              itemBuilder: (context, index) {
                                OrderModel myOrder = controller.myOrder[index];
                                return Container(
                                  height: Dimensions.height30 * 4,
                                  margin: EdgeInsets.only(bottom: Dimensions.height20),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      BigText(
                                        text: DateFormat("MM/dd/yyyy hh:mm a").format(
                                          DateTime.fromMillisecondsSinceEpoch(
                                              myOrder.orderedAt),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Wrap(
                                            direction: Axis.horizontal,
                                            children: List.generate(
                                              myOrder.products.length,
                                              (indes) => indes < 3
                                                  ? Container(
                                                      height: Dimensions.height20 * 4,
                                                      width: Dimensions.height20 * 4,
                                                      margin: EdgeInsets.only(
                                                          right:
                                                              Dimensions.width10 / 2),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                Dimensions.radius15 /
                                                                    2),
                                                        image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: NetworkImage(
                                                            myOrder.products[indes]
                                                                .images[0],
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  : Container(),
                                            ),
                                          ),
                                          SizedBox(
                                            height: Dimensions.height20 * 4,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    BigText(
                                                      text: 'total:',
                                                      size: 16,
                                                      color: AppColors.titleColor,
                                                    ),
                                                    SizedBox(width: Dimensions.width10),
                                                    BigText(
                                                      text:
                                                          myOrder.totalPrice.toString(),
                                                      size: 16,
                                                      color: AppColors.titleColor,
                                                    ),
                                                  ],
                                                ),
                                                GestureDetector(
                                                  onTap: () => Get.toNamed(
                                                    Routes.ORDER_DETAIL,
                                                    arguments: myOrder,
                                                  ),
                                                  child: Container(
                                                    padding: EdgeInsets.symmetric(
                                                      horizontal: Dimensions.width10,
                                                      vertical: Dimensions.height10 / 2,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              Dimensions.radius15 / 3),
                                                      border: Border.all(
                                                        width: 1,
                                                        color: AppColors.mainColor,
                                                      ),
                                                    ),
                                                    child: SmallText(
                                                      text: 'Details',
                                                      color: AppColors.mainColor,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        
                    ],
                  ),
                ),
              )
              : const Expanded(
                  child: NoDataPage(
                    text: 'Your cart history is empty',
                    imgPath: AppString.ASSETS_EMPTY,
                  ),
                ): const Expanded(child: CustomLoader()),
          // ),
        ],
      );
    });
  }
}
