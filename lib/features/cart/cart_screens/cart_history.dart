import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/widgets/app_icon.dart';
import '../../../core/widgets/big_text.dart';
import '../../../core/widgets/no_data_page.dart';
import '../../../core/widgets/small_text.dart';
import '../../../models/cart_model.dart';
import '../../../config/routes/app_pages.dart';
import '../cart_ctrl/cart_ctrl.dart';

class CartHistory extends GetView<CartCtrl> {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartCtrl cartCtrl = Get.find<CartCtrl>();
    
    List<CartModel> cartHistoryList =
        cartCtrl.getCartHistoryList().reversed.toList();

    Map<String, int> cartItems = {};

    for (var i = 0; i < cartHistoryList.length; i++) {
      if (cartItems.containsKey(cartHistoryList[i].time)) {
        cartItems.update(cartHistoryList[i].time!, (value) => ++value);
      } else {
        cartItems.putIfAbsent(cartHistoryList[i].time!, () => 1);
      }
    }

    List<int> cartItemsVal() {
      return cartItems.entries.map((e) => e.value).toList();
    }

    List<String> cartItemsKey() {
      return cartItems.entries.map((e) => e.key).toList();
    }

    List<int> itemsVal = cartItemsVal();

    int listCounter = 0;

    Widget timeWidget(int index) {
      String outputDate = DateTime.now().toString();
      if (index < cartHistoryList.length) {
        DateTime parseDate = DateFormat("yyy-MM-dd HH:mm:ss")
            .parse(cartHistoryList[listCounter].time!);
        DateTime inputDate = DateTime.parse(parseDate.toString());
        DateFormat outputFormat = DateFormat("MM/dd/yyyy hh:mm a");
        outputDate = outputFormat.format(inputDate);
      }
      return BigText(text: outputDate);
    }

    return Scaffold(
      body: Column(
        children: [
          //header
          Container(
            color: AppColors.mainColor,
            width: double.maxFinite,
            height: Dimensions.height10 * 10,
            padding: EdgeInsets.only(top: Dimensions.height45),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BigText(
                  text: 'Cart History',
                  color: Colors.white,
                ),
                AppIcon(
                  onTap: () => Get.toNamed(Routes.CART),
                  icon: Icons.shopping_cart_outlined,
                  iconColor: AppColors.mainColor,
                  backgroundColor: AppColors.yellowColor,
                ),
              ],
            ),
          ),
          //body
          // GetBuilder<CartCtrl>(
          //   builder: (controller) =>
          controller.getCartHistoryList().isNotEmpty
              ? Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                      top: Dimensions.height20,
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                    ),
                    child: MediaQuery.removePadding(
                      removeTop: true,
                      context: context,
                      child: ListView(
                        physics: const BouncingScrollPhysics(),
                        children: [
                          for (int i = 0; i < itemsVal.length; i++)
                            Container(
                              height: Dimensions.height30 * 4,
                              margin:
                                  EdgeInsets.only(bottom: Dimensions.height20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  timeWidget(listCounter),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Wrap(
                                        direction: Axis.horizontal,
                                        children:
                                            List.generate(itemsVal[i], (index) {
                                          if (listCounter <
                                              cartHistoryList.length) {
                                            listCounter++;
                                          }
                                          return index <= 2
                                              ? Container(
                                                  height:
                                                      Dimensions.height20 * 4,
                                                  width:
                                                      Dimensions.height20 * 4,
                                                  margin: EdgeInsets.only(
                                                      right:
                                                          Dimensions.width10 /
                                                              2),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            Dimensions
                                                                    .radius15 /
                                                                2),
                                                    image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                        cartHistoryList[
                                                                listCounter - 1]
                                                            .image!,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : Container();
                                        }),
                                      ),
                                      SizedBox(
                                        height: Dimensions.height20 * 4,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            SmallText(
                                              text: 'Total',
                                              color: AppColors.titleColor,
                                            ),
                                            BigText(
                                              text: '${itemsVal[i]} Items',
                                              color: AppColors.titleColor,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                List<String> orderTime =
                                                    cartItemsKey();
                                                Map<String, CartModel>
                                                    moreOrder = {};
                                                for (int j = 0;
                                                    j < cartHistoryList.length;
                                                    j++) {
                                                  if (cartHistoryList[j].time ==
                                                      orderTime[i]) {
                                                    moreOrder.putIfAbsent(
                                                      cartHistoryList[j].id!,
                                                      () => CartModel.fromJson(
                                                          jsonDecode(jsonEncode(
                                                        cartHistoryList[j],
                                                      ))),
                                                    );
                                                  }
                                                }
                                                cartCtrl.setItems = moreOrder;
                                                cartCtrl.addToCartList();
                                                Get.toNamed(Routes.CART);
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      Dimensions.width10,
                                                  vertical:
                                                      Dimensions.height10 / 2,
                                                ),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          Dimensions.radius15 /
                                                              3),
                                                  border: Border.all(
                                                    width: 1,
                                                    color: AppColors.mainColor,
                                                  ),
                                                ),
                                                child: SmallText(
                                                  text: 'one more',
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
                            ),
                        ],
                      ),
                    ),
                  ),
                )
              : SizedBox(
                  height: MediaQuery.of(context).size.height / 1.5,
                  child: const NoDataPage(
                    text: 'Your cart history is empty',
                    imgPath: AppString.ASSETS_EMPTY,
                  ),
                ),
          // ),
        ],
      ),
    );
  }
}
