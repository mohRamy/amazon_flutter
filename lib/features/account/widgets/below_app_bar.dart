import 'package:amazon_flutter/core/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/app_colors.dart';
import '../../../controller/user_controller.dart';

class BelowAppBar extends StatelessWidget {
  const BelowAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Get.find<UserCtrl>().user.name;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.mainColor,
      ),
      padding: EdgeInsets.only(
        left: Dimensions.width10,
        right: Dimensions.width10,
        bottom: Dimensions.height10,
      ),
      child: Row(
        children: [
          RichText(
            text: TextSpan(
              text: 'Hello, ',
              style: TextStyle(
                fontSize: Dimensions.font20 + 2,
                color: Colors.black,
              ),
              children: [
                TextSpan(
                  text: user,
                  style: TextStyle(
                    fontSize: Dimensions.font20 + 2,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
