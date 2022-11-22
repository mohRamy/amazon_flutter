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
        height: Dimensions.height45 * 5,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: GlobalVariables.categoryImages.length,
          scrollDirection: Axis.horizontal,
          itemExtent: 200,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                controller.fetchCategoryProduct(category: GlobalVariables.categoryImages[index]['title']!);
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
                alignment: Alignment.bottomCenter,
                children: [ 
                  ClipRRect(
                    borderRadius: BorderRadius.circular(Dimensions.radius15),
                    child:Image.asset(
                        GlobalVariables.categoryImages[index]['image']!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                  ),
                    
                  
                  Container(                
                    width: double.infinity,
                    padding: EdgeInsets.all(
                          Dimensions.width10,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.yellowColor,
                          borderRadius:
                              BorderRadius.only(
                                bottomLeft: Radius.circular(Dimensions.radius15),
                                bottomRight: Radius.circular(Dimensions.radius15),
                              ),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 1,
                              offset: const Offset(0, 2),
                              color: Colors.grey.withOpacity(0.2),
                            ),
                          ],
                        ),
                    child: Text(
                      textAlign: TextAlign.center,
                      GlobalVariables.categoryImages[index]['title']!,
                      style: TextStyle(
                        
                        fontSize: Dimensions.font16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              ),
            );;
          },
        ), 
        
        
        // ListView.builder(
        //   itemCount: GlobalVariables.categoryImages.length,
        //   scrollDirection: Axis.horizontal,
        //   itemExtent: 75,
        //   itemBuilder: (context, index) {
        //     return GestureDetector(
        //       onTap: () {
        //         controller.fetchCategoryProduct(category: GlobalVariables.categoryImages[index]['title']!);
        //         navigateToCategoryPage(
        //         context,
        //         GlobalVariables.categoryImages[index]['title']!,
        //       );
        //       },
        //       child: Column(
        //         children: [
        //           Container(
        //             padding: const EdgeInsets.symmetric(horizontal: 10),
        //             child: ClipRRect(
        //               borderRadius: BorderRadius.circular(50),
        //               child: Image.asset(
        //                 GlobalVariables.categoryImages[index]['image']!,
        //                 fit: BoxFit.cover,
        //                 height: 40,
        //                 width: 40,
        //               ),
        //             ),
        //           ),
        //           Text(
        //             GlobalVariables.categoryImages[index]['title']!,
        //             style: const TextStyle(
        //               fontSize: 12,
        //               fontWeight: FontWeight.w400,
        //             ),
        //           ),
        //         ],
        //       ),
        //     );
        //   },
        // ),
      ),
    );
  }
}
