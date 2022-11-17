
import '../home_ctrl/nav_home_ctrl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/app_colors.dart';


class NavScreen extends GetView<NavHomeCtrl> {
  const NavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.grey[100],
      bottomNavigationBar: Obx(
        () =>  BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: controller.item.map(
            (lable, icon)=> MapEntry(
            lable, 
            BottomNavigationBarItem(
              icon: Icon(icon),
              label: lable,
              ),
            )).values.toList(),
          currentIndex: controller.currentIndex.value,
          onTap: (index) {
            controller.changePage(index);
          },
          selectedItemColor: AppColors.mainColor,
          unselectedItemColor: Colors.amberAccent,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          ),
      ),
        body: Obx(()=>controller.pages[controller.currentIndex.value],),
    );
  }
}