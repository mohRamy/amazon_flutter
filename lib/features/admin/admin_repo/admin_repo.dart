import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../core/api/api_client.dart';
import '../../../core/utils/constants/global_variables.dart';
import '../../../models/order_model.dart';
import '../../../models/product_model.dart';

class AdminRepo {
  final ApiClient apiClient;
  AdminRepo({
    required this.apiClient,
  });

  Future<http.Response> sellProduct({
    required ProductModel product,
  }) async {
    return await apiClient.postData('$uri/admin/add-product', product.toJson());
  }

  //get Product
  Future<http.Response> fetchAllProducts() async {
    return await apiClient.getData('$uri/admin/get-products');
  }

// delete product
  Future<http.Response> deleteProduct({
    required ProductModel product,
  }) async {
    return await apiClient.postData(
      '$uri/admin/delete-product',
      jsonEncode(
        {"id": product.id},
      ),
    );
  }

  // update product
  Future<http.Response> updateProduct({
    required String id,
    required String name,
    required String description,
    required int price,
    required int quantity,
  }) async {
    return await apiClient.postData(
      '$uri/admin/update-product',
      jsonEncode(
        {
          "id": id,
          "name": name,
          "description": description,
          "price": price,
          "quantity": quantity,
        },
      ),
    );
  }

//get Orders
  Future<http.Response> fetchAllOrders() async {
    return await apiClient.getData('$uri/admin/get-orders');
  }

// change order status
  Future<http.Response> changeOrderStatus({
    required int status,
    required OrderModel order,
  }) async {
    return await apiClient.postData(
        '$uri/admin/change-order-status',
        jsonEncode({
          "id": order.id,
          "status": status,
        }));
  }

  // delete product
  Future<http.Response> deleteOrder({
    required OrderModel order,
  }) async {
    return await apiClient.postData(
      '$uri/admin/delete-order',
      jsonEncode(
        {"id": order.id},
      ),
    );
  }

  Future<http.Response> getEarnings() async {
    return await apiClient.getData('$uri/admin/analytics');
  }
}
