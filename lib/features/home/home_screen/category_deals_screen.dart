import '../../../core/widgets/app_icon.dart';
import '../../../core/widgets/custom_loader.dart';
import '../../../core/widgets/no_data_page.dart';
import '../home_ctrl/home_ctrl.dart';
import 'package:get/get.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/widgets/big_text.dart';
import '../../../core/widgets/icon_text_widget.dart';
import '../../../core/widgets/small_text.dart';
import '../../../config/routes/app_pages.dart';
import 'package:flutter/material.dart';

class CategoryDealsScreen extends GetView<HomeCtrl> {
  const CategoryDealsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.productCategory = [];
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: //list of food and images
          Column(
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
                  text: Get.arguments,
                  color: Colors.white,
                ),
                Container(
                  width: Dimensions.height45,
                ),
              ],
            ),
          ),
          GetBuilder<HomeCtrl>(builder: (homeCtrl) {
            return controller.productCategory != null
                ? controller.isLoading != true
                    ? MediaQuery.removePadding(
                        removeTop: true,
                        context: context,
                        child: Expanded(
                          child: ListView(
                            physics: const BouncingScrollPhysics(),
                            children: [
                              ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount:
                                      controller.productCategory?.length ?? 0,
                                  itemBuilder: (context, index) {
                                    var product =
                                        controller.productCategory![index];
                                    return Column(
                                      children: [
                                        SizedBox(
                                          height: Dimensions.height15,
                                        ),
                                        GestureDetector(
                                          onTap: () => Get.toNamed(
                                            Routes.RATING_PRODUCT,
                                            arguments: {
                                              AppString.ARGUMENT_PRODUCT:
                                                  product,
                                              AppString.ARGUMENT_RATINGS:
                                                  product.rating,
                                            },
                                          ),
                                          child: Container(
                                            margin: EdgeInsets.only(
                                              left: Dimensions.width20,
                                              right: Dimensions.width20,
                                              bottom: Dimensions.height10,
                                            ),
                                            child: Row(
                                              children: [
                                                //image section
                                                Container(
                                                  width: Dimensions
                                                      .listViewImgSize,
                                                  height: Dimensions
                                                      .listViewImgSize,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      Dimensions.radius20,
                                                    ),
                                                    color: Colors.white38,
                                                    image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                        product.images[0],
                                                      ),
                                                    ),
                                                  ),
                                                ),

                                                //text container
                                                Expanded(
                                                  child: Container(
                                                    height: Dimensions
                                                        .listViewTextConSize,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topRight:
                                                            Radius.circular(
                                                          Dimensions.radius20,
                                                        ),
                                                        bottomRight:
                                                            Radius.circular(
                                                          Dimensions.radius20,
                                                        ),
                                                      ),
                                                      color: Colors.white,
                                                    ),
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                        left:
                                                            Dimensions.width10,
                                                        right:
                                                            Dimensions.width10,
                                                      ),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          BigText(
                                                            text: product.name,
                                                          ),
                                                          SizedBox(
                                                            height: Dimensions
                                                                .height10,
                                                          ),
                                                          SmallText(
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                                    maxline: 1,
                                                            text: product
                                                                .description,
                                                          ),
                                                          SizedBox(
                                                            height: Dimensions
                                                                .height10,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              IconAndTextWidget(
                                                                icon: Icons
                                                                    .circle_sharp,
                                                                text: 'Normal',
                                                                iconColor: AppColors
                                                                    .iconColor1,
                                                              ),
                                                              IconAndTextWidget(
                                                                icon: Icons
                                                                    .location_on,
                                                                text: '1.7KM',
                                                                iconColor:
                                                                    AppColors
                                                                        .mainColor,
                                                              ),
                                                              IconAndTextWidget(
                                                                icon: Icons
                                                                    .access_time_rounded,
                                                                text: '23min',
                                                                iconColor: AppColors
                                                                    .iconColor2,
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                            ],
                          ),
                        ),
                      )
                    : const Expanded(child: CustomLoader())
                : const Expanded(
                    child: NoDataPage(
                      text: "That's Category is Empty",
                      imgPath: AppString.ASSETS_EMPTY,
                    ),
                  );
          }),
        ],
      ),
    );
  }
}

              
        
        // body: GetBuilder<HomeCtrl>(
        //   builder: (controller) => controller.productList == null
        //       ? const Loader()
        //       : Column(
        //           children: [
        //             Container(
        //               padding: const EdgeInsets.symmetric(
        //                   horizontal: 15, vertical: 10),
        //               alignment: Alignment.topLeft,
        //               child: Text(
        //                 'Keep shopping for ${Get.arguments}',
        //                 style: const TextStyle(
        //                   fontSize: 20,
        //                 ),
        //               ),
        //             ),
        //             SizedBox(
        //               height: 170,
        //               child: controller.productList!.isNotEmpty
        //                   ? GridView.builder(
        //                       scrollDirection: Axis.horizontal,
        //                       padding: const EdgeInsets.only(left: 15),
        //                       itemCount: controller.productList!.length,
        //                       gridDelegate:
        //                           const SliverGridDelegateWithFixedCrossAxisCount(
        //                         crossAxisCount: 1,
        //                         childAspectRatio: 1.4,
        //                         mainAxisSpacing: 10,
        //                       ),
        //                       itemBuilder: (context, index) {
        //                         final product = controller.productList![index];
        //                         return GestureDetector(
        //                           onTap: () {
        //                             Get.toNamed(Routes.PRODUCT_DETAIL,
        //                                 arguments: product);
        //                           },
        //                           child: Column(
        //                             children: [
        //                               SizedBox(
        //                                 height: 130,
        //                                 child: DecoratedBox(
        //                                   decoration: BoxDecoration(
        //                                     border: Border.all(
        //                                       color: Colors.black12,
        //                                       width: 0.5,
        //                                     ),
        //                                   ),
        //                                   child: Padding(
        //                                     padding: const EdgeInsets.all(10),
        //                                     child: Image.network(
        //                                       product.images[0],
        //                                     ),
        //                                   ),
        //                                 ),
        //                               ),
        //                               Container(
        //                                 alignment: Alignment.topLeft,
        //                                 padding: const EdgeInsets.only(
        //                                   left: 0,
        //                                   top: 5,
        //                                   right: 15,
        //                                 ),
        //                                 child: Text(
        //                                   product.name,
        //                                   maxLines: 1,
        //                                   overflow: TextOverflow.ellipsis,
        //                                 ),
        //                               ),
        //                             ],
        //                           ),
        //                         );
        //                       },
        //                     )
        //                   : Container(),
        //             ),
        //           ],
        //         ),
        // ),
        