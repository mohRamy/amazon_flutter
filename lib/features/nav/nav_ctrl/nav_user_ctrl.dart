import 'package:amazon_flutter/features/cart/cart_screens/cart_history.dart';
import 'package:amazon_flutter/features/order/order_screen/order_screen.dart';

import '../../cart/cart_screens/cart_screen.dart';
import '../../home/home_screen/home_screen.dart';
import '../../profile/profile_screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class NavUserCtrl extends GetxController {
  final List<Widget> _pages = [
    const HomeScreen(),
    const OrderScreen(),
    const CartHistory(),
    const ProfileScreen(),
  ];
  List<Widget> get pages => _pages;

  final Map<String, IconData> _items = {
    'home': Icons.home_outlined,
    'history': Icons.archive,
    'cart': Icons.shopping_cart,
    'me': Icons.person,
  };
  Map<String, IconData> get item => _items;

  final Rx<int> _currentIndex = 0.obs;
  Rx<int> get currentIndex => _currentIndex;

  void changePage(int index) {
    _currentIndex.value = index;
  }
}
