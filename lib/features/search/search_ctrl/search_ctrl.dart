import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../search_repo/search_repo.dart';

import '../../../core/utils/constants/error_handling.dart';
import '../../../models/product_model.dart';

class SearchCtrl extends GetxController implements GetxService {
  final SearchRepo searchRepo;
  SearchCtrl({
    required this.searchRepo,
  });

  List<ProductModel>? products;

  void fetchSearchProducts(String query) async {
    if (query != '') {
      products = await fetchSearchProduct(
        searchQuery: query,
      );
    } else {
      products = [];
    }
    update();
  }

  Future<List<ProductModel>> fetchSearchProduct({
    required String searchQuery,
  }) async {
    List<ProductModel> productList = [];
    try {
      http.Response res =
          await searchRepo.fetchSearchProduct(searchQuery: searchQuery);

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
      update();
    } catch (e) {
      Get.snackbar('', e.toString());
    }
    return productList;
  }
}
