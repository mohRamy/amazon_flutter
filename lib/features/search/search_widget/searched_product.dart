import 'package:get/get.dart';

import '../../../config/routes/app_pages.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/widgets/big_text.dart';
import '../../../models/product_model.dart';
import 'package:flutter/material.dart';

import '../search_ctrl/search_ctrl.dart';

class SearchedProduct extends GetView<SearchCtrl> {
  final ProductModel product;
  const SearchedProduct({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double totalRating = 0;
    for (int i = 0; i < product.rating!.length; i++) {
      totalRating += product.rating![i].rating;
    }
    double avgRating = 0;
    if (totalRating != 0) {
      avgRating = totalRating / product.rating!.length;
    }
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: GetBuilder<SearchCtrl>(
          builder: (cont) => GestureDetector(
                onTap: () {
                  Get.toNamed(
                    Routes.NEWEST_PRODUCT,
                    arguments: {
                      AppString.ARGUMENT_PRODUCT: product,
                      AppString.ARGUMENT_RATINGS: product.rating,
                    },
                  );
                },
                child: Card(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                              product.images[0],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: Dimensions.width10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            BigText(
                              text: product.name,
                              color: Colors.black54,
                              overflow: TextOverflow.clip,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                BigText(
                                  text: '\$ ${product.price.toString()}',
                                  color: Colors.redAccent,
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      right: Dimensions.width10),
                                  padding: EdgeInsets.only(
                                    top: Dimensions.height10,
                                    bottom: Dimensions.height10,
                                    left: Dimensions.width10,
                                    right: Dimensions.width10,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius20),
                                    color: Colors.grey[100],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: Dimensions.height10),
                            const Text('Eligible for FREE Shipping', style: TextStyle(
                                fontSize: 15
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: AppColors.starColor,
                              size: 20,
                            ),
                            Text(avgRating.toString()),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),
    );
    // return SingleChildScrollView(
    //   physics: const BouncingScrollPhysics(),
    //   child: Column(
    //     children: [
    //       Row(
    //           children: [
    //             Image.network(
    //               product.images[0],
    //               fit: BoxFit.contain,
    //               height: 100,
    //               width: 100,
    //             ),
    //             Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 Row(
    //                   children: [
    //                     Container(
    //                   width: 235,
    //                   padding: const EdgeInsets.symmetric(horizontal: 10),
    //                   child: Text(
    //                     product.name,
    //                     style: const TextStyle(
    //                       fontSize: 16,
    //                     ),
    //                     maxLines: 2,
    //                   ),
    //                 ),
    //                     Row(
    //                     children: [
    //                       Icon(Icons.star, color: AppColors.starColor,size: 20,),
    //                       Text(avgRating.toString()),
    //                     ],
    //                   ),

    //                   ],
    //                 ),
    //                 // Container(
    //                 //   width: 235,
    //                 //   padding: const EdgeInsets.only(left: 10, top: 5),
    //                 //   child: Text(
    //                 //     '\$${product.price}',
    //                 //     style: const TextStyle(
    //                 //       fontSize: 20,
    //                 //       fontWeight: FontWeight.bold,
    //                 //     ),
    //                 //     maxLines: 2,
    //                 //   ),
    //                 // ),
    //                 Container(
    //                   width: 235,
    //                   padding: const EdgeInsets.only(left: 10),
    //                   child: const Text('Eligible for FREE Shipping'),
    //                 ),
    //                 Container(
    //                   width: 235,
    //                   padding: const EdgeInsets.only(left: 10, top: 5),
    //                   child: const Text(
    //                     'In Stock',
    //                     style: TextStyle(
    //                       color: Colors.teal,
    //                     ),
    //                     maxLines: 2,
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ],
    //         ),
    //       const SizedBox(height: 15.0,),
    //     ],
    //   ),
    // );
  }
}
