import 'package:amazon_flutter/core/utils/dimensions.dart';
import 'package:amazon_flutter/core/widgets/app_icon.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/widgets/big_text.dart';
import '../search_ctrl/search_ctrl.dart';
import 'package:get/get.dart';

import '../../../config/routes/app_pages.dart';
import 'package:flutter/material.dart';

import '../search_widget/searched_product.dart';

class SearchScreen extends GetView<SearchCtrl> {
  const SearchScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.products = [];
    return Scaffold(
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
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(onTap: () => Get.back(), icon: Icons.arrow_back_ios, ),
                SizedBox(width: Dimensions.width15),
                GetBuilder<SearchCtrl>(builder: (searchCtrl) {
                  return Container(
                    width: 330,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(Dimensions.radius15),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 3,
                          spreadRadius: 1,
                          offset: const Offset(1, 1),
                          color: Colors.grey.withOpacity(0.2),
                        ),
                      ],
                    ),
                    child: TextField(
                      onChanged: (val) {
                        searchCtrl.changeSearchStatus(val);
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(Dimensions.height10),
                        hintText: "Search Products ...",
                        prefixIcon: Icon(
                          Icons.search,
                          color: AppColors.yellowColor,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius15),
                          borderSide: const BorderSide(
                            width: 1.0,
                            color: Colors.white,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius15),
                          borderSide: const BorderSide(
                            width: 1.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
          GetBuilder<SearchCtrl>(
            builder: (controller) => controller.products.isEmpty
                ? Container()
                : MediaQuery.removePadding(
                    removeTop: true,
                    context: context,
                    child: Expanded(
                      child: ListView(
                        children: [
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller.products.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Get.toNamed(Routes.RATING_PRODUCT,
                                      arguments: {
                                        AppString.ARGUMENT_PRODUCT:
                                            controller.products[index],
                                        AppString.ARGUMENT_RATINGS:
                                            controller.products[index].rating,
                                      });
                                },
                                child: SearchedProduct(
                                  product: controller.products[index],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
