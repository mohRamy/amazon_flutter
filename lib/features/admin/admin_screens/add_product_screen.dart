import 'dart:io';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/widgets/app_icon.dart';
import '../../../core/widgets/big_text.dart';
import '../admin_ctrl/admin_ctrl.dart';
import 'package:get/get.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../../core/picker/picker.dart';
import '../../../core/widgets/custom_textfield.dart';

class AddProductScreen extends GetView<AdminCtrl> {
  AddProductScreen({Key? key}) : super(key: key);

  String category = 'Mobiles';
  List<File> images = [];
  final _addProductFormKey = GlobalKey<FormState>();

  List<String> productCategories = [
    'Mobiles',
    'Essentials',
    'Appliances',
    'Books',
    'Fashion'
  ];

  void sellProduct() {
    if (_addProductFormKey.currentState!.validate() && images.isNotEmpty) {
      controller.sellProduct(
        name: controller.productNameC.text,
        description: controller.descriptionC.text,
        price: int.parse(controller.priceC.text),
        quantity: int.parse(controller.quantityC.text),
        category: category,
        images: images,
      );
    }
  }

  void selectImages() async {
    var res = await pickImagesFromGallery();
    images = res;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: AppColors.mainColor,
            width: double.maxFinite,
            height: Dimensions.height10 * 10,
            padding: EdgeInsets.only(
              top: Dimensions.height45,
              left: Dimensions.width20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(
                  onTap: () => Get.back(),
                  icon: Icons.arrow_back_ios,
                  backgroundColor: AppColors.yellowColor,
                ),
                BigText(
                  text: 'Add Product',
                  color: Colors.white,
                ),
                Container(
                  width: Dimensions.height45,
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: _addProductFormKey,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.width10),
                  child: Column(
                    children: [
                      SizedBox(height: Dimensions.height15),
                      images.isNotEmpty
                          ? CarouselSlider(
                              items: images.map(
                                (i) {
                                  return Builder(
                                    builder: (BuildContext context) =>
                                        Image.file(
                                      i,
                                      fit: BoxFit.cover,
                                      height: 200,
                                    ),
                                  );
                                },
                              ).toList(),
                              options: CarouselOptions(
                                viewportFraction: 1,
                                height: 200,
                              ),
                            )
                          : GestureDetector(
                              onTap: selectImages,
                              child: DottedBorder(
                                borderType: BorderType.RRect,
                                radius:
                                    Radius.circular(Dimensions.radius15 - 5),
                                dashPattern: const [10, 4],
                                strokeCap: StrokeCap.round,
                                child: Container(
                                  width: double.infinity,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.folder_open,
                                        size: 40,
                                      ),
                                      SizedBox(height: Dimensions.height15),
                                      Text(
                                        'Select Product Images',
                                        style: TextStyle(
                                          fontSize: Dimensions.font16 - 1,
                                          color: Colors.grey.shade400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                      SizedBox(height: Dimensions.height20),
                      CustomTextField(
                        controller: controller.productNameC,
                        hintText: 'Product Name',
                      ),
                      SizedBox(height: Dimensions.height10),
                      CustomTextField(
                        controller: controller.descriptionC,
                        hintText: 'Description',
                        maxLines: 7,
                      ),
                      SizedBox(height: Dimensions.height10),
                      CustomTextField(
                        controller: controller.priceC,
                        hintText: 'Price',
                      ),
                      SizedBox(height: Dimensions.height10),
                      CustomTextField(
                        controller: controller.quantityC,
                        hintText: 'Quantity',
                      ),
                      SizedBox(height: Dimensions.height10),
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BigText(text: category),
                            DropdownButton(
                              borderRadius: BorderRadius.circular(
                                  Dimensions.radius15 - 5),
                              dropdownColor: Colors.blueGrey,
                              icon: const Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.grey,
                              ),
                              iconSize: Dimensions.iconSize24,
                              elevation: 4,
                              underline: Container(
                                height: 0,
                              ),
                              // style: subTitleStyle,
                              items: productCategories.map((String item) {
                                return DropdownMenuItem(
                                  value: item,
                                  child: Text(item),
                                );
                              }).toList(),
                              onChanged: (String? newVal) {
                                category = newVal!;
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: Dimensions.height10),
                      // CustomButton(
                      //   text: 'Sell',
                      //   onTap: sellProduct,
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
