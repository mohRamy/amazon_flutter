import 'package:http/http.dart' as http;

import '../../../core/api/api_client.dart';

import '../../../core/utils/constants/global_variables.dart';

class AccountRepo {
  final ApiClient apiClient;
  AccountRepo({
    required this.apiClient,
  });

  Future<http.Response> fetchMyOrders() async {
    return await apiClient.getData('$uri/api/orders/me');
  }
}
