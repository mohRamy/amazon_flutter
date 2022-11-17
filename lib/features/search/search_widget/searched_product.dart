import 'package:amazon_flutter/core/utils/app_colors.dart';

import '../../../models/product_model.dart';
import 'package:flutter/material.dart';


class SearchedProduct extends StatelessWidget {
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
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Row(
              children: [
                Image.network(
                  product.images[0],
                  fit: BoxFit.contain,
                  height: 100,
                  width: 100,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                      width: 235,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        product.name,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                        maxLines: 2,
                      ),
                    ),
                        Row(
                        children: [
                          Icon(Icons.star, color: AppColors.starColor,size: 20,),
                          Text(avgRating.toString()),
                        ],
                      ),
    
                      ],
                    ),
                    // Container(
                    //   width: 235,
                    //   padding: const EdgeInsets.only(left: 10, top: 5),
                    //   child: Text(
                    //     '\$${product.price}',
                    //     style: const TextStyle(
                    //       fontSize: 20,
                    //       fontWeight: FontWeight.bold,
                    //     ),
                    //     maxLines: 2,
                    //   ),
                    // ),
                    Container(
                      width: 235,
                      padding: const EdgeInsets.only(left: 10),
                      child: const Text('Eligible for FREE Shipping'),
                    ),
                    Container(
                      width: 235,
                      padding: const EdgeInsets.only(left: 10, top: 5),
                      child: const Text(
                        'In Stock',
                        style: TextStyle(
                          color: Colors.teal,
                        ),
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          const SizedBox(height: 15.0,),
        ],
      ),
    );
  }
}
