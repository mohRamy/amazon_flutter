import 'package:amazon_flutter/config/routes/app_pages.dart';
import 'package:dotted_border/dotted_border.dart';

import '../../../core/utils/components/components.dart';
import '../../../core/widgets/app_text_button.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/custom_button.dart';
import '../admin_ctrl/admin_ctrl.dart';
import '../../product_details/product_details_ctrl/product_details_ctrl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/widgets/app_icon.dart';
import '../../../core/widgets/big_text.dart';
import '../../../controller/user_controller.dart';
import '../../../models/product_model.dart';

class AdminDetailsScreen extends GetView<AdminCtrl> {
  const AdminDetailsScreen({super.key});

  void deleteProduct(ProductModel product, int index) {
    controller.deleteProduct(
      product: product,
      onSuccess: () {
        controller.products.removeAt(index);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ProductDetailsCtrl productDetailsCtrl =
        ProductDetailsCtrl(productDetailsRepo: Get.find());
    ProductModel product = Get.arguments[AppString.ARGUMENT_PRODUCT];
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

    controller.productNameUC.text = product.name;
    controller.descreptionUC.text = product.description;
    controller.priceUC.text = product.price.toString();
    controller.quantityUC.text = product.quantity.toString();

    return Scaffold(
      backgroundColor: Colors.grey[100],
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
              backgroundColor: AppColors.yellowColor,
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  productDetailsCtrl.avgRating.value != 0
                      ? Obx(() {
                          return Padding(
                            padding: EdgeInsets.all(Dimensions.height10),
                            child: Container(
                              padding: EdgeInsets.all(
                                Dimensions.width10,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.yellowColor,
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius15),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 1,
                                    offset: const Offset(0, 2),
                                    color: Colors.grey.withOpacity(0.2),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.black,
                                    size: 20,
                                  ),
                                  Text(
                                    productDetailsCtrl.avgRating.value
                                        .toString(),
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        })
                      : Container(),
                  Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.only(
                      top: 5,
                      bottom: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
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
                        text: 'Update Product',
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
            child: Padding(
              padding: EdgeInsets.only(
                left: Dimensions.width20,
                right: Dimensions.width20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Dimensions.height20),
                  BigText(
                    text: 'Product Name',
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  AppTextField(
                    textController: controller.productNameUC,
                    hintText: 'Product Name',
                    icon: Icons.person,
                  ),
                  SizedBox(height: Dimensions.height20),
                  BigText(
                    text: 'Product Descreption',
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  AppTextField(
                    textController: controller.descreptionUC,
                    hintText: 'Product Descreption',
                    icon: Icons.description,
                    maxLines: 3,
                  ),
                  SizedBox(height: Dimensions.height20),
                  BigText(
                    text: 'Product Price',
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  AppTextField(
                    textController: controller.priceUC,
                    hintText: 'Product Price',
                    icon: Icons.price_change,
                  ),
                  SizedBox(height: Dimensions.height20),
                  BigText(
                    text: 'Product Quantity',
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  AppTextField(
                    textController: controller.quantityUC,
                    hintText: 'Product Quantity',
                    icon: Icons.production_quantity_limits,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      //bottom
      bottomNavigationBar: GetBuilder<AdminCtrl>(builder: (adminCtrl) {
        return Column(
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
                          // deleteProduct(
                          //   product,
                          //   index,
                          // );
                          // Get.back();
                          adminCtrl.deleteProduct(
                            product: product,
                            onSuccess: () {
                              controller.products.removeAt(index);
                              Get.toNamed(Routes.NAV_ADMIN_SCREEN);
                            },
                          );
                        },
                        okColor: Colors.red,
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                        top: Dimensions.height20,
                        bottom: Dimensions.height20,
                        left: Dimensions.width10 * 4,
                        right: Dimensions.width10 * 4,
                      ),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius20),
                        color: Colors.white,
                      ),
                      child: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  // CustomButton(
                  //   onPressed: () {
                  //     adminCtrl.updateProduct(
                  //       id: product.id!,
                  //       name: controller.productNameUC.text,
                  //       description: controller.descreptionUC.text,
                  //       price: int.parse(controller.priceUC.text),
                  //       quantity: int.parse(controller.quantityUC.text),
                  //     );
                  //   },
                  //   width: 150,
                  //   height: 80,
                  //   radius: Dimensions.radius20,
                  //   fontSize: Dimensions.font20,
                  //   buttomText: 'Save',
                  // ),
                  AppTextButton(
                    txt: AppString.SIGN_UP,
                    onTap: () {
                      adminCtrl.updateProduct(
                        id: product.id!,
                        name: controller.productNameUC.text,
                        description: controller.descreptionUC.text,
                        price: int.parse(controller.priceUC.text),
                        quantity: int.parse(controller.quantityUC.text),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
