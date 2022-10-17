import 'dart:convert';

import '../../../models/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../../common/utils/components/components.dart';
import '../../../common/utils/constants/error_handling.dart';
import '../../../common/utils/constants/global_variables.dart';
import '../../../provider/user_provider.dart';

class HomeServices {
  Future<List<ProductModel>> fetchCategoryProduct({
    required BuildContext context,
    required String category,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<ProductModel> productList = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/products?category=$category'),
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
            productList.add(
              ProductModel.fromJson(
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
    return productList;
  }

  Future<ProductModel> fetchDealOfDay({
    required BuildContext context,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    ProductModel product = ProductModel(
      name: '',
      description: '',
      quantity: 0,
      images: [],
      category: '',
      price: 0,
    );

    try {
      http.Response res =
          await http.get(Uri.parse('$uri/api/deal-of-day'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      httpErrorHandle(
        res: res,
        context: context,
        onSuccess: () {
          product = ProductModel.fromJson(res.body);
        }, 
      );
    } catch (e) {
      Components.showSnackBar(context, e.toString());
    }
    return product;
  }
}
