import 'dart:convert';
import 'dart:io';

import 'package:amazon_flutter/models/user_model.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../../common/utils/components/components.dart';
import '../../../common/utils/constants/error_handling.dart';
import '../../../common/utils/constants/global_variables.dart';
import '../../../models/product.dart';
import '../../../provider/user_provider.dart';

class AddressServices{
  void saveUserAddress({
  required BuildContext context,
  required String address,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {

      http.Response res = await http.post(
        Uri.parse('$uri/api/save-user-address'),
        body: jsonEncode({
          "address": address,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandle(
        res: res,
        context: context,
        onSuccess: () {
          UserModel user = userProvider.user.copyWith(
            address: jsonDecode(res.body)["address"],
          );
          userProvider.setUserFromModel(user);
        },
      );
    } catch (e) {
      Components.showSnackBar(context, e.toString());
    }
  }

  void placeOrder({
    required BuildContext context, 
    required String address,
    required String totalSum,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/order'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          "cart": userProvider.user.cart,
          "address" : address,
          "totalPrice": totalSum,
        })
      );
      httpErrorHandle(
        res: res,
        context: context,
        onSuccess: () {
          Components.showSnackBar(context, "Your order has been placed!");
          UserModel user = userProvider.user.copyWith(
            cart: jsonDecode(res.body)["cart"],
          );
          userProvider.setUserFromModel(user);
        },
      );
    } catch (e) {
      Components.showSnackBar(context, e.toString());
    }
  }
}