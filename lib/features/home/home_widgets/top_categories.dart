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

  fetchCategoryProducts(String category) async {
    controller.productCategory =
        await controller.fetchCategoryProduct(category: category);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        itemCount: GlobalVariables.categoryImages.length,
        scrollDirection: Axis.horizontal,
        itemExtent: 75,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              fetchCategoryProducts(GlobalVariables.categoryImages[index]['title']!,);
              navigateToCategoryPage(
              context,
              GlobalVariables.categoryImages[index]['title']!,
            );
            },
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(
                      GlobalVariables.categoryImages[index]['image']!,
                      fit: BoxFit.cover,
                      height: 40,
                      width: 40,
                    ),
                  ),
                ),
                Text(
                  GlobalVariables.categoryImages[index]['title']!,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
