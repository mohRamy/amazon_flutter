import 'dart:convert';
import 'dart:io';

import 'package:amazon_flutter/config/routes/app_pages.dart';
import 'package:amazon_flutter/core/utils/components/components.dart';
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

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final TextEditingController productNameC = TextEditingController();
  final TextEditingController descriptionC = TextEditingController();
  final TextEditingController priceC = TextEditingController();
  final TextEditingController quantityC = TextEditingController();

  final TextEditingController productNameUC = TextEditingController();
  final TextEditingController descreptionUC = TextEditingController();
  final TextEditingController priceUC = TextEditingController();
  final TextEditingController quantityUC = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    productNameC.dispose();
    descriptionC.dispose();
    priceC.dispose();
    quantityC.dispose();
    productNameUC.dispose();
    descreptionUC.dispose();
    priceUC.dispose();
    quantityUC.dispose();
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
        oldPrice: 0,
      );

      http.Response res = await adminRepo.sellProduct(
        product: product,
      );

      httpErrorHandle(
        res: res,
        onSuccess: () {
          Get.snackbar('Product', 'Product Added Successfully!');
          Get.back();
        },
      );
      update();
    } catch (e) {
      Components.showCustomSnackBar(e.toString());
    }
  }

  //get Product
  void fetchAllProducts() async {
    try {
      _isLoading = true;
      update();
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
      _isLoading = false;
      update();
    } catch (e) {
      Components.showCustomSnackBar(e.toString());
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
      update();
    } catch (e) {
      Components.showCustomSnackBar(e.toString());
    }
  }

  // update product
  void updateProduct({
    required String id,
    required String name,
    required String description,
    required int price,
    required int quantity,
  }) async {
    try {
      http.Response res = await adminRepo.updateProduct(
        id: id,
        name: name,
        description: description,
        price: price,
        quantity: quantity,
      );
      

      httpErrorHandle(
        res: res,
        onSuccess: () {
          Components.showCustomSnackBar('Update Seccessfully', title: 'Update');
          Get.back();
        },
      );
      update();
    } catch (e) {
      Components.showCustomSnackBar(e.toString());
    }
  }

  //get Orders
  void fetchAllOrders() async {
    try {
      _isLoading = true;
      update();
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
      _isLoading = false;
      update();
    } catch (e) {
      Components.showCustomSnackBar(e.toString());
    }
  }

  int currentStep = 0;

  // change order status
  void changeOrderStatus({
    required int status,
    required OrderModel order,
  }) async {
    try {
      http.Response res =
          await adminRepo.changeOrderStatus(status: status, order: order);

      httpErrorHandle(
        res: res,
        onSuccess: (){
          currentStep += 1;
        },
      );
      update();
    } catch (e) {
      Components.showCustomSnackBar(e.toString());
    }
  }

  // delete order
  void deleteOrder({
    required OrderModel order,
  }) async {
    try {
      http.Response res = await adminRepo.deleteOrder(order: order);

      httpErrorHandle(
        res: res,
        onSuccess: (){
          Get.toNamed(Routes.NAV_ADMIN_SCREEN);
        },
      );
      update();
    } catch (e) {
      Components.showCustomSnackBar(e.toString());
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
      update();
    } catch (e) {
      Components.showCustomSnackBar(e.toString());
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
