import 'package:flutter/material.dart';

import 'stars.dart';

import '../utils/app_colors.dart';
import '../utils/dimensions.dart';
import 'big_text.dart';
import 'icon_text_widget.dart';
import 'small_text.dart';

class AppColumn extends StatelessWidget {
  final String text;
  final double avgRating;
  const AppColumn({
    Key? key,
    required this.text,
    required this.avgRating,
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
            Stars(
              rating: avgRating,
            ),
            const SizedBox(
              width: 10.0,
            ),
            SmallText(
              text: avgRating.toString(),
            ),
            const SizedBox(
              width: 10.0,
            ),
            SmallText(
              text: '2345',
            ),
            const SizedBox(
              width: 10.0,
            ),
            SmallText(
              text: 'comments',
            ),
          ],
        ),
        SizedBox(
          height: Dimensions.height20,
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
