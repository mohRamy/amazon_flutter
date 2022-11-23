import 'package:amazon_flutter/controller/user_controller.dart';

import '../../../core/widgets/custom_button.dart';
import '../../auth/auth_ctrl/auth_ctrl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/utils/components/components.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/widgets/app_icon.dart';
import '../../../core/widgets/big_text.dart';
import '../../../core/widgets/no_data_page.dart';
import '../../../config/routes/app_pages.dart';
import '../cart_ctrl/cart_ctrl.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final bool _isLogged = Get.find<AuthCtrl>().userLoggedIn();
  CartCtrl cartCtrl = Get.find<CartCtrl>();
  UserCtrl userCtrl = Get.find<UserCtrl>();

  

  //double heightNav = Dimensions.bottomHeightBar + 130;

  @override
  Widget build(BuildContext context) {
    cartCtrl.getCartList();
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                  text: 'Cart',
                  color: Colors.white,
                ),
                Container(
                  width: Dimensions.height45,
                ),
              ],
            ),
          ),
          // body
          // GetBuilder<CartCtrl>(
          //   builder: (contr) =>
          cartCtrl.getItems.isNotEmpty
              ? MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: Expanded(
                    child: ListView(
                      children: [
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: cartCtrl.getItems.length,
                          itemBuilder: (_, index) {
                            var product = cartCtrl.getItems[index];
                            cartCtrl.quantity.value = product.quantity!;
                            return GetBuilder<CartCtrl>(
                                builder: (cont) => GestureDetector(
                                      onTap: () {
                                        Get.toNamed(
                                          Routes.RATING_PRODUCT,
                                          arguments: {
                                            AppString.ARGUMENT_PRODUCT:
                                                product.product,
                                            AppString.ARGUMENT_RATINGS:
                                                product.rating,
                                          },
                                        );
                                      },
                                      child: Card(
                                        child: Row(
                                          children: [
                                            //image
                                            Container(
                                              width: Dimensions.height20 * 5,
                                              height: Dimensions.height20 * 5,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                    product.image!,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: Dimensions.width10,
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  BigText(
                                                    text: product.name!,
                                                    color: Colors.black54,
                                                    overflow: TextOverflow.clip,
                                                  ),
                                                  // SmallText(
                                                  //   text: listData.price.toString(),
                                                  // ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      BigText(
                                                        text:
                                                            '\$ ${product.price.toString()}',
                                                        color: Colors.redAccent,
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            right: Dimensions
                                                                .width10),
                                                        padding:
                                                            EdgeInsets.only(
                                                          top: Dimensions
                                                              .height10,
                                                          bottom: Dimensions
                                                              .height10,
                                                          left: Dimensions
                                                              .width10,
                                                          right: Dimensions
                                                              .width10,
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  Dimensions
                                                                      .radius20),
                                                          color:
                                                              Colors.grey[100],
                                                        ),
                                                        child: GetBuilder<
                                                                CartCtrl>(
                                                            builder:
                                                                (controller) {
                                                          return Row(
                                                            children: [
                                                              InkWell(
                                                                onTap: () {
                                                                  controller
                                                                      .setQuantity(
                                                                    false,
                                                                    product
                                                                        .product!
                                                                        .quantity,
                                                                  );
                                                                  if (controller
                                                                      .isValid
                                                                      .value) {
                                                                    controller
                                                                        .addItem(
                                                                      product
                                                                          .id,
                                                                      product
                                                                          .product!,
                                                                      product.quantity! -
                                                                          1,
                                                                    );
                                                                  }
                                                                  setState(
                                                                      () {});
                                                                },
                                                                child: Icon(
                                                                  Icons.remove,
                                                                  color: AppColors
                                                                      .signColor,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: Dimensions
                                                                        .width10 /
                                                                    2,
                                                              ),
                                                              BigText(
                                                                text: controller
                                                                    .quantity
                                                                    .toString(),
                                                              ),
                                                              SizedBox(
                                                                width: Dimensions
                                                                        .width10 /
                                                                    2,
                                                              ),
                                                              InkWell(
                                                                onTap: () {
                                                                  controller
                                                                      .setQuantity(
                                                                    true,
                                                                    product
                                                                        .product!
                                                                        .quantity,
                                                                  );
                                                                  if (controller
                                                                      .isValid
                                                                      .value) {
                                                                    controller
                                                                        .addItem(
                                                                      product
                                                                          .id,
                                                                      product
                                                                          .product!,
                                                                      product.quantity! +
                                                                          1,
                                                                    );
                                                                  }
                                                                  setState(
                                                                      () {});
                                                                },
                                                                child: Icon(
                                                                  Icons.add,
                                                                  color: AppColors
                                                                      .signColor,
                                                                ),
                                                              ),
                                                            ],
                                                          );
                                                        }),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ));
                          },
                        ),
                      ],
                    ),
                  ),
                )
              : const Expanded(
                  child: NoDataPage(
                    text: 'Your cart is empty',
                    imgPath: AppString.ASSETS_EMPTY,
                  ),
                ),
        ],
      ),
      bottomNavigationBar: cartCtrl.getItems.isNotEmpty
          ? Container(
              height: Dimensions.bottomHeightBar + 130,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 150,
                    height: 80,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius15),
                      color: Colors.white,
                    ),
                    child:
                        BigText(text: '\$ ${cartCtrl.totalAmount.toString()}'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomButton(
                        width: 150,
                        height: 80,
                        radius: Dimensions.radius15,
                        fontSize: Dimensions.font20,
                        buttomText: 'Save',
                        onPressed: () {
                          cartCtrl.addToCartHistoryList();
                          Get.back();
                        },
                      ),
                      SizedBox(
                        width: Dimensions.width10,
                      ),
                      const Text('OR'),
                      SizedBox(
                        width: Dimensions.width10,
                      ),
                      CustomButton(
                        width: 150,
                        height: 80,
                        radius: Dimensions.radius15,
                        fontSize: Dimensions.font20,
                        buttomText: 'Check Out',
                        onPressed: () {
                          if (_isLogged) {
                            if (userCtrl.user.address.isEmpty &&
                                userCtrl.user.phone.isEmpty) {
                              Get.toNamed(Routes.UPDATE_PROFILE);
                            } else {
                              Get.toNamed(Routes.CHECKOUT);
                            }
                          } else {
                            Components.showCustomDialog(
                              context: context,
                              msg:
                                  'You should Sign in to complete \n do you want Sign in ?',
                              ok: () {
                                Get.offNamedUntil(
                                    Routes.SIGN_IN, (route) => false);
                              },
                              okColor: Colors.blue,
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            )
          : null,
    );
  }
}