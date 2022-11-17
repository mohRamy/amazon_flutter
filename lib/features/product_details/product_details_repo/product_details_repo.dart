import 'dart:convert';

import 'package:http/http.dart' as http;


import '../../../core/api/api_client.dart';

import '../../../core/utils/constants/global_variables.dart';
import '../../../models/product_model.dart';

class ProductDetailsRepo {
  final ApiClient apiClient;
  ProductDetailsRepo({
    required this.apiClient,
  });
  Future<http.Response> addToCart({
    required ProductModel product,
    required int ord,
  }) async {
    return await apiClient.postData('$uri/api/update-product-quantity', jsonEncode({
      'id': product.id,
      'ord': ord,
    }));
  }

  Future<http.Response> rateProduct({
    required ProductModel product,
    required double rating,
  }) async {
    return await apiClient.postData('$uri/api/rate-product', jsonEncode({
      "id": product.id,
      "rating": rating,
    }));
  }
}
