import 'dart:convert';

import '../../../core/api/api_client.dart';
import 'package:http/http.dart' as http;

import '../../../core/utils/constants/global_variables.dart';

class CheckoutRepo {
  final ApiClient apiClient;
  CheckoutRepo({
    required this.apiClient,
  });

  Future<http.Response> checkout({
    required List<String> productsId,
    required List<int> userQuants,
    required int totalPrice,
    required String address,
  }) async {
    return await apiClient.postData(
      '$uri/api/order',
      jsonEncode({
        'productsId': productsId,
        'userQuants': userQuants,
        'totalPrice': totalPrice,
        'address': address,
      }),
    );
  }
}
