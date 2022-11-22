import 'package:amazon_flutter/config/routes/app_pages.dart';
import 'package:amazon_flutter/controller/user_controller.dart';
import 'package:amazon_flutter/core/utils/app_colors.dart';
import 'package:amazon_flutter/core/utils/components/components.dart';
import 'package:amazon_flutter/core/utils/dimensions.dart';
import 'package:amazon_flutter/core/utils/hex_color.dart';
import 'package:amazon_flutter/core/widgets/custom_button.dart';
import 'package:amazon_flutter/core/widgets/small_text.dart';
import 'package:amazon_flutter/features/cart/cart_ctrl/cart_ctrl.dart';
import 'package:amazon_flutter/features/checkout/checkout_ctrl/checkout_ctrl.dart';
import 'package:amazon_flutter/features/checkout/checkout_widgets/radio_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/widgets/app_icon.dart';
import '../../../core/widgets/big_text.dart';
import '../checkout_widgets/items_widget.dart';

enum Ordered {
  visa,
  googlePay,
  applePay,
  cashOnDelivery,
}

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  Ordered? _order = Ordered.visa;
  @override
  Widget build(BuildContext context) {
    UserCtrl userCtrl = Get.find<UserCtrl>();
    CartCtrl cartCtrl = Get.find<CartCtrl>();

    List<int> userQuants = [];
    List<String> productsId = [];

    for (var i = 0; i < cartCtrl.getItems.length; i++) {
      userQuants.add(cartCtrl.getItems[i].quantity!);
      productsId.add(cartCtrl.getItems[i].product!.id!);
    }

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                  text: 'Checkout',
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
              child: Padding(
                  padding: EdgeInsets.all(Dimensions.height10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Shipping Address',
                        style: TextStyle(fontSize: Dimensions.iconSize16 + 2),
                      ),
                      SizedBox(height: Dimensions.height10),
                      GestureDetector(
                        onTap: () => Get.toNamed(Routes.ADDRESS),
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
                                backgroundColor: HexColor('#FCF3CF'),
                                child: AppIcon(
                                  backgroundColor: AppColors.yellowColor,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SmallText(
                                          overflow: TextOverflow.ellipsis,
                                          text: userCtrl.user.phone,
                                        ),
                                        SmallText(
                                          overflow: TextOverflow.ellipsis,
                                          text: userCtrl.user.address,
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
                        radio: Radio<Ordered>(
                          activeColor: AppColors.yellowColor,
                          value: Ordered.visa,
                          groupValue: _order,
                          onChanged: (Ordered? val) {
                            setState(() {
                              _order = val;
                            });
                          },
                        ),
                      ),
                      RadioWidget(
                        image: 'assets/images/google.png',
                        title: 'Google Pay',
                        radio: Radio<Ordered>(
                          activeColor: AppColors.yellowColor,
                          value: Ordered.googlePay,
                          groupValue: _order,
                          onChanged: (Ordered? val) {
                            setState(() {
                              _order = val;
                            });
                          },
                        ),
                      ),
                      RadioWidget(
                        image: 'assets/images/apple.png',
                        title: 'Apple Pay',
                        radio: Radio<Ordered>(
                          activeColor: AppColors.yellowColor,
                          value: Ordered.applePay,
                          groupValue: _order,
                          onChanged: (Ordered? val) {
                            setState(() {
                              _order = val;
                            });
                          },
                        ),
                      ),
                      RadioWidget(
                        image: 'assets/images/cash-delivery.webp',
                        title: 'Cash on delivery',
                        radio: Radio<Ordered>(
                          activeColor: AppColors.yellowColor,
                          value: Ordered.cashOnDelivery,
                          groupValue: _order,
                          onChanged: (Ordered? val) {
                            setState(() {
                              _order = val;
                            });
                          },
                        ),
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
                            color: AppColors.yellowColor,
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
                        child: GetBuilder<CheckoutCtrl>(
                          builder: (checkoutCtrl) {
                            return CustomButton(
                              buttomText: 'Apply',
                              onPressed: () {
                                if (userCtrl.user.address.isNotEmpty ||
                                    userCtrl.user.phone.isNotEmpty) {
                                      print(_order);
                                  if (_order == Ordered.cashOnDelivery) {
                                    checkoutCtrl.checkout(
                                      productsId: productsId,
                                      userQuants: userQuants,
                                      totalPrice: cartCtrl.totalAmount,
                                      address: userCtrl.user.address,
                                    );
                                  }
                                } else {
                                  Components.showCustomSnackBar(
                                      'Your Data is not completed');
                                }
                              },
                            );
                          }
                        ),
                      ),
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
