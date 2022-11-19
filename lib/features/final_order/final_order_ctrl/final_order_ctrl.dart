import 'dart:convert';

import 'package:amazon_flutter/core/utils/components/components.dart';
import 'package:amazon_flutter/core/utils/constants/error_handling.dart';
import 'package:amazon_flutter/models/order_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:amazon_flutter/features/final_order/final_order_repo/final_order_repo.dart';

class FinalOrderCtrl extends GetxController implements GetxService {
  final FinalOrderRepo finalOrderRepo;
  FinalOrderCtrl({
    required this.finalOrderRepo,
  });

  List<OrderModel> myOrder = [];

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void fetchMyOrder() async {
    try {
      _isLoading = true;
      update();
      http.Response res = await finalOrderRepo.fetchMyOrder();
      httpErrorHandle(
        res: res,
        onSuccess: () {
          print('pppppppppppppppppppppppppp');
          for (var i = 0; i < jsonDecode(res.body).length; i++) {
            myOrder.add(
              OrderModel.fromJson(
                jsonEncode(
                  jsonDecode(
                    res.body,
                  )[i],
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

  @override
  void onInit() {
    fetchMyOrder();
    super.onInit();
  }
}
