import 'package:amazon_flutter/common/widgets/bottom_bar.dart';
import 'package:amazon_flutter/features/admin/screens/add_product_screen.dart';
import 'package:amazon_flutter/features/home/screen/home_screen.dart';

import 'common/utils/app_strings.dart';
import 'features/auth/screen/auth_screen.dart';
import 'package:flutter/material.dart';

class Routers {
  static const String initialRoute = '/';
  static const String authScreen = '/authscreen';
  static const String bottombar = '/bottombar';
  static const String homeScreen = '/homescreen';
  static const String addProductScreen = '/addproductscreen';
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
