import 'package:amazon_flutter/core/widgets/app_text_button.dart';
import 'package:amazon_flutter/core/widgets/custom_button.dart';
import 'package:amazon_flutter/models/rating_model.dart';
import 'package:dots_indicator/dots_indicator.dart';

import '../../../models/product_model.dart';
import '../product_details_ctrl/product_details_ctrl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/widgets/app_icon.dart';
import '../../../core/widgets/big_text.dart';
import '../../../core/widgets/expandable_text_widget.dart';
import '../../../controller/user_controller.dart';
import '../../../config/routes/app_pages.dart';
import '../../cart/cart_ctrl/cart_ctrl.dart';

class NewestProductScreen extends StatefulWidget {
  const NewestProductScreen({super.key});

  @override
  State<NewestProductScreen> createState() => _NewestProductScreenState();
}

class _NewestProductScreenState extends State<NewestProductScreen> {
  double _currPageValue = 0.0;
  PageController pageController = PageController();
  final double _height = Dimensions.pageView;
  final double _scaleFactor = 0.8;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    ProductDetailsCtrl productDetailsCtrl = Get.find<ProductDetailsCtrl>();
    ProductModel product = Get.arguments[AppString.ARGUMENT_PRODUCT];
    List<RatingModel> ratings = Get.arguments[AppString.ARGUMENT_RATINGS];
    productDetailsCtrl.initProduct(product, Get.find<CartCtrl>());
    double totalRating = 0;
    for (int i = 0; i < ratings.length; i++) {
      totalRating += ratings[i].rating;
      if (ratings[i].userId == Get.find<UserCtrl>().user.id) {
        productDetailsCtrl.myRating.value = ratings[i].rating;
      }
    }

    if (totalRating != 0) {
      productDetailsCtrl.avgRating.value = totalRating / ratings.length;
    }
    return Scaffold(
      backgroundColor: Colors.white,
      //body
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 70,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(
                  onTap: () => Get.back(),
                  icon: Icons.clear,
                ),
                GetBuilder<ProductDetailsCtrl>(
                  builder: (controller) => Stack(
                    children: [
                      AppIcon(
                        onTap: () {
                          if (controller.totalItems != 0) {
                            Get.toNamed(Routes.CART);
                          }
                        },
                        icon: Icons.shopping_cart_outlined,
                      ),
                      controller.totalItems != 0
                          ? Positioned(
                              right: 0.0,
                              top: 0.0,
                              child: AppIcon(
                                onTap: () {},
                                icon: Icons.circle,
                                size: 20,
                                iconColor: Colors.transparent,
                                backgroundColor: AppColors.mainColor,
                              ),
                            )
                          : Container(),
                      controller.totalItems != 0
                          ? Positioned(
                              right: 3.0,
                              top: 3.0,
                              child: BigText(
                                text: Get.find<ProductDetailsCtrl>()
                                    .totalItems
                                    .toString(),
                                size: 12,
                                color: Colors.white,
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ],
            ),
            pinned: true, // expanded حتى يبقى الابار ظاهر حتى بعد ال
            backgroundColor: AppColors.yellowColor,
            expandedHeight: 315,
            flexibleSpace: FlexibleSpaceBar(
              background: product.images.length > 1
                  ? Positioned(
                      left: 0.0,
                      right: 0.0,
                      child: Container(
                        height: Dimensions.pageView,
                        color: Colors.grey[100],
                        child: PageView.builder(
                          physics: const BouncingScrollPhysics(),
                          controller: pageController,
                          itemCount: product.images.length,
                          itemBuilder: (context, position) {
                            return _buildPageItem(
                              position,
                              product.images[position],
                            );
                          },
                        ),
                      ),
                    )
                  : Positioned(
                      left: 0.0,
                      right: 0.0,
                      child: Container(
                        width: double.maxFinite,
                        height: Dimensions.ratingProductImgSize,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(product.images[0]),
                          ),
                        ),
                      ),
                    ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: Dimensions.height10 * 7,
                      ),
                      product.images.length > 1
                          ? DotsIndicator(
                              dotsCount: product.images.isEmpty
                                  ? 1
                                  : product.images.length,
                              position: _currPageValue,
                              decorator: DotsDecorator(
                                activeColor: Colors.blue,
                                size: const Size.square(9.0),
                                activeSize: const Size(18.0, 9.0),
                                activeShape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                              ),
                            )
                          : Container(),
                      productDetailsCtrl.avgRating.value != 0.0
                          ? Obx(() {
                              return Padding(
                                padding: EdgeInsets.all(Dimensions.height10),
                                child: Container(
                                  padding: EdgeInsets.all(
                                    Dimensions.width10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.starColor,
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius15),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 1,
                                        offset: const Offset(0, 2),
                                        color: Colors.grey.withOpacity(0.2),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        color: Colors.black,
                                        size: 20,
                                      ),
                                      Text(
                                        productDetailsCtrl.avgRating.value
                                            .toString(),
                                        style: const TextStyle(
                                          color: Colors.black,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            })
                          : Container(
                              width: Dimensions.height10 * 7,
                            ),
                    ],
                  ),
                  Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.only(
                        // top: 5,
                        // bottom: 10,
                        ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Dimensions.radius20),
                        topRight: Radius.circular(Dimensions.radius20),
                      ),
                    ),
                    child: Center(
                        child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.width20,
                      ),
                      child: BigText(
                        size: Dimensions.font26,
                        text: product.name,
                        overflow: TextOverflow.clip,
                      ),
                    )),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: Dimensions.width20,
              ),
              child: ExpandableTextWidget(
                text: product.description,
              ),
            ),
          ),
        ],
      ),
      //bottom
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(() {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Rate The Product:',
                  style: TextStyle(
                    fontSize: Dimensions.font16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                RatingBar.builder(
                  itemSize: 20,
                  initialRating: productDetailsCtrl.myRating.value,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: AppColors.starColor,
                  ),
                  onRatingUpdate: (rating) {
                    productDetailsCtrl.rateProduct(
                      product: product,
                      rating: rating,
                    );
                  },
                )
              ],
            );
          }),
          Container(
            padding: EdgeInsets.only(
              left: Dimensions.width20 * 2.5,
              right: Dimensions.width20 * 2.5,
              top: Dimensions.height10,
              bottom: Dimensions.height10,
            ),
            child: Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppIcon(
                      onTap: () {
                        productDetailsCtrl.setQuantity(
                          false,
                          product.quantity,
                        );
                      },
                      iconSize: Dimensions.iconSize24,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                      icon: Icons.remove,
                    ),
                    BigText(
                      text:
                          '\$${product.price} *  ${productDetailsCtrl.quantity.value} ',
                      color: Colors.black,
                      size: Dimensions.font26,
                    ),
                    AppIcon(
                      onTap: () {
                        productDetailsCtrl.setQuantity(
                          true,
                          product.quantity,
                        );
                      },
                      iconSize: Dimensions.iconSize24,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                      icon: Icons.add,
                    ),
                  ],
                )),
          ),
          Container(
            height: Dimensions.bottomHeightBar,
            padding: EdgeInsets.only(
              top: Dimensions.height30,
              bottom: Dimensions.height30,
              right: Dimensions.width20,
              left: Dimensions.width20,
            ),
            decoration: BoxDecoration(
              color: AppColors.buttonBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radius20 * 2),
                topRight: Radius.circular(Dimensions.radius20 * 2),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(Dimensions.height20 - 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius15 - 5),
                    color: Colors.white,
                  ),
                  child: const Icon(
                    Icons.favorite,
                    color: Colors.grey,
                  ),
                ),
                // CustomButton(
                //   buttomText: '\$${product.price} | Add to cart',
                //   onPressed: () => productDetailsCtrl.addItem(product),
                //   width: 210,
                //   height: 80,
                //   radius: Dimensions.radius15,
                //   fontSize: Dimensions.font20,
                // ),
                AppTextButton(
                  txt: 'Add to Cart',
                  onTap: ()=> productDetailsCtrl.addItem(product),
                  ),
      
    
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageItem(
    int index,
    String image,
  ) {
    Matrix4 matrix = Matrix4.identity();
    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currtrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currtrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currtrans = _height * (1 - currScale) / 2;

      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currtrans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currtrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currtrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(
          0,
          _height * (1 - _scaleFactor) / 2,
          1,
        );
    }
    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          Container(
            height: Dimensions.pageView,
            decoration: BoxDecoration(
              color: index.isEven
                  ? const Color(0xFF69c5df)
                  : const Color(0xFF9294cc),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(image),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
