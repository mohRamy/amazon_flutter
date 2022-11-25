import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/dimensions.dart';
import 'big_text.dart';
import 'icon_text_widget.dart';

class AppColumn extends StatelessWidget {
  final String text;
  final String category;
  final int price;
  final int oldPrice;
  const AppColumn({
    Key? key,
    required this.text,
    required this.category,
    required this.price,
    required this.oldPrice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(
          text: text,
          size: Dimensions.font26,
          overflow: TextOverflow.clip,
        ),
        SizedBox(
          height: Dimensions.height10,
        ),
        Row(
          children: [
            BigText(
              text: '\$${price.toString()}',
              color: Colors.black,
              size: Dimensions.font20,
            ),
            const SizedBox(
              width: 10.0,
            ),
            oldPrice != 0 ? Text(
              '\$${oldPrice.toString()}',
              style: TextStyle(
                color: Colors.grey,
                fontSize: Dimensions.font16 + 2,
                decoration: TextDecoration.lineThrough,
              ),
            ) : Container(),
            const Spacer(),
            Container(
                padding: EdgeInsets.all(
                  Dimensions.width10,
                ),
                decoration: BoxDecoration(
                  color: AppColors.mainColor,
                  borderRadius: BorderRadius.circular(Dimensions.radius15),
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
                      category,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
            ),
          ],
        ),
        SizedBox(
          height: Dimensions.height15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconAndTextWidget(
              icon: Icons.circle_sharp,
              text: 'Normal',
              iconColor: AppColors.iconColor1,
            ),
            IconAndTextWidget(
              icon: Icons.location_on,
              text: '1.7KM',
              iconColor: AppColors.mainColor,
            ),
            IconAndTextWidget(
              icon: Icons.access_time_rounded,
              text: '23min',
              iconColor: AppColors.iconColor2,
            ),
          ],
        ),
      ],
    );
  }
}
