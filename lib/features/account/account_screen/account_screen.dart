import 'package:amazon_flutter/core/utils/dimensions.dart';
import 'package:get/get.dart';

import '../../../core/utils/app_colors.dart';
import '../widgets/top_buttons.dart';
import 'package:flutter/material.dart';

import '../widgets/below_app_bar.dart';
import '../widgets/orders.dart';

class AccountScreen extends GetView<AccountScreen> {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Dimensions.height45 + 5),
        child: AppBar(
          elevation: 0.0,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              color: AppColors.mainColor,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  'assets/images/amazon_in.png',
                  width: 120,
                  height: Dimensions.height45,
                  color: Colors.black,
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: Dimensions.width15, right: Dimensions.width15),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: Dimensions.width15),
                      child: const Icon(Icons.notifications_outlined),
                    ),
                    const Icon(
                      Icons.search,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          const BelowAppBar(),
          SizedBox(height: Dimensions.height10),
          const TopButtons(),
          SizedBox(height: Dimensions.height20),
          const Orders(),
        ],
      ),
    );
  }
}
