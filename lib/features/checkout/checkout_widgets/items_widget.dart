
import 'package:flutter/material.dart';

import '../../../core/utils/dimensions.dart';

class ItemsWidget extends StatelessWidget {
  final String txt;
  final String account;
  const ItemsWidget({
    Key? key,
    required this.txt,
    required this.account,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    txt,
                    style: const TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  Text(
                    account,
                    style: const TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                ],
              ),
              SizedBox(height: Dimensions.height10),
      ],
    );
  }
}
