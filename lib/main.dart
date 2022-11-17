import 'package:flutter/material.dart';

import 'app.dart';
import 'helper/dependencies.dart' as dep;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();

  runApp(
    ShoppingApp(),
  );
}
