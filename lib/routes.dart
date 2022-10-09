import 'package:amazon_flutter/features/home/screen/home_screen.dart';

import 'common/utils/app_strings.dart';
import 'features/auth/screen/auth_screen.dart';
import 'package:flutter/material.dart';

class Routers {
  static const String initialRoute = '/';
  static const String authScreen = '/authscreen';
  static const String homeScreen = '/homescreen';
}

class AppRoutes {
  static Route? onGenerateroute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routers.authScreen:
        return MaterialPageRoute(
          builder: (context) => const AuthScreen(),
        );
        case Routers.homeScreen:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
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
