import '../admin_ctrl/admin_ctrl.dart';
import 'package:get/get.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/widgets/big_text.dart';
import '../../../core/widgets/icon_text_widget.dart';
import '../../../core/widgets/small_text.dart';
import '../../../config/routes/app_pages.dart';
import 'package:flutter/material.dart';

class PostsScreen extends GetView<AdminCtrl> {
  const PostsScreen({Key? key}) : super(key: key);

  

  void navigateToAddProduct() {
    Get.toNamed(Routes.ADD_PRODUCT);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<AdminCtrl>(builder: (adminC) {
        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: adminC.products.length,
          itemBuilder: (context, index) {
            var product = adminC.products[index];
            return Column(
              children: [
                SizedBox(height: Dimensions.height10),
                GestureDetector(
                  onTap: () => Get.toNamed(
                    Routes.ADMIN_DETAIL,
                    arguments: {
                      AppString.ARGUMENT_PRODUCT: product,
                      AppString.ARGUMENT_RATINGS: product.rating,
                      "index": index,
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
                          width: Dimensions.listViewImgSize,
                          height: Dimensions.listViewImgSize,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
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
                            height: Dimensions.listViewTextConSize,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(
                                  Dimensions.radius20,
                                ),
                                bottomRight: Radius.circular(
                                  Dimensions.radius20,
                                ),
                              ),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: Dimensions.width10,
                                right: Dimensions.width10,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  BigText(
                                    text: product.name,
                                  ),
                                  SizedBox(
                                    height: Dimensions.height10,
                                  ),
                                  SmallText(
                                    maxline: 1,
                                    overflow: TextOverflow.ellipsis,
                                    text: product.description,
                                  ),
                                  SizedBox(
                                    height: Dimensions.height10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: navigateToAddProduct,
        tooltip: 'Add a Product',
        child: const Icon(Icons.add),
      ),
    );
  }
}
