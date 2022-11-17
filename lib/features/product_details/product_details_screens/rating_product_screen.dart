// import 'package:amazon_flutter/controller/user_controller.dart';
// import 'package:amazon_flutter/features/product_details/product_details_ctrl/product_details_ctrl.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:get/get.dart';

// import '../../../common/widgets/custom_button.dart';
// import '../../../common/widgets/stars.dart';
// import 'package:flutter/material.dart';

// import 'package:flutter_rating_bar/flutter_rating_bar.dart';

// import '../../../common/utils/constants/global_variables.dart';
// import '../../../routes/app_pages.dart';

// class ProductDetailScreen extends GetView<ProductDetailsCtrl> {
//   ProductDetailScreen({
//     Key? key,
//   }) : super(key: key);

//   void navigateToSearchScreen(String query) {
//     Get.toNamed(Routes.SEARCH, arguments: query);
//   }

//   void addToCart() {
//     controller.addToCart(
//       product: Get.arguments,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     double totalRating = 0;
//     for (int i = 0; i < Get.arguments.rating!.length; i++) {
//       totalRating += Get.arguments.rating![i].rating;
//       if (Get.arguments.rating![i].userId ==
//           Get.find<UserController>().user.id) {
//         controller.myRating.value = Get.arguments.rating![i].rating;
//       }
//     }

//     if (totalRating != 0) {
//       controller.avgRating.value = totalRating / Get.arguments.rating!.length;
//     }
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
//         child: GetBuilder<ProductDetailsCtrl>(
//           builder: (contrller) {
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         Get.arguments.id!,
//                       ),
//                       Stars(
//                         rating: contrller.avgRating.value,
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                     vertical: 20,
//                     horizontal: 10,
//                   ),
//                   child: Text(
//                     Get.arguments.name,
//                     style: const TextStyle(
//                       fontSize: 15,
//                     ),
//                   ),
//                 ),
//                 Get.arguments.images.length == 1?
//                 Image.network(
//                           Get.arguments.images[0],
//                           fit: BoxFit.contain,
//                           height: 300,
//                           width: double.infinity,
//                         ):
//                 CarouselSlider(
//                   items: Get.arguments.images.map<Widget>(
//                     (i) {
//                       return Builder(
//                         builder: (BuildContext context) => Image.network(
//                           i,
//                           fit: BoxFit.contain,
//                           height: 200,
//                         ),
//                       );
//                     },
//                   ).toList(),
//                   options: CarouselOptions(
//                     viewportFraction: 1,
//                     height: 300,
//                   ),
//                 ),
//                 Container(
//                   color: Colors.black12,
//                   height: 5,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8),
//                   child: RichText(
//                     text: TextSpan(
//                       text: 'Deal Price: ',
//                       style: const TextStyle(
//                         fontSize: 16,
//                         color: Colors.black,
//                         fontWeight: FontWeight.bold,
//                       ),
//                       children: [
//                         TextSpan(
//                           text: '\$${Get.arguments.price}',
//                           style: const TextStyle(
//                             fontSize: 22,
//                             color: Colors.red,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(Get.arguments.description),
//                 ),
//                 Container(
//                   color: Colors.black12,
//                   height: 5,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(10),
//                   child: CustomButton(
//                     text: 'Buy Now',
//                     onTap: () {},
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 Padding(
//                   padding: const EdgeInsets.all(10),
//                   child: CustomButton(
//                     text: 'Add to Cart',
//                     onTap: addToCart,
//                     color: const Color.fromRGBO(254, 216, 19, 1),
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 Container(
//                   color: Colors.black12,
//                   height: 5,
//                 ),
//                 const Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 10.0),
//                   child: Text(
//                     'Rate The Product',
//                     style: TextStyle(
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 RatingBar.builder(
//                   initialRating: controller.myRating.value,
//                   minRating: 1,
//                   direction: Axis.horizontal,
//                   allowHalfRating: true,
//                   itemCount: 5,
//                   itemPadding: const EdgeInsets.symmetric(horizontal: 4),
//                   itemBuilder: (context, _) => const Icon(
//                     Icons.star,
//                     color: GlobalVariables.secondaryColor,
//                   ),
//                   onRatingUpdate: (rating) {
//                     controller.rateProduct(
//                       product: Get.arguments,
//                       rating: rating,
//                     );
//                   },
//                 )
//               ],
//             );
//           }
//         ),
//       ),
//     );
//   }
// }

import 'package:amazon_flutter/features/cart/cart_ctrl/cart_ctrl.dart';
import 'package:amazon_flutter/features/product_details/product_details_ctrl/product_details_ctrl.dart';
import 'package:amazon_flutter/models/product_model.dart';
import 'package:amazon_flutter/models/rating_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/widgets/app_column.dart';
import '../../../core/widgets/app_icon.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/widgets/big_text.dart';
import '../../../core/widgets/expandable_text_widget.dart';
import '../../../controller/user_controller.dart';
import '../../../config/routes/app_pages.dart';

class RatingProductScreen extends GetView<ProductDetailsCtrl> {
  const RatingProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ProductModel product = Get.arguments[AppString.ARGUMENT_PRODUCT];
    List<RatingModel> ratings = Get.arguments[AppString.ARGUMENT_RATINGS];
    controller.initProduct(product, Get.find<CartCtrl>());
    double totalRating = 0;
    for (int i = 0; i < ratings.length; i++) {
      totalRating += ratings[i].rating;
      if (ratings[i].userId == Get.find<UserCtrl>().user.id) {
        controller.myRating.value = ratings[i].rating;
      }
    }

    if (totalRating != 0) {
      controller.avgRating.value = totalRating / ratings.length;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // image
          Positioned(
            left: 0.0,
            right: 0.0,
            child: Container(
              width: double.maxFinite,
              height: Dimensions.ratingProductImgSize,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(product.images[0]),
                ),
              ),
            ),
          ),
          // icons
          Positioned(
              top: Dimensions.height45,
              left: Dimensions.width20,
              right: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppIcon(
                    onTap: () => Get.back(),
                    icon: Icons.arrow_back_ios,
                  ),
                  GetBuilder<ProductDetailsCtrl>(
                    builder: (controller) => Stack(
                      children: [
                        AppIcon(
                          onTap: () {
                            if (controller.totalItems != 0) {
                              Get.toNamed(Routes.CART);
                            }
                          },
                          icon: Icons.shopping_cart_outlined,
                        ),
                        controller.totalItems != 0
                            ? Positioned(
                                right: 0.0,
                                top: 0.0,
                                child: AppIcon(
                                  onTap: () {},
                                  icon: Icons.circle,
                                  size: 20,
                                  iconColor: Colors.transparent,
                                  backgroundColor: AppColors.mainColor,
                                ),
                              )
                            : Container(),
                        controller.totalItems != 0
                            ? Positioned(
                                right: 3.0,
                                top: 3.0,
                                child: BigText(
                                  text: Get.find<ProductDetailsCtrl>()
                                      .totalItems
                                      .toString(),
                                  size: 12,
                                  color: Colors.white,
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ],
              )),
          // body
          Positioned(
            top: Dimensions.ratingProductImgSize - 20,
            bottom: 0,
            left: 0.0,
            right: 0.0,
            child: Container(
              padding: EdgeInsets.only(
                top: Dimensions.height20,
                left: Dimensions.width20,
                right: Dimensions.width20,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius20),
                  topRight: Radius.circular(Dimensions.radius20),
                ),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppColumn(
                    text: product.name,
                    avgRating: controller.avgRating.value,
                  ),
                  SizedBox(
                    height: Dimensions.height20,
                  ),
                  BigText(
                    text: 'Introduce',
                  ),
                  SizedBox(
                    height: Dimensions.height20,
                  ),
                  Expanded(
                      child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: ExpandableTextWidget(
                      text: product.description,
                    ),
                  )),
                  SizedBox(height: Dimensions.height10),
                  Container(
                    color: Colors.black12,
                    height: 2,
                  ),
                  SizedBox(
                    height: Dimensions.height10 - 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Rate The Product:',
                        style: TextStyle(
                          fontSize: Dimensions.font16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      RatingBar.builder(
                        itemSize: 20,
                        initialRating: controller.myRating.value,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: AppColors.starColor,
                        ),
                        onRatingUpdate: (rating) {
                          controller.rateProduct(
                            product: product,
                            rating: rating,
                          );
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
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
            Container(
              padding: EdgeInsets.only(
                top: Dimensions.height15,
                bottom: Dimensions.height20,
                left: Dimensions.width20,
                right: Dimensions.width20,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                color: Colors.white,
              ),
              child: Obx(
                () => Row(
                  children: [
                    InkWell(
                      onTap: () {
                        controller.setQuantity(
                          false,
                          product.quantity,
                        );
                      },
                      child: Icon(
                        Icons.remove,
                        color: AppColors.signColor,
                      ),
                    ),
                    SizedBox(
                      width: Dimensions.width10 / 2,
                    ),
                    BigText(text: controller.quantity.toString()),
                    SizedBox(
                      width: Dimensions.width10 / 2,
                    ),
                    InkWell(
                      onTap: () {
                        controller.setQuantity(
                          true,
                          product.quantity,
                        );
                      },
                      child: Icon(
                        Icons.add,
                        color: AppColors.signColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                controller.addItem(product);
                // print(controller.quantity.value);
                // controller.addToCart(
                //   product: product,
                //   ord: controller.quantity.value,
                // );
              },
              child: Container(
                padding: EdgeInsets.only(
                  top: Dimensions.height15,
                  bottom: Dimensions.height20,
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: AppColors.mainColor,
                ),
                child: BigText(
                  text: '\$${product.price} | Add to cart',
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
