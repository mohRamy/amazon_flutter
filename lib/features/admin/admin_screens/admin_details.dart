import '../../../core/utils/components/components.dart';
import '../admin_ctrl/admin_ctrl.dart';
import '../../product_details/product_details_ctrl/product_details_ctrl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/widgets/app_icon.dart';
import '../../../core/widgets/big_text.dart';
import '../../../core/widgets/expandable_text_widget.dart';
import '../../../controller/user_controller.dart';
import '../../../models/product_model.dart';

class AdminDetailsScreen extends GetView<AdminCtrl> {
  const AdminDetailsScreen({super.key});

  void deleteProduct(ProductModel product, int index) {
    controller.deleteProduct(
      product: product,
      onSuccess: () {
        controller.products!.removeAt(index);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ProductDetailsCtrl productDetailsCtrl =
        ProductDetailsCtrl(productDetailsRepo: Get.find());
    var product = Get.arguments[AppString.ARGUMENT_PRODUCT];
    var ratings = Get.arguments[AppString.ARGUMENT_RATINGS];
    var index = Get.arguments["index"];
    // controller.initProduct(product, Get.find<CartCtrl>());
    double totalRating = 0;
    for (int i = 0; i < ratings.length; i++) {
      totalRating += ratings[i].rating;
      if (ratings[i].userId == Get.find<UserCtrl>().user.id) {
        productDetailsCtrl.myRating.value = ratings[i].rating;
      }
    }

    if (totalRating != 0) {
      productDetailsCtrl.avgRating.value = totalRating / ratings.length;
    }
    return Scaffold(
      backgroundColor: Colors.white,
      //body
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 70,
            title: AppIcon(
              onTap: () => Get.back(),
              icon: Icons.clear,
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(20),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(Dimensions.height10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.star,
                          color: AppColors.starColor,
                          size: 20,
                        ),
                        Text(
                          productDetailsCtrl.avgRating.value.toString(),
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.only(
                      top: 5,
                      bottom: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Dimensions.radius20),
                        topRight: Radius.circular(Dimensions.radius20),
                      ),
                    ),
                    child: Center(
                        child: Padding(
                      padding: EdgeInsets.only(
                          left: Dimensions.width20, right: Dimensions.width20),
                      child: BigText(
                        size: Dimensions.font26,
                        text: product.name!,
                        overflow: TextOverflow.clip,
                      ),
                    )),
                  ),
                ],
              ),
            ),
            pinned: true, // expanded حتى يبقى الابار ظاهر حتى بعد ال
            backgroundColor: AppColors.yellowColor,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                product.images[0],
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      left: Dimensions.width20, right: Dimensions.width20),
                  child: ExpandableTextWidget(
                    text: product.description!,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      //bottom
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: Dimensions.bottomHeightBar,
            padding: EdgeInsets.only(
              top: Dimensions.height30,
              bottom: Dimensions.height30,
              right: Dimensions.width20,
              left: Dimensions.width20,
            ),
            decoration: BoxDecoration(
              color: AppColors.buttonBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radius20 * 2),
                topRight: Radius.circular(Dimensions.radius20 * 2),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Components.showCustomDialog(
                      context: context,
                      msg: 'Are you sure to delete the product ?',
                      ok: () {
                        deleteProduct(
                          product,
                          index,
                        );
                        Get.back();
                      },
                      okColor: Colors.red,
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                      top: Dimensions.height20,
                      bottom: Dimensions.height20,
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: Colors.white,
                    ),
                    child: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    productDetailsCtrl.addItem(product);
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                      top: Dimensions.height20 - 4,
                      bottom: Dimensions.height20,
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: AppColors.mainColor,
                    ),
                    child: BigText(
                      text: 'Update',
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
