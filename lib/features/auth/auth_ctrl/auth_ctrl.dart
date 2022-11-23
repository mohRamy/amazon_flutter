import 'dart:convert';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../auth_repo/auth_repo.dart';

import '../../../core/api/api_client.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/utils/constants/error_handling.dart';
import '../../../controller/user_controller.dart';
import '../../../config/routes/app_pages.dart';
import '../../../helper/dependencies.dart' as dep;

enum Auth {
  signin,
  signup,
}

class AuthCtrl extends GetxController implements GetxService {
  final ApiClient apiClient;
  final AuthRepo authRepo;
  SharedPreferences sharedPreferences;
  AuthCtrl({
    required this.apiClient,
    required this.authRepo,
    required this.sharedPreferences,
  });

  final Rx<Auth> _auth = Rx(Auth.signup);
  Rx<Auth> get auth => _auth;

  void onChanged(Auth? val) {
    _auth.value = val!;
    update();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // final TextEditingController emailC = TextEditingController();
  // final TextEditingController passwordC = TextEditingController();
  // final TextEditingController nameC = TextEditingController();

  TextEditingController emailIC = TextEditingController();
  TextEditingController passwordIC = TextEditingController();

  TextEditingController emailUC = TextEditingController();
  TextEditingController passwordUC = TextEditingController();
  TextEditingController nameUC = TextEditingController();
  TextEditingController phoneUC = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailIC.dispose();
    passwordIC.dispose();
    
    emailUC.dispose();
    passwordUC.dispose();
    nameUC.dispose();
    phoneUC.dispose();
  }

  void signUpUser({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    try {
      _isLoading = true;
      update();
      http.Response res = await authRepo.signUpUser(
        name: name,
        email: email,
        password: password,
        phone: phone,
      );

      httpErrorHandle(
        res: res,
        onSuccess: () {
          Get.snackbar('', 'Account created! Login with the same credentials!');
        },
      );
    } catch (e) {
      Get.snackbar('', e.toString());
    }
    _isLoading = false;
    update();
  }

  void signInUser(
    String email,
    String password,
  ) async {
    try {
      _isLoading = true;
      update();
      http.Response res = await authRepo.login(email, password);

      httpErrorHandle(
        res: res,
        onSuccess: () async {
          await dep.init();
          authRepo.saveUserToken(jsonDecode(res.body)['token']);

          Get.find<UserCtrl>().setUserFromJson(res.body);

          sharedPreferences.setString(AppString.TYPE_KEY, jsonDecode(res.body)['type']);

          if (Get.find<UserCtrl>().user.type == 'user') {
            Get.offNamedUntil(Routes.NAV_HOME_SCREEN, (route) => false);
          } else {
            Get.offNamedUntil(Routes.NAV_ADMIN_SCREEN, (route) => false);
          }
        },
      );
    } catch (e) {
      Get.snackbar('', '2');
    }
    _isLoading = false;
    update();
  }

  void getUserData() async {
    try {
      _isLoading = true;
      update();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString(AppString.TOKEN);

      if (token == null) {
        prefs.setString(AppString.TOKEN, '');
      }

      http.Response tokenRes = await authRepo.tokenIsValid();
      bool response = jsonDecode(tokenRes.body);

      if (response == true) {
        http.Response userRes = await authRepo.getUserData();

        UserCtrl userController = Get.find<UserCtrl>();
        userController.setUserFromJson(userRes.body);
      }
    } catch (e) {
      Get.snackbar('', e.toString());
    }
    _isLoading = false;
    update();
  }

  bool userLoggedIn() {
    return authRepo.userLoggedIn();
  }

  bool clearSharedData() {
    sharedPreferences.remove(AppString.TOKEN_KEY);
    // sharedPreferences.remove(AppString.NUMBER_KEY);
    // sharedPreferences.remove(AppString.PASSWORD_KEY);
    apiClient.token_key = '';
    apiClient.updateHeaders('');
    return true;
  }
  
  bool isObscure = true;

  void changeObsure(){
  isObscure = !isObscure;
  update();
  }
  }
