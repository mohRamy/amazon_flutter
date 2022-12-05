
import 'package:amazon_flutter/features/update_profile/update_profile_screens/address.dart';
import 'package:amazon_flutter/features/checkout/checkout_screen/checkout_screen.dart';

import '../../features/update_profile/update_profile_screens/update_profile_screen.dart';
import '../../features/admin/admin_screens/add_product_screen.dart';
import '../../features/admin/admin_screens/admin_product_details.dart';
import '../../features/nav/nav_screen/nav_admin_screen.dart';
import '../../features/auth/auth_screen/signin_screen.dart';
import '../../features/auth/auth_screen/signup_screen.dart';
import '../../features/cart/cart_screens/cart_screen.dart';
import '../../features/home/home_screen/category_deals_screen.dart';
import '../../features/home/home_screen/home_screen.dart';
import '../../features/nav/nav_screen/nav_user_screen.dart';
import '../../features/order_details/order_details_screens/order_details_screen.dart';
import '../../features/product_details/product_details_screens/newest_product_screen.dart';
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
      name: _Paths.NAV_USER_SCREEN,
      page: () => const NavUserScreen(),
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
      name: _Paths.UPDATE_PROFILE,
      page: () =>  const UpdateProfileScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.ADDRESS,
      page: () =>  const AddressScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.ORDER_DETAIL,
      page: () =>  OrderDetailScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.CART,
      page: () =>   const CartScreen(),
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
      name: _Paths.CHECKOUT,
      page: () =>  const CheckoutScreen(),
      transition: Transition.fadeIn,
    ),
  ];
}
