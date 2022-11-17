
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/api/api_client.dart';
import '../../../core/utils/constants/global_variables.dart';

import 'package:http/http.dart' as http;

class AddressRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  AddressRepo({
    required this.apiClient,
    required this.sharedPreferences,
  });

  // Future<http.Response> getAddressfromGeocode(LatLng latLng) async {
  //   return await apiClient.getData(
  //     ''
  //     '?lat=${latLng.latitude}&lng=${latLng.longitude}',
  //   );
  // }

  // String getUserAddress() {
  //   return sharedPreferences.getString(AppString.USER_ADDRESS) ?? '';
  // }

  Future<http.Response> saveUserAddress(String address) async {
    return await apiClient.postData(
      '$uri/api/save-user-address',
        jsonEncode({
        'address': address,
      }),
      
    );
  }
}
