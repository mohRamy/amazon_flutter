import 'package:amazon_flutter/features/profile/profile_screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../admin_screens/analtyics_screen.dart';
import '../admin_screens/admin_order_screen.dart';
import '../admin_screens/posts_screen.dart';

class NavAdminCtrl extends GetxController {
  final List<Widget> _pages = [
    const PostsScreen(),
    const AnalyticsScreen(),
    const AdminOrderScreen(),
    const ProfileScreen(),
  ];
  List<Widget> get pages => _pages;

  final Map<String, IconData> _items = {
    'home': Icons.home_outlined,
    'analytics': Icons.analytics_outlined,
    'inbox': Icons.all_inbox_outlined,
    'profile': Icons.person,
  };
  Map<String, IconData> get item => _items;

  final Rx<int> _currentIndex = 0.obs;
  Rx<int> get currentIndex => _currentIndex;

  void changePage(int index) {
    _currentIndex.value = index;
  }
}
