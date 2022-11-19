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

  @override
  Widget build(BuildContext context) {
    cartCtrl.getCartList();
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Stack(
        children: [
          // icons
          Positioned(
            top: Dimensions.height20 * 3,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(
                  onTap: () => Get.back(),
                  icon: Icons.arrow_back_ios,
                  iconColor: Colors.white,
                  backgroundColor: AppColors.mainColor,
                  iconSize: Dimensions.iconSize24,
                ),
                SizedBox(
                  width: Dimensions.width20 * 5,
                ),
                AppIcon(
                  onTap: () {
                    //Get.to(Routes.HOME);
                  },
                  icon: Icons.home_outlined,
                  iconColor: Colors.white,
                  backgroundColor: AppColors.mainColor,
                  iconSize: Dimensions.iconSize24,
                ),
                AppIcon(
                  onTap: () {
                    // Get.to(const CartHistory());
                  },
                  icon: Icons.shopping_cart,
                  iconColor: Colors.white,
                  backgroundColor: AppColors.mainColor,
                  iconSize: Dimensions.iconSize24,
                ),
              ],
            ),
          ),
          // body
          // GetBuilder<CartCtrl>(
          //   builder: (contr) =>
          cartCtrl.getItems.isNotEmpty
              ? Positioned(
                  top: Dimensions.height20 * 5,
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                  bottom: 0,
                  child: Container(
                    margin: EdgeInsets.only(top: Dimensions.height15),
                    child: MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
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
                                                  MainAxisAlignment.spaceEvenly,
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
                                                      padding: EdgeInsets.only(
                                                        top:
                                                            Dimensions.height10,
                                                        bottom:
                                                            Dimensions.height10,
                                                        left:
                                                            Dimensions.width10,
                                                        right:
                                                            Dimensions.width10,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                Dimensions
                                                                    .radius20),
                                                        color: Colors.grey[100],
                                                      ),
                                                      child:
                                                          GetBuilder<CartCtrl>(
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
                                                                    product.id,
                                                                    product
                                                                        .product!,
                                                                    product.quantity! -
                                                                        1,
                                                                  );
                                                                }
                                                                setState(() {});
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
                                                                    product.id,
                                                                    product
                                                                        .product!,
                                                                    product.quantity! +
                                                                        1,
                                                                  );
                                                                }
                                                                setState(() {});
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
                    ),
                  ),
                )
              : const NoDataPage(
                  text: 'Your cart is empty',
                  imgPath: AppString.ASSETS_EMPTY,
                ),
        ],
      ),
      bottomNavigationBar: Container(
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
        child: cartCtrl.getItems.isNotEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 150,
                    height: 80,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
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
                        radius: Dimensions.radius20,
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
                        radius: Dimensions.radius20,
                        fontSize: Dimensions.font20,
                        buttomText: 'Check Out',
                        onPressed: () {
                          if (_isLogged) {
                            if (userCtrl.user.address.isEmpty && userCtrl.user.phone.isEmpty) {
                              Get.toNamed(Routes.ADDRESS);
                            } else {
                              Get.toNamed(Routes.USER_ORDER);
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
              )
            : Container(),
      ),
    );
  }
}

// import 'package:amazon_flutter/common/widgets/custom_button.dart';
// import 'package:amazon_flutter/features/cart/cart_ctrl/cart_ctrl.dart';
// import 'package:amazon_flutter/features/cart/cart_widgets/cart_product.dart';
// import 'package:amazon_flutter/features/cart/cart_widgets/cart_subtotal.dart';
// import 'package:amazon_flutter/features/home/widgets/address_box.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../../common/utils/constants/global_variables.dart';
// import '../../../controller/user_controller.dart';
// import '../../../routes/app_pages.dart';

// class CartScreen extends GetView<CartCtrl> {
//   const CartScreen({Key? key}) : super(key: key);

//   void navigateToSearchScreen(String query) {
//     Get.toNamed(Routes.SEARCH, arguments: query);
//   }

//   void navigateToAddress(int sum) {
//     Get.toNamed(Routes.ADDRESS, arguments: sum.toString());
//   }

//   @override
//   Widget build(BuildContext context) {
//     final user = Get.find<UserController>().user;
//     int sum = 0;
//     user.cart
//         .map((e) => sum += e['quantity'] * e['product']['price'] as int)
//         .toList();

//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(60),
//         child: AppBar(
//           flexibleSpace: Container(
//             decoration: const BoxDecoration(
//               gradient: GlobalVariables.appBarGradient,
//             ),
//           ),
//           title: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Expanded(
//                 child: Container(
//                   height: 42,
//                   margin: const EdgeInsets.only(left: 15),
//                   child: Material(
//                     borderRadius: BorderRadius.circular(7),
//                     elevation: 1,
//                     child: TextFormField(
//                       onFieldSubmitted: navigateToSearchScreen,
//                       decoration: InputDecoration(
//                         prefixIcon: InkWell(
//                           onTap: () {},
//                           child: const Padding(
//                             padding: EdgeInsets.only(
//                               left: 6,
//                             ),
//                             child: Icon(
//                               Icons.search,
//                               color: Colors.black,
//                               size: 23,
//                             ),
//                           ),
//                         ),
//                         filled: true,
//                         fillColor: Colors.white,
//                         contentPadding: const EdgeInsets.only(top: 10),
//                         border: const OutlineInputBorder(
//                           borderRadius: BorderRadius.all(
//                             Radius.circular(7),
//                           ),
//                           borderSide: BorderSide.none,
//                         ),
//                         enabledBorder: const OutlineInputBorder(
//                           borderRadius: BorderRadius.all(
//                             Radius.circular(7),
//                           ),
//                           borderSide: BorderSide(
//                             color: Colors.black38,
//                             width: 1,
//                           ),
//                         ),
//                         hintText: 'Search Amazon.in',
//                         hintStyle: const TextStyle(
//                           fontWeight: FontWeight.w500,
//                           fontSize: 17,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Container(
//                 color: Colors.transparent,
//                 height: 42,
//                 margin: const EdgeInsets.symmetric(horizontal: 10),
//                 child: const Icon(Icons.mic, color: Colors.black, size: 25),
//               ),
//             ],
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             const AddressBox(),
//             const CartSubtotal(),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: CustomButton(
//                 text: 'Proceed to Buy (${user.cart.length} items)',
//                 onTap: () => navigateToAddress(sum),
//                 color: Colors.yellow[600],
//               ),
//             ),
//             const SizedBox(height: 15),
//             Container(
//               color: Colors.black12.withOpacity(0.08),
//               height: 1,
//             ),
//             const SizedBox(height: 5),
//             ListView.builder(
//               itemCount: user.cart.length,
//               shrinkWrap: true,
//               itemBuilder: (context, index) {
//                 return CartProduct(
//                   index: index,
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
