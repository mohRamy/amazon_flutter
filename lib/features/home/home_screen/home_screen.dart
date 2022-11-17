import '../../../core/utils/app_strings.dart';
import '../../../controller/user_controller.dart';
import '../home_widgets/top_categories.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/widgets/small_text.dart';
import '../../../config/routes/app_pages.dart';
import '../home_widgets/food_screen_body.dart';

// class HomeScreen extends StatefulWidget {
//   static const String routeName = '/home';
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {

//   void navigateToSearchScreen(String query) {
//     // Navigator.pushNamed(context, Routes.SEARCH, arguments: query);
//     Get.toNamed(Routes.SEARCH, arguments: query);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(60),
//         child: AppBar(
//           flexibleSpace: Container(
//             decoration: const BoxDecoration(
//               gradient: GlobalVariables.appBarGradient,
//             ),
//           ),
//           title: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Expanded(
//                 child: Container(
//                   height: 42,
//                   margin: const EdgeInsets.only(left: 15),
//                   child: Material(
//                     borderRadius: BorderRadius.circular(7),
//                     elevation: 1,
//                     child: TextFormField(
//                       onFieldSubmitted: navigateToSearchScreen,
//                       decoration: InputDecoration(
//                         prefixIcon: InkWell(
//                           onTap: () {},
//                           child: const Padding(
//                             padding: EdgeInsets.only(
//                               left: 6,
//                             ),
//                             child: Icon(
//                               Icons.search,
//                               color: Colors.black,
//                               size: 23,
//                             ),
//                           ),
//                         ),
//                         filled: true,
//                         fillColor: Colors.white,
//                         contentPadding: const EdgeInsets.only(top: 10),
//                         border: const OutlineInputBorder(
//                           borderRadius: BorderRadius.all(
//                             Radius.circular(7),
//                           ),
//                           borderSide: BorderSide.none,
//                         ),
//                         enabledBorder: const OutlineInputBorder(
//                           borderRadius: BorderRadius.all(
//                             Radius.circular(7),
//                           ),
//                           borderSide: BorderSide(
//                             color: Colors.black38,
//                             width: 1,
//                           ),
//                         ),
//                         hintText: 'Search Amazon.in',
//                         hintStyle: const TextStyle(
//                           fontWeight: FontWeight.w500,
//                           fontSize: 17,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Container(
//                 color: Colors.transparent,
//                 height: 42,
//                 margin: const EdgeInsets.symmetric(horizontal: 10),
//                 child: const Icon(Icons.mic, color: Colors.black, size: 25),
//               ),
//             ],
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: const [
//             AddressBox(),
//             SizedBox(height: 10),
//             TopCategories(),
//             SizedBox(height: 10),
//             CarouselImage(),
//             DealOfDay(),
//           ],
//         ),
//       ),
//     );
//   }
// }

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void navigateToSearchScreen() {
    Get.toNamed(Routes.SEARCH);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(
            top: Dimensions.height45,
            bottom: Dimensions.height15,
          ),
          padding: EdgeInsets.only(
            left: Dimensions.width20,
            right: Dimensions.width20,
          ),
          child: GetBuilder<UserCtrl>(
            builder: (ctrl)=> Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ctrl.user.address.isNotEmpty
                    ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppString.APP_NAME,
                            style: TextStyle(
                              color: AppColors.mainColor,
                              fontSize: Dimensions.font20,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SmallText(
                            text: ctrl.user.address.length > 30
                                ? '${ctrl.user.address.substring(0, 30)}...'
                                : '',
                            color: Colors.black54,
                          ),
                        ],
                      )
                    : Text(
                        AppString.APP_NAME,
                        style: TextStyle(
                          color: AppColors.mainColor,
                          fontSize: Dimensions.font20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                GestureDetector(
                  onTap: navigateToSearchScreen,
                  child: Center(
                    child: Container(
                      width: Dimensions.height45,
                      height: Dimensions.height45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius15),
                        color: AppColors.mainColor,
                      ),
                      child: Icon(
                        Icons.search,
                        color: Colors.white,
                        size: Dimensions.iconSize24,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        
        
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const TopCategories(),
                    SizedBox(height: Dimensions.height10),
                    const FoodPageBody(),
                  ],
                ),
              ),
            ),
          
        
      ],
    );
  }
}
