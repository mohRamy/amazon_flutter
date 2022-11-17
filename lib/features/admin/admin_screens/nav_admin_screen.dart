// import 'analtyics_screen.dart';
// import 'orders_screen.dart';
// import 'posts_screen.dart';
// import 'package:flutter/material.dart';

// import '../../../common/utils/constants/global_variables.dart';

// class AdminScreen extends StatefulWidget {
//   const AdminScreen({Key? key}) : super(key: key);

//   @override
//   State<AdminScreen> createState() => _AdminScreenState();
// }

// class _AdminScreenState extends State<AdminScreen> {
  
//   double bottomBarWidth = 42;
//   double bottomBarBorderWidth = 5;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(50),
//         child: AppBar(
//           flexibleSpace: Container(
//             decoration: const BoxDecoration(
//               gradient: GlobalVariables.appBarGradient,
//             ),
//           ),
//           title: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Container(
//                 alignment: Alignment.topLeft,
//                 child: Image.asset(
//                   'assets/images/amazon_in.png',
//                   width: 120,
//                   height: 45,
//                   color: Colors.black,
//                 ),
//               ),
//               const Text(
//                 'Admin',
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontWeight: FontWeight.bold,
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//       body: pages[_page],
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _page,
//         selectedItemColor: GlobalVariables.selectedNavBarColor,
//         unselectedItemColor: GlobalVariables.unselectedNavBarColor,
//         backgroundColor: GlobalVariables.backgroundColor,
//         iconSize: 28,
//         onTap: updatePage,
//         items: [
//           // POSTS
//           BottomNavigationBarItem(
//             icon: Container(
//               width: bottomBarWidth,
//               decoration: BoxDecoration(
//                 border: Border(
//                   top: BorderSide(
//                     color: _page == 0
//                         ? GlobalVariables.selectedNavBarColor
//                         : GlobalVariables.backgroundColor,
//                     width: bottomBarBorderWidth,
//                   ),
//                 ),
//               ),
//               child: const Icon(
//                 Icons.home_outlined,
//               ),
//             ),
//             label: '',
//           ),
//           // ANALYTICS
//           BottomNavigationBarItem(
//             icon: Container(
//               width: bottomBarWidth,
//               decoration: BoxDecoration(
//                 border: Border(
//                   top: BorderSide(
//                     color: _page == 1
//                         ? GlobalVariables.selectedNavBarColor
//                         : GlobalVariables.backgroundColor,
//                     width: bottomBarBorderWidth,
//                   ),
//                 ),
//               ),
//               child: const Icon(
//                 Icons.analytics_outlined,
//               ),
//             ),
//             label: '',
//           ),
//           // ORDERS
//           BottomNavigationBarItem(
//             icon: Container(
//               width: bottomBarWidth,
//               decoration: BoxDecoration(
//                 border: Border(
//                   top: BorderSide(
//                     color: _page == 2
//                         ? GlobalVariables.selectedNavBarColor
//                         : GlobalVariables.backgroundColor,
//                     width: bottomBarBorderWidth,
//                   ),
//                 ),
//               ),
//               child: const Icon(
//                 Icons.all_inbox_outlined,
//               ),
//             ),
//             label: '',
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/app_colors.dart';
import '../admin_ctrl/nav_admin_ctrl.dart';

class NavAdminScreen extends GetView<NavAdminCtrl> {
  const NavAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      bottomNavigationBar: 
      Obx(
        () =>  
        BottomNavigationBar(
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