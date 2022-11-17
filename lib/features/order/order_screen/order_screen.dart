import 'package:amazon_flutter/config/routes/app_pages.dart';
import 'package:amazon_flutter/controller/user_controller.dart';
import 'package:amazon_flutter/core/utils/app_colors.dart';
import 'package:amazon_flutter/core/utils/dimensions.dart';
import 'package:amazon_flutter/core/utils/hex_color.dart';
import 'package:amazon_flutter/core/widgets/custom_button.dart';
import 'package:amazon_flutter/core/widgets/small_text.dart';
import 'package:amazon_flutter/features/cart/cart_ctrl/cart_ctrl.dart';
import 'package:amazon_flutter/features/order/order_widgets/radio_widget.dart';
import 'package:amazon_flutter/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/widgets/app_icon.dart';
import '../../../core/widgets/big_text.dart';
import '../order_ctrl/order_ctrl.dart';
import '../order_widgets/items_widget.dart';

enum Ordered {
  visa,
  googlePay,
  applePay,
  cashOnDelivery,
}

class UserOrderScreen extends GetView<OrderCtrl> {
  const UserOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UserCtrl userCtrl = Get.find<UserCtrl>();
    CartCtrl cartCtrl = Get.find<CartCtrl>();

    Ordered? _order = Ordered.cashOnDelivery;

    List<int> userQuants = [];
    List<ProductModel> products = [];

    for (var i = 0; i < cartCtrl.getItems.length; i++) {
      userQuants.add(cartCtrl.getItems[i].quantity!);
      products.add(cartCtrl.getItems[i].product!);
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(Dimensions.height15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      Get.back();
                      // Get.toNamed(Routes.CART);
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                        right: Dimensions.width10,
                        left: Dimensions.width10,
                        top: Dimensions.width10,
                        bottom: Dimensions.width10,
                      ),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 1,
                            offset: const Offset(0, 2),
                            color: Colors.grey.withOpacity(0.2),
                          ),
                        ],
                      ),
                      child: const Icon(Icons.arrow_back),
                    ),
                  ),
                  Text(
                    'Checkout',
                    style: TextStyle(fontSize: Dimensions.iconSize16 + 2),
                  ),
                  SizedBox(width: Dimensions.width10 * 9),
                ],
              ),
              const Divider(),
              SizedBox(height: Dimensions.height20),
              Text(
                'Shipping Address',
                style: TextStyle(fontSize: Dimensions.iconSize16 + 2),
              ),
              SizedBox(height: Dimensions.height10),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.only(
                    right: Dimensions.width10,
                    left: Dimensions.width20,
                    top: Dimensions.width10,
                    bottom: Dimensions.width10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 1,
                        offset: const Offset(0, 2),
                        color: Colors.grey.withOpacity(0.2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: Dimensions.radius20 + 5,
                        backgroundColor: HexColor('D5F5E3'),
                        child: AppIcon(
                          backgroundColor: HexColor('2ECC71'),
                          iconColor: Colors.white,
                          onTap: () {},
                          icon: Icons.location_on,
                          iconSize: Dimensions.height10 * 5 / 2,
                        ),
                      ),
                      SizedBox(width: Dimensions.width30),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Home',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: Dimensions.height10 - 5),
                          SizedBox(
                            width: Dimensions.width10 * 50,
                            child: Column(
                              children: [
                                SmallText(
                                  overflow: TextOverflow.ellipsis,
                                  text:
                                      userCtrl.user.phone,
                                ),
                                SmallText(
                                  overflow: TextOverflow.ellipsis,
                                  text:
                                      userCtrl.user.address,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      const Icon(Icons.edit_note_outlined),
                    ],
                  ),
                ),
              ),
              SizedBox(height: Dimensions.height20),
              Text(
                'Payment Methods',
                style: TextStyle(fontSize: Dimensions.iconSize16 + 2),
              ),
              SizedBox(height: Dimensions.height10),
              RadioWidget(
                image: 'assets/images/visa1.webp',
                title: 'Visa Card',
                radio: Radio<Ordered>(activeColor: AppColors.mainColor, value: Ordered.visa, groupValue: _order, onChanged: (Ordered? val)=>_order = val),
              ),
              RadioWidget(
                image: 'assets/images/google.png',
                title: 'Google Pay',
                radio: Radio<Ordered>(activeColor: AppColors.mainColor, value: Ordered.googlePay, groupValue: _order, onChanged: (Ordered? val)=>_order = val),
              ),
              RadioWidget(
                image: 'assets/images/apple.png',
                title: 'Apple Pay',
                radio: Radio<Ordered>(activeColor: AppColors.mainColor, value: Ordered.applePay, groupValue: _order, onChanged: (Ordered? val)=>_order = val),
              ),
              RadioWidget(
                image: 'assets/images/cash-delivery.webp',
                title: 'Cash on delivery',
                radio: Radio<Ordered>(activeColor: AppColors.mainColor, value: Ordered.cashOnDelivery, groupValue: _order, onChanged: (Ordered? val)=>_order = val),
              ),
              SizedBox(height: Dimensions.height20),
              ItemsWidget(
                txt: '${cartCtrl.getItems.length.toString()} Items',
                account: '\$ ${cartCtrl.totalAmount.toString()}',
              ),
              const ItemsWidget(
                txt: 'ShippingFee',
                account: '\$20',
              ),
              const ItemsWidget(
                txt: 'Discount',
                account: '\$385',
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BigText(text: "Total"),
                  BigText(
                    text: "\$15",
                    color: AppColors.mainColor,
                  ),
                ],
              ),
              SizedBox(height: Dimensions.height20),
              Container(
                padding: EdgeInsets.only(
                  right: Dimensions.width20,
                  left: Dimensions.width20,
                  top: Dimensions.width30,
                  bottom: Dimensions.width30,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 1,
                      offset: const Offset(0, 2),
                      color: Colors.grey.withOpacity(0.2),
                    ),
                  ],
                ),
                child: CustomButton(
                  buttomText: 'Apply',
                  onPressed: () {
                    if (userCtrl.user.address.isNotEmpty || userCtrl.user.phone.isNotEmpty) {
                      controller.placeOrder(
                      products: products,
                      userQuants: userQuants,
                      totalPrice: cartCtrl.totalAmount,
                      address: userCtrl.user.address,
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
