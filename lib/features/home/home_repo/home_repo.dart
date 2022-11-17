import 'package:http/http.dart' as http;


import '../../../core/api/api_client.dart';

import '../../../core/utils/constants/global_variables.dart';

class HomeRepo {
  final ApiClient apiClient;
  HomeRepo({
    required this.apiClient,
  });

  Future<http.Response> fetchCategoryProduct({
    required String category,
  }) async {
    return await apiClient.getData('$uri/api/products?category=$category');
  }

  Future<http.Response> fetchRatingProduct() async {
    return await apiClient.getData('$uri/api/get-rating-products');
  }

  Future<http.Response> fetchAllProduct() async {
    return await apiClient.getData('$uri/api/get-newest-products');
  }
}
