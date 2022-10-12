import 'dart:convert';
import 'dart:io';

import 'package:amazon_flutter/common/utils/components/components.dart';
import 'package:amazon_flutter/common/utils/constants/error_handling.dart';
import 'package:amazon_flutter/common/utils/constants/global_variables.dart';
import 'package:amazon_flutter/models/product.dart';
import 'package:amazon_flutter/provider/user_provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AddminServices {
  void sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
  }) async {
    final userProvider = Provider.of<UserProvider>(context);
    try {
      final cloudinary = CloudinaryPublic('dvn9z2jmy', 'qle4ipae');
      List<String> imageUrl = [];
      for (var i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(
            images[i].path,
            folder: name,
          ),
        );
        imageUrl.add(res.secureUrl);
      }

      ProductModel product = ProductModel(
        name: name,
        description: description,
        quantity: quantity,
        images: imageUrl,
        category: category,
        price: price,
      );

      http.Response res = await http.post(
        Uri.parse('$uri/admin/add-product'),
        body: product.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          Components.showSnackBar(context, 'Product Added Successfully!');
          Navigator.pop(context);
        },
      );
    } catch (e) {
      Components.showSnackBar(context, e.toString());
    }
  }
}
