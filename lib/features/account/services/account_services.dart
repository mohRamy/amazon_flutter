import 'dart:convert';

import 'package:amazon_flutter/models/order.dart';
import 'package:amazon_flutter/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/utils/components/components.dart';
import '../../../common/utils/constants/error_handling.dart';
import '../../../common/utils/constants/global_variables.dart';
import '../../../models/product.dart';
import '../../../provider/user_provider.dart';

class AccountServices{
  Future<List<OrderModel>> fetchMyOrders({
    required BuildContext context,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<OrderModel> orderList = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/orders/me'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );
      httpErrorHandle(
        res: res,
        context: context,
        onSuccess: () {
          for (var i = 0; i < jsonDecode(res.body).length; i++) {
            orderList.add(
              OrderModel.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      Components.showSnackBar(context, e.toString());
    }
    return orderList;
  }

  void logOut(BuildContext context) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setString('x-auth-token', '');
      Navigator.pushNamedAndRemoveUntil(
        context,
        Routers.auth,
        (route) => false,
      );
    } catch (e) {
      Components.showSnackBar(context, e.toString());
    }
  }
} 