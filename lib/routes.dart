import 'package:amazon_flutter/features/address/screens/address_screen.dart';
import 'package:amazon_flutter/features/order_details/screens/order_details.dart';
import 'package:amazon_flutter/models/order.dart';

import 'common/widgets/bottom_bar.dart';
import 'features/admin/screens/add_product_screen.dart';
import 'features/home/screen/category_deals_screen.dart';
import 'features/home/screen/home_screen.dart';
import 'features/product_details/screens/product_details_screen.dart';
import 'features/search/screens/search_screen.dart';
import 'models/product.dart';

import 'common/utils/app_strings.dart';
import 'features/auth/screen/auth_screen.dart';
import 'package:flutter/material.dart';

class Routers {
  static const String initialRoute = '/';
  static const String auth = '/auth';
  static const String bottombar = '/bottom-bar';
  static const String home = '/home';
  static const String addProduct = '/add-products';
  static const String categoryDeal = '/category-detail';
  static const String search = '/search';
  static const String productDetail = '/product-detail';
  static const String address = '/address';
  static const String orderDetail = '/order-detail';


}

class AppRoutes {
  static Route? onGenerateroute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routers.auth:
        return MaterialPageRoute(
          builder: (context) => const AuthScreen(),
        );
        case Routers.bottombar:
        return MaterialPageRoute(
          builder: (context) => const BottomBar(),
        );
        case Routers.home:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );
        case Routers.addProduct:
        return MaterialPageRoute(
          builder: (context) => const AddProductScreen(),
        );
        case Routers.categoryDeal:
        String category = routeSettings.arguments as String; 
        return MaterialPageRoute(
          builder: (context) => CategoryDealsScreen(category: category),
        );
        case Routers.search:
        String searchQuery = routeSettings.arguments as String; 
        return MaterialPageRoute(
          builder: (context) => SearchScreen(searchQuery: searchQuery),
        );
        case Routers.productDetail:
        var product = routeSettings.arguments as ProductModel;
        return MaterialPageRoute(
          builder: (context) => ProductDetailScreen(product: product),
        );
        case Routers.address:
        String totalAmount = routeSettings.arguments as String; 
        return MaterialPageRoute(
          builder: (context) => AddressScreen(totalAmount: totalAmount),
        );
        case Routers.orderDetail:
        OrderModel order = routeSettings.arguments as OrderModel; 
        return MaterialPageRoute(
          builder: (context) => OrderDetailScreen(order: order),
        );
      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
      builder: (context) => const Scaffold(
        body: Center(
          child: Text(
            AppString.pageNotExsit,
          ),
        ),
      ),
    );
  }
}
