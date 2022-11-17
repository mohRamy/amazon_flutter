import 'dart:convert';

import '../../../core/utils/constants/global_variables.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../core/api/api_client.dart';

import '../../../core/utils/app_strings.dart';
import '../../../models/user_model.dart';

class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  AuthRepo({
    required this.apiClient,
    required this.sharedPreferences,
  });
  // sign up user
  Future<http.Response> signUpUser({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    UserModel user = UserModel(
      id: '',
      name: name,
      email: email,
      password: password,
      phone: phone,
      address: '',
      type: '',
      token: '',
      cart: [],
    );

    return await apiClient.postData('$uri/api/signup', user.toJson());
  }

  //sign in user
  Future<http.Response> login(String email, String password) async {
    return await apiClient.postData(
      '$uri/api/signin',
      jsonEncode({
        'email': email,
        'password': password,
      }),
    );
  }

  // token is valid
  Future<http.Response> tokenIsValid() async {
    return await apiClient.postData('$uri/tokenIsValid', jsonEncode({}));
  }

  // get user data
  Future<http.Response> getUserData() async {
    return await apiClient.getData('$uri/');
  }

  // save user token
  Future<bool> saveUserToken(String tokenKey) async {
    apiClient.token_key = tokenKey;
    apiClient.updateHeaders(tokenKey);
    return await sharedPreferences.setString(AppString.TOKEN_KEY, tokenKey);
  }

  String getUserToken() {
    return sharedPreferences.getString(AppString.TOKEN_KEY) ?? '';
  }

  String getUserType() {
    return sharedPreferences.getString(AppString.TYPE_KEY) ?? '';
  }

  bool userLoggedIn() {
    return sharedPreferences.containsKey(AppString.TOKEN_KEY);
  }
}
