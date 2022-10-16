import 'package:amazon_flutter/common/widgets/bottom_bar.dart';
import 'package:amazon_flutter/features/admin/screens/add_product_screen.dart';
import 'package:amazon_flutter/features/home/screen/category_deals_screen.dart';
import 'package:amazon_flutter/features/home/screen/home_screen.dart';
import 'package:amazon_flutter/features/product_details/screens/product_details_screen.dart';
import 'package:amazon_flutter/features/search/screens/search_screen.dart';
import 'package:amazon_flutter/models/product.dart';
import 'package:flutter/foundation.dart';

import 'common/utils/app_strings.dart';
import 'features/auth/screen/auth_screen.dart';
import 'package:flutter/material.dart';

class Routers {
  static const String initialRoute = '/';
  static const String authScreen = '/auth';
  static const String bottombar = '/bottom-bar';
  static const String homeScreen = '/home';
  static const String addProductScreen = '/add-products';
  static const String categoryDeals = '/category-deals';
  static const String search = '/search';
  static const String productDetailScreen = '/product-detail';
}

class AppRoutes {
  static Route? onGenerateroute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routers.authScreen:
        return MaterialPageRoute(
          builder: (context) => const AuthScreen(),
        );
        case Routers.bottombar:
        return MaterialPageRoute(
          builder: (context) => const BottomBar(),
        );
        case Routers.homeScreen:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );
        case Routers.addProductScreen:
        return MaterialPageRoute(
          builder: (context) => const AddProductScreen(),
        );
        case Routers.categoryDeals:
        String category = routeSettings.arguments as String; 
        return MaterialPageRoute(
          builder: (context) => CategoryDealsScreen(category: category),
        );
        case Routers.search:
        String searchQuery = routeSettings.arguments as String; 
        return MaterialPageRoute(
          builder: (context) => SearchScreen(searchQuery: searchQuery),
        );
        case Routers.productDetailScreen:
        var product = routeSettings.arguments as ProductModel;
        return MaterialPageRoute(
          builder: (context) => ProductDetailScreen(product: product),
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
