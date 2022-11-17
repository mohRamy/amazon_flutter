
import 'package:amazon_flutter/features/address/address_screens/pick_address_map.dart';
import 'package:amazon_flutter/features/order/order_screen/order_screen.dart';

import '../../features/address/address_screens/address_screen.dart';
import '../../features/admin/admin_screens/add_product_screen.dart';
import '../../features/admin/admin_screens/admin_details.dart';
import '../../features/admin/admin_screens/nav_admin_screen.dart';
import '../../features/auth/auth_screen/signin_screen.dart';
import '../../features/auth/auth_screen/signup_screen.dart';
import '../../features/cart/cart_screens/cart_screen.dart';
import '../../features/home/home_screen/category_deals_screen.dart';
import '../../features/home/home_screen/home_screen.dart';
import '../../features/home/home_screen/nav_screen.dart';
import '../../features/order_details/order_details_screens/order_details_screen.dart';
import '../../features/product_details/product_details_screens/newest_product.dart';
import '../../features/product_details/product_details_screens/rating_product_screen.dart';
import '../../features/search/search_screens/search_screen.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static final List<GetPage> routes = [
    GetPage(
      name: _Paths.SIGN_IN,
      page: () => const SignInScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.SIGN_UP,
      page: () => const SignUpScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.NAV_ADMIN_SCREEN,
      page: () => const NavAdminScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.NAV_HOME_SCREEN,
      page: () => const NavScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.ADD_PRODUCT,
      page: () =>  AddProductScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.CATEGORY_DETAIL,
      page: () => const CategoryDealsScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.SEARCH,
      page: () =>  const SearchScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.ADDRESS,
      page: () =>  const AddAddressScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.PICK_ADDRESS,
      page: () =>  const PickAddressMap(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.ORDER_DETAIL,
      page: () =>  OrderDetailScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.CART,
      page: () =>   CartScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.RATING_PRODUCT,
      page: () =>  const RatingProductScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.NEWEST_PRODUCT,
      page: () =>  const NewestProductScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.ADMIN_DETAIL,
      page: () =>  const AdminDetailsScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.USER_ORDER,
      page: () =>  const UserOrderScreen(),
      transition: Transition.fadeIn,
    ),
  ];
}
