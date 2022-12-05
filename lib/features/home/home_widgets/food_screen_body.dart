import 'package:amazon_flutter/features/home/home_widgets/top_categories.dart';

import '../../../core/utils/constants/global_variables.dart';
import '../home_ctrl/home_ctrl.dart';
import '../../../models/product_model.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/widgets/app_column.dart';
import '../../../core/widgets/big_text.dart';
import '../../../core/widgets/icon_text_widget.dart';
import '../../../core/widgets/small_text.dart';
import '../../../config/routes/app_pages.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({super.key});

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  final double _scaleFactor = 0.8;
  final double _height = Dimensions.pageViewContainer;

  HomeCtrl homeCtrl = Get.find<HomeCtrl>();

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TopCategories(),
        SizedBox(height: Dimensions.height20),
        Padding(
          padding: EdgeInsets.only(left: Dimensions.width30),
          child: BigText(
              text: 'Highest Rated',
          ),
        ),
        // slider section
        GetBuilder<HomeCtrl>(builder: (homeC) {
          return SizedBox(
            height: Dimensions.pageView,
            child: PageView.builder(
              physics: const BouncingScrollPhysics(),
              controller: pageController,
              itemCount: 7,
              itemBuilder: (context, position) {
                return _buildPageItem(
                  position,
                  homeCtrl.productRating[position],
                );
              },
            ),
          );
        }),
        //dots
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GetBuilder<HomeCtrl>(builder: (popularProducts) {
              return DotsIndicator(
                dotsCount: homeCtrl.productRating.isEmpty
                    ? 1
                    : 7,
                position: _currPageValue,
                decorator: DotsDecorator(
                  activeColor: Colors.blue,
                  size: const Size.square(9.0),
                  activeSize: const Size(18.0, 9.0),
                  activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),
              );
            }),
          ],
        ),

        //Popular text
        SizedBox(height: Dimensions.height20),
        Padding(
          padding: EdgeInsets.only(left: Dimensions.width30),
          child: BigText(
              text: 'Newest Products',
            
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.width30),
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1 / 1.6,
              crossAxisSpacing: Dimensions.height10,
            ),
            itemCount: homeCtrl.productNew.length,
            itemBuilder: (context, index) {
              var product = homeCtrl.productNew[index];
              double totalRating = 0;
              double avgRating = 0;

              for (int i = 0; i < product.rating!.length; i++) {
                totalRating += product.rating![i].rating;
              }

              if (totalRating != 0) {
                avgRating = totalRating / product.rating!.length;
              }
              double docs = product.price / product.oldPrice * 100;
              return product.quantity == 0
                  ? Container()
                  : GestureDetector(
                      onTap: () => Get.toNamed(
                        Routes.NEWEST_PRODUCT,
                        arguments: {
                          AppString.ARGUMENT_PRODUCT: product,
                          AppString.ARGUMENT_RATINGS: product.rating,
                        },
                      ),
                      child: Column(
                        children: [
                          //image section
                          Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 170,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(
                                      Dimensions.radius20,
                                    ),
                                    topRight: Radius.circular(
                                      Dimensions.radius20,
                                    ),
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
                              product.oldPrice != 0
                                  ? Positioned(
                                      top: 0.0,
                                      left: 0.0,
                                      child: Container(
                                        padding: const EdgeInsets.all(3),
                                        decoration: BoxDecoration(
                                          color: AppColors.yellowColor,
                                          borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(
                                              Dimensions.radius15 - 5,
                                            ),
                                            topLeft: Radius.circular(
                                              Dimensions.radius20,
                                            ),
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Text(
                                              'Disc %${docs.round()}',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: Dimensions.font16 + 2,
                                                //decoration: TextDecoration.lineThrough,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : Container(),
                              avgRating != 0.0
                                  ? Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Container(
                                        padding: EdgeInsets.all(
                                          Dimensions.width10,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.starColor,
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.radius15),
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 1,
                                              offset: const Offset(0, 2),
                                              color:
                                                  Colors.grey.withOpacity(0.2),
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
                                              avgRating.toString(),
                                              style: const TextStyle(
                                                color: Colors.black,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.all(Dimensions.height10 - 7),
                            //height: Dimensions.listViewTextConSize - 15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(
                                  Dimensions.radius20,
                                ),
                                bottomRight: Radius.circular(
                                  Dimensions.radius20,
                                ),
                              ),
                              color: Colors.white,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: Dimensions.width10 * 35,
                                      child: BigText(
                                        text: product.name,
                                        size: Dimensions.font16,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: Dimensions.height10,
                                ),
                                Row(
                                  children: [
                                    BigText(
                                      text: '\$${product.price.toString()}',
                                      // color: AppColors.yellowColor,
                                      size: Dimensions.font20,
                                    ),
                                    const Spacer(),
                                    Container(
                                      padding: EdgeInsets.all(
                                        Dimensions.width10,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.mainColor,
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.radius15),
                                        // boxShadow: [
                                        //   BoxShadow(
                                        //     blurRadius: 1,
                                        //     offset: const Offset(0, 2),
                                        //     color: Colors.grey.withOpacity(0.2),
                                        //   ),
                                        // ],
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(
                                            Icons.category,
                                            color: Colors.black,
                                            size: 20,
                                          ),
                                          Text(
                                            product.category,
                                            style: const TextStyle(
                                              color: Colors.black,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: Dimensions.height10),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
            },
          ),
        ),
        //list of food and images
        // GetBuilder<HomeCtrl>(builder: (homeC) {
        //   return ListView.builder(
        //     physics: const NeverScrollableScrollPhysics(),
        //     shrinkWrap: true,
        //     itemCount: homeCtrl.productRating.length,
        //     itemBuilder: (context, index) {
        //       var product = homeCtrl.productRating[index];
        //       double totalRating = 0;
        //       double avgRating = 0;

        //       for (int i = 0; i < product.rating!.length; i++) {
        //         totalRating += product.rating![i].rating;
        //       }

        //       if (totalRating != 0) {
        //         avgRating = totalRating / product.rating!.length;
        //       }
        //       return product.quantity == 0
        //           ? Container()
        //           : GestureDetector(
        //               onTap: () => Get.toNamed(
        //                 Routes.NEWEST_PRODUCT,
        //                 arguments: {
        //                   AppString.ARGUMENT_PRODUCT: product,
        //                   AppString.ARGUMENT_RATINGS: product.rating,
        //                 },
        //               ),
        //               child: Container(
        //                 margin: EdgeInsets.only(
        //                   left: Dimensions.width20,
        //                   right: Dimensions.width20,
        //                   bottom: Dimensions.height10,
        //                 ),
        //                 child: Row(
        //                   children: [
        //                     //image section
        //                     Container(
        //                       width: Dimensions.listViewImgSize,
        //                       height: Dimensions.listViewImgSize,
        //                       decoration: BoxDecoration(
        //                         borderRadius: BorderRadius.circular(
        //                           Dimensions.radius20,
        //                         ),
        //                         color: Colors.white38,
        //                         image: DecorationImage(
        //                           fit: BoxFit.cover,
        //                           image: NetworkImage(
        //                             product.images[0],
        //                           ),
        //                         ),
        //                       ),
        //                     ),

        //                     //text container
        //                     Expanded(
        //                       child: Container(
        //                         height: Dimensions.listViewTextConSize,
        //                         decoration: BoxDecoration(
        //                           borderRadius: BorderRadius.only(
        //                             topRight: Radius.circular(
        //                               Dimensions.radius20,
        //                             ),
        //                             bottomRight: Radius.circular(
        //                               Dimensions.radius20,
        //                             ),
        //                           ),
        //                           color: Colors.white,
        //                         ),
        //                         child: Padding(
        //                           padding: EdgeInsets.only(
        //                             top: Dimensions.height10,
        //                             left: Dimensions.width10,
        //                             right: Dimensions.width10,
        //                           ),
        //                           child: Column(
        //                             mainAxisAlignment: MainAxisAlignment.center,
        //                             children: [
        //                               Row(
        //                                 mainAxisAlignment:
        //                                     MainAxisAlignment.spaceBetween,
        //                                 children: [
        //                                   SizedBox(
        //                                     width: 170,
        //                                     child: BigText(
        //                                       text: product.name,
        //                                       size: Dimensions.font20,
        //                                       overflow: TextOverflow.ellipsis,
        //                                     ),
        //                                   ),
        //                                   avgRating != 0.0
        //                                       ? Container(
        //                                           padding: EdgeInsets.all(
        //                                             Dimensions.width10,
        //                                           ),
        //                                           decoration: BoxDecoration(
        //                                             color: AppColors.starColor,
        //                                             borderRadius:
        //                                                 BorderRadius.circular(
        //                                                     Dimensions
        //                                                         .radius15),
        //                                             boxShadow: [
        //                                               BoxShadow(
        //                                                 blurRadius: 1,
        //                                                 offset:
        //                                                     const Offset(0, 2),
        //                                                 color: Colors.grey
        //                                                     .withOpacity(0.2),
        //                                               ),
        //                                             ],
        //                                           ),
        //                                           child: Row(
        //                                             mainAxisSize:
        //                                                 MainAxisSize.min,
        //                                             children: [
        //                                               const Icon(
        //                                                 Icons.star,
        //                                                 color: Colors.black,
        //                                                 size: 20,
        //                                               ),
        //                                               Text(
        //                                                 avgRating.toString(),
        //                                                 style: const TextStyle(
        //                                                   color: Colors.black,
        //                                                 ),
        //                                               )
        //                                             ],
        //                                           ),
        //                                         )
        //                                       : Container(),
        //                                 ],
        //                               ),
        //                               SizedBox(
        //                                 height: Dimensions.height10,
        //                               ),
        //                               Row(
        //                                 children: [
        //                                   BigText(
        //                                     text: product.price.toString(),
        //                                     color: AppColors.yellowColor,
        //                                     size: 22,
        //                                   ),
        //                                   const SizedBox(
        //                                     width: 10.0,
        //                                   ),
        //                                   product.oldPrice != 0
        //                                       ? Text(
        //                                           'Discount %${product.price / product.oldPrice * 100}',
        //                                           style: const TextStyle(
        //                                             color: Colors.grey,
        //                                             fontSize: 18,
        //                                             decoration: TextDecoration
        //                                                 .lineThrough,
        //                                           ),
        //                                         )
        //                                       : Container(),
        //                                   const Spacer(),
        //                                   Container(
        //                                     padding: EdgeInsets.all(
        //                                       Dimensions.width10,
        //                                     ),
        //                                     decoration: BoxDecoration(
        //                                       color: AppColors.yellowColor,
        //                                       borderRadius:
        //                                           BorderRadius.circular(
        //                                               Dimensions.radius15),
        //                                       boxShadow: [
        //                                         BoxShadow(
        //                                           blurRadius: 1,
        //                                           offset: const Offset(0, 2),
        //                                           color: Colors.grey
        //                                               .withOpacity(0.2),
        //                                         ),
        //                                       ],
        //                                     ),
        //                                     child: Row(
        //                                       mainAxisSize: MainAxisSize.min,
        //                                       children: [
        //                                         const Icon(
        //                                           Icons.category,
        //                                           color: Colors.black,
        //                                           size: 20,
        //                                         ),
        //                                         Text(
        //                                           product.category,
        //                                           style: const TextStyle(
        //                                             color: Colors.black,
        //                                           ),
        //                                         )
        //                                       ],
        //                                     ),
        //                                   ),
        //                                 ],
        //                               ),
        //                             ],
        //                           ),
        //                           // Column(
        //                           //   crossAxisAlignment:
        //                           //       CrossAxisAlignment.start,
        //                           //   mainAxisAlignment: MainAxisAlignment.center,
        //                           //   children: [
        //                           //     BigText(
        //                           //       text: product.name,
        //                           //     ),
        //                           //     SizedBox(
        //                           //       height: Dimensions.height10,
        //                           //     ),
        //                           //     SmallText(
        //                           //       maxline: 1,
        //                           //       overflow: TextOverflow.ellipsis,
        //                           //       text: product.description,
        //                           //     ),
        //                           //     SizedBox(
        //                           //       height: Dimensions.height10,
        //                           //     ),
        //                           //     Row(
        //                           //       mainAxisAlignment:
        //                           //           MainAxisAlignment.spaceBetween,
        //                           //       children: [
        //                           //         IconAndTextWidget(
        //                           //           icon: Icons.circle_sharp,
        //                           //           text: 'Normal',
        //                           //           iconColor: AppColors.iconColor1,
        //                           //         ),
        //                           //         IconAndTextWidget(
        //                           //           icon: Icons.location_on,
        //                           //           text: '1.7KM',
        //                           //           iconColor: AppColors.mainColor,
        //                           //         ),
        //                           //         IconAndTextWidget(
        //                           //           icon: Icons.access_time_rounded,
        //                           //           text: '23min',
        //                           //           iconColor: AppColors.iconColor2,
        //                           //         ),
        //                           //       ],
        //                           //     ),
        //                           //   ],
        //                           // ),
        //                         ),
        //                       ),
        //                     ),
        //                   ],
        //                 ),
        //               ),
        //             );
        //     },
        //   );
        // }),
      ],
    );
  }

  Widget _buildPageItem(
    int index,
    ProductModel product,
  ) {
    double totalRating = 0;
    double avgRating = 0;

    for (int i = 0; i < product.rating!.length; i++) {
      totalRating += product.rating![i].rating;
    }

    if (totalRating != 0) {
      avgRating = totalRating / product.rating!.length;
    }

    Matrix4 matrix = Matrix4.identity();
    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currtrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currtrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currtrans = _height * (1 - currScale) / 2;

      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currtrans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currtrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currtrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(
          0,
          _height * (1 - _scaleFactor) / 2,
          1,
        );
    }
    return GestureDetector(
      onTap: () => Get.toNamed(
        Routes.RATING_PRODUCT,
        arguments: {
          AppString.ARGUMENT_PRODUCT: product,
          AppString.ARGUMENT_RATINGS: product.rating,
        },
      ),
      child: Transform(
        transform: matrix,
        child: Stack(
          children: [
            Container(
              height: Dimensions.pageViewContainer,
              margin: EdgeInsets.only(
                left: Dimensions.width10,
                right: Dimensions.width10,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                color: index.isEven
                    ? const Color(0xFF69c5df)
                    : const Color(0xFF9294cc),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(product.images[0]),
                ),
              ),
            ),
            // avgRating != 0.0
            //     ? Positioned(
            //         top: Dimensions.height10 * 13,
            //         right: Dimensions.width20,
            //         child: Container(
            //           padding: EdgeInsets.all(
            //             Dimensions.width10,
            //           ),
            //           decoration: BoxDecoration(
            //             color: AppColors.starColor,
            //             borderRadius:
            //                 BorderRadius.circular(Dimensions.radius15),
            //             boxShadow: [
            //               BoxShadow(
            //                 blurRadius: 1,
            //                 offset: const Offset(0, 2),
            //                 color: Colors.grey.withOpacity(0.2),
            //               ),
            //             ],
            //           ),
            //           child: Row(
            //             mainAxisSize: MainAxisSize.min,
            //             children: [
            //               const Icon(
            //                 Icons.star,
            //                 color: Colors.black,
            //                 size: 20,
            //               ),
            //               Text(
            //                 avgRating.toString(),
            //                 style: const TextStyle(
            //                   color: Colors.black,
            //                 ),
            //               )
            //             ],
            //           ),
            //         ),
            //       )
            //     : Container(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    avgRating != 0.0
                    ? Padding(
                      padding: EdgeInsets.only(right: Dimensions.width20, bottom: Dimensions.height10 - 2),
                      child: Container(
                        padding: EdgeInsets.all(
                          Dimensions.width10,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.starColor,
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
                              avgRating.toString(),
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                    : Container(),
                    Container(
                      margin: EdgeInsets.only(
                        left: Dimensions.width30,
                        right: Dimensions.width30,
                        bottom: Dimensions.height30,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius20),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xFFe8e8e8),
                            blurRadius: 5.0,
                            offset: Offset(0, 5),
                          ),
                          BoxShadow(
                            color: Colors.white,
                            offset: Offset(-5, 0),
                          ),
                          BoxShadow(
                            color: Colors.white,
                            offset: Offset(5, 0),
                          ),
                        ],
                      ),
                      child: Container(
                        padding: EdgeInsets.only(
                          right: Dimensions.width15,
                          left: Dimensions.width15,
                        ),
                        child: AppColumn(
                          text: product.name,
                          category: product.category,
                          price: product.price,
                          oldPrice: product.oldPrice,
                        ),
                      ),
                    ),
                  ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
