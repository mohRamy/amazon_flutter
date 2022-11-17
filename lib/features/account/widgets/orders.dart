import 'dart:html';

import 'package:amazon_flutter/core/utils/app_colors.dart';
import 'package:amazon_flutter/core/utils/dimensions.dart';
import 'package:amazon_flutter/core/widgets/custom_loader.dart';

import '../account_ctrl/account_ctrl.dart';
import 'single_product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/routes/app_pages.dart';

class Orders extends GetView<AccountCtlr> {
  const Orders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountCtlr>(
      builder: (controller) => controller.orders == null
          ? const CustomLoader()
          : Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        left: Dimensions.width15,
                      ),
                      child: Text(
                        'Your Orders',
                        style: TextStyle(
                          fontSize: Dimensions.font20 - 2,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        right: Dimensions.width15,
                      ),
                      child: Text(
                        'See all',
                        style: TextStyle(
                          color: AppColors.blackColor,
                        ),
                      ),
                    ),
                  ],
                ),
                // display orders
                Container(
                  height: 170,
                  padding: EdgeInsets.only(
                    left: Dimensions.width10,
                    top: Dimensions.height20,
                    right: 0,
                  ),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.orders!.length,
                    itemBuilder: (context, index) {
                      var listData = controller.orders![index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            Routes.ORDER_DETAIL,
                            arguments: listData,
                          );
                        },
                        child: const SingleProduct(
                          image:
                              'https://images-eu.ssl-images-amazon.com/images/G/31/img2021/Vday/bwl/English.jpg',
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
