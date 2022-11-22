
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/api/api_client.dart';
import '../../../core/utils/constants/global_variables.dart';

import 'package:http/http.dart' as http;

class UpdateProfileRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  UpdateProfileRepo({
    required this.apiClient,
    required this.sharedPreferences,
  });

  Future<http.Response> saveUserData(String address, String name, String phone) async {
    return await apiClient.postData(
      '$uri/api/save-user-data',
        jsonEncode({
        'address': address,
        'name': name,
        'phone': phone,
      }),
      
    );
  }
}
