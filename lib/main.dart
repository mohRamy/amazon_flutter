import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'app.dart';
import 'helper/dependencies.dart' as dep;

// Future<dynamic> myBackgroundMessageHandler(RemoteMessage message)async{
//   print("onBackground:${message.notification?.title}/${message.notification?.body}/"
//       "${message.notification?.titleLocKey}");
// }

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dep.init();

  // try {
  //   if (GetPlatform.isMobile) {
  //     final RemoteMessage? remoteMessage = await FirebaseMessaging.instance.getInitialMessage();
  //     await NotificationHelper.initialize(flutterLocalNotificationsPlugin);
  //     FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
  //   }
  // } catch (e) {
  //   if (kDebugMode) {
  //     print(e.toString());
  //   }
  // }

  runApp(
    ShoppingApp(),
  );
}
