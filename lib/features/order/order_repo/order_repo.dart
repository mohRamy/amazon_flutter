import 'dart:convert';

import 'package:amazon_flutter/core/utils/components/components.dart';
import 'package:amazon_flutter/models/product_model.dart';

import '../../../core/api/api_client.dart';
import 'package:http/http.dart' as http;

import '../../../core/utils/constants/global_variables.dart';

class OrderRepo {
  final ApiClient apiClient;
  OrderRepo({
    required this.apiClient,
  });

  Future<http.Response> placeOrder({
    required List<ProductModel> products,
    required List<int> userQuants,
    required int totalPrice,
    required String address,
  }) async {
      return await apiClient.postData(
        '$uri/api/order',
        jsonEncode({
          'products': products,
          'userQuants': userQuants,
          'totalPrice': totalPrice,
          'address': address,
        }),
      );
    }
  }

