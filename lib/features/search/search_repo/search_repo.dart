import 'package:http/http.dart' as http;

import '../../../core/api/api_client.dart';

import '../../../core/utils/constants/global_variables.dart';

class SearchRepo {
  final ApiClient apiClient;
  SearchRepo({
    required this.apiClient,
  });
  Future<http.Response> fetchSearchProduct({
    required String searchQuery,
  }) async {
    return await apiClient.getData('$uri/api/products/search/$searchQuery');
  }
}
