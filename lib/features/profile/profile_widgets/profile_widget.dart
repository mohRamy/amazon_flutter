import 'package:flutter/material.dart';

import '../../../core/utils/dimensions.dart';
import '../../../core/widgets/app_icon.dart';
import '../../../core/widgets/big_text.dart';

class AccountWidget extends StatelessWidget {
  AppIcon appIcon;
  BigText bigText;
  Function() onTap;
  AccountWidget({
    Key? key,
    required this.appIcon,
    required this.bigText,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
            appIcon,
            SizedBox(width: Dimensions.width20),
            Expanded(child: bigText),
          ],
        ),
      ),
    );
  }
}
