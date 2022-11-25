import 'package:amazon_flutter/core/utils/dimensions.dart';

import '../../../core/utils/app_colors.dart';
import '../home_ctrl/home_ctrl.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';

import '../../../core/utils/constants/global_variables.dart';
import '../../../config/routes/app_pages.dart';

class TopCategories extends GetView<HomeCtrl> {
  const TopCategories({Key? key}) : super(key: key);

  void navigateToCategoryPage(BuildContext context, String category) {
    Get.toNamed(Routes.CATEGORY_DETAIL, arguments: category);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: Dimensions.width10),
      child: SizedBox(
        height: Dimensions.height45 * 2,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: GlobalVariables.categoryImages.length,
          scrollDirection: Axis.horizontal,
          itemExtent: 280,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                controller.fetchCategoryProduct(
                    category: GlobalVariables.categoryImages[index]['title']!);
                navigateToCategoryPage(
                  context,
                  GlobalVariables.categoryImages[index]['title']!,
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radius15),
                ),
                elevation: 2,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(Dimensions.radius15),
                      child: Image.asset(
                        GlobalVariables.categoryImages[index]['image']!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                    Container(
                      height: double.infinity,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.yellowColor.withOpacity(0.2),
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius15),
                      ),
                    ),
                    Text(
                      GlobalVariables.categoryImages[index]['title']!,
                      style: TextStyle(
                        fontSize: Dimensions.font26,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
