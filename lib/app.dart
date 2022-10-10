import 'package:amazon_flutter/features/auth/services/auth_service.dart';
import 'package:amazon_flutter/features/home/screen/home_screen.dart';
import 'package:amazon_flutter/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'common/utils/constants/global_variables.dart';
import 'features/auth/screen/auth_screen.dart';
import 'routes.dart';

class Amazon extends StatefulWidget {
  const Amazon({super.key});

  @override
  State<Amazon> createState() => _AmazonState();
}

class _AmazonState extends State<Amazon> {
  AuthService authService = AuthService();

  @override
  void initState() {
    authService.getUserData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amazon',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        colorScheme: const ColorScheme.light(
          primary: GlobalVariables.secondaryColor,
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0.0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
      ),
      onGenerateRoute: (settings) => AppRoutes.onGenerateroute(settings),
      home: Provider.of<UserProvider>(context).user.token.isNotEmpty
          ? const HomeScreen()
          : const AuthScreen(),
    );
  }
}
