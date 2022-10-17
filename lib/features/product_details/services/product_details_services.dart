import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../../common/utils/components/components.dart';
import '../../../common/utils/constants/error_handling.dart';
import '../../../common/utils/constants/global_variables.dart';
import '../../../models/product.dart';
import '../../../provider/user_provider.dart';

class ProductDetailsServices {
  void rateProduct({
    required BuildContext context,
    required ProductModel product,
    required double rating,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/rate-product'),
        body: jsonEncode({
          "id": product.id,
          "rating": rating,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandle(
        res: res,
        context: context,
        onSuccess: () {},
      );
    } catch (e) {
      Components.showSnackBar(context, e.toString());
    }
  }
}