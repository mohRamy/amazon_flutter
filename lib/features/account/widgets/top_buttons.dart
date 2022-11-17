import 'package:amazon_flutter/core/utils/dimensions.dart';

import '../account_ctrl/account_ctrl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'account_button.dart';

class TopButtons extends GetView<AccountCtlr> {
  const TopButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountButton(
              text: 'Your Orders',
              onTap: () {},
            ),
            AccountButton(
              text: 'Turn Seller',
              onTap: () {},
            ),
          ],
        ),
        SizedBox(height: Dimensions.height10),
        Row(
          children: [
            AccountButton(
              text: 'Log Out',
              onTap: () => controller.logOut(),
            ),
            AccountButton(
              text: 'Your Wish List',
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }
}
