import 'dart:convert';
import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../admin_repo/admin_repo.dart';

import '../../../core/utils/constants/error_handling.dart';
import '../../../models/order_model.dart';
import '../../../models/product_model.dart';
import '../admin_models/sales.dart';

class AdminCtrl extends GetxController implements GetxService {
  final AdminRepo adminRepo;
  AdminCtrl({
    required this.adminRepo,
  });

  List<ProductModel> products = [];
  List<OrderModel> orders = [];

  final TextEditingController productNameC = TextEditingController();
  final TextEditingController descriptionC = TextEditingController();
  final TextEditingController priceC = TextEditingController();
  final TextEditingController quantityC = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    productNameC.dispose();
    descriptionC.dispose();
    priceC.dispose();
    quantityC.dispose();
  }

  void sellProduct({
    required String name,
    required String description,
    required int price,
    required int quantity,
    required String category,
    required List<File> images,
  }) async {
    try {
      final cloudinary = CloudinaryPublic('dvn9z2jmy', 'qle4ipae');
      List<String> imageUrl = [];
      for (var i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(
            images[i].path,
            folder: name,
          ),
        );
        imageUrl.add(res.secureUrl);
      }

      ProductModel product = ProductModel(
        name: name,
        description: description,
        quantity: quantity,
        images: imageUrl,
        category: category,
        price: price,
      );

      http.Response res = await adminRepo.sellProduct(
        product: product,
      );

      httpErrorHandle(
        res: res,
        onSuccess: () {
          Get.snackbar('', 'Product Added Successfully!');
          Get.back();
        },
      );
    } catch (e) {
      Get.snackbar('', e.toString());
    }
  }

  //get Product
  void fetchAllProducts() async {
    try {
      http.Response res = await adminRepo.fetchAllProducts();

      httpErrorHandle(
        res: res,
        onSuccess: () {
          for (var i = 0; i < jsonDecode(res.body).length; i++) {
            products.add(
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
  }

  // delete product
  void deleteProduct({
    required ProductModel product,
    required VoidCallback onSuccess,
  }) async {
    try {
      http.Response res = await adminRepo.deleteProduct(product: product);

      httpErrorHandle(
        res: res,
        onSuccess: onSuccess,
      );
    } catch (e) {
      Get.snackbar('', e.toString());
    }
  }

  //get Orders
  void fetchAllOrders() async {
    try {
      http.Response res = await adminRepo.fetchAllOrders();

      httpErrorHandle(
        res: res,
        onSuccess: () {
          for (var i = 0; i < jsonDecode(res.body).length; i++) {
            orders.add(
              OrderModel.fromJson(
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
  }

  // change order status
  void changeOrderStatus({
    required int status,
    required OrderModel order,
    required VoidCallback onSuccess,
  }) async {
    try {
      http.Response res =
          await adminRepo.changeOrderStatus(status: status, order: order);

      httpErrorHandle(
        res: res,
        onSuccess: onSuccess,
      );
    } catch (e) {
      Get.snackbar('', e.toString());
    }
  }

  Future<Map<String, dynamic>> getEarnings() async {
    List<Sales> sales = [];
    int totalEarning = 0;
    try {
      http.Response res = await adminRepo.getEarnings();

      httpErrorHandle(
        res: res,
        onSuccess: () {
          var response = jsonDecode(res.body);
          totalEarning = response['totalEarnings'];
          sales = [
            Sales('Mobiles', response['mobileEarnings']),
            Sales('Essentials', response['essentialEarnings']),
            Sales('Books', response['booksEarnings']),
            Sales('Appliances', response['applianceEarnings']),
            Sales('Fashion', response['fashionEarnings']),
          ];
        },
      );
    } catch (e) {
      Get.snackbar('', e.toString());
    }
    return {
      'sales': sales,
      'totalEarnings': totalEarning,
    };
  }

  @override
  void onInit() {
    fetchAllProducts();
    fetchAllOrders();
    super.onInit();
  }
}
