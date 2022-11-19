import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../admin_screens/analtyics_screen.dart';
import '../admin_screens/orders_screen.dart';
import '../admin_screens/posts_screen.dart';

class NavAdminCtrl extends GetxController {
  final List<Widget> _pages = [
    const PostsScreen(),
    AnalyticsScreen(),
    AdminOrderScreen(),
  ];
  List<Widget> get pages => _pages;

  final Map<String, IconData> _items = {
    'home': Icons.home_outlined,
    'analytics': Icons.analytics_outlined,
    'inbox': Icons.all_inbox_outlined,
  };
  Map<String, IconData> get item => _items;

  final Rx<int> _currentIndex = 0.obs;
  Rx<int> get currentIndex => _currentIndex;

  void changePage(int index) {
    _currentIndex.value = index;
  }
}
