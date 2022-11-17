import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../home_repo/home_repo.dart';

import '../../../core/utils/constants/error_handling.dart';
import '../../../models/product_model.dart';

class HomeCtrl extends GetxController implements GetxService {
  final HomeRepo homeRepo;
  HomeCtrl({
    required this.homeRepo,
  });

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<ProductModel>? productCategory;
  List<ProductModel>? productRating;
  // List<ProductModel>? productList;
  
  Future<List<ProductModel>> fetchCategoryProduct({
    required String category,
  }) async {
    List<ProductModel> productList = [];
    try {
      _isLoading = false;
      update();
      http.Response res =
          await homeRepo.fetchCategoryProduct(category: category);

      httpErrorHandle(
        res: res,
        onSuccess: () {
          for (var i = 0; i < jsonDecode(res.body).length; i++) {
            productList.add(
              ProductModel.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      Get.snackbar('', e.toString());
    }
    _isLoading = false;
    update();
    return productList;
  }

  Future<List<ProductModel>> fetchRatingProduct() async {
    List<ProductModel> productList = [];

    try {
      _isLoading = true;
    update();
      http.Response res = await homeRepo.fetchRatingProduct();
      
      httpErrorHandle(
        res: res,
        onSuccess: () {
          for (var i = 0; i < jsonDecode(res.body).length; i++) {
            productList.add(
              ProductModel.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
      
    } catch (e) {
      Get.snackbar('', '00000000000000');
    }
    _isLoading = false;
    update();
    return productList;
  }

  // Future<List<ProductModel>> fetchAllProduct() async {
  //   List<ProductModel> productList = [];
  //   try {
  //     http.Response res = await homeRepo.fetchAllProduct();

  //     httpErrorHandle(
  //         res: res,
  //         onSuccess: () {
  //           for (var i = 0; i < jsonDecode(res.body).length; i++) {
  //             productList.add(
  //               ProductModel.fromJson(
  //                 jsonEncode(
  //                   jsonDecode(res.body)[i],
  //                 ),
  //               ),
  //             );
  //           }
  //         });
  //   } catch (e) {
  //     Get.snackbar('', e.toString());
  //   }
  //   return productList;
  // }
}
