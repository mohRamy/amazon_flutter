import 'package:amazon_flutter/core/api/api_client.dart';
import 'package:amazon_flutter/core/utils/constants/global_variables.dart';
import 'package:http/http.dart' as http;

class FinalOrderRepo {
  final ApiClient apiClient;
  FinalOrderRepo({
    required this.apiClient,
  });

  Future<http.Response> fetchMyOrder() async {
    return await apiClient.getData('$uri/api/orders/me');
  }
}
