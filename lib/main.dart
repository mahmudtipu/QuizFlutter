import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:quiznp/screens/login/login_screen.dart';
import 'package:quiznp/screens/login/provider/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';

FirebaseMessaging messaging = FirebaseMessaging.instance;
final FlutterLocalNotificationsPlugin fltNotification = FlutterLocalNotificationsPlugin();


void pushFCMtoken() async {
  String? token=await messaging.getToken();
  print(token);
}

void initMessaging() {
  var androiInit = AndroidInitializationSettings('@mipmap/ic_launcher');//for logo
  var iosInit = IOSInitializationSettings();
  var initSetting=InitializationSettings(android: androiInit,iOS:
  iosInit);
  fltNotification.initialize(initSetting);
  var androidDetails =
  AndroidNotificationDetails('1', 'channelName', 'channelDescription');
  var iosDetails = IOSNotificationDetails();
  var generalNotificationDetails =
  NotificationDetails(android: androidDetails, iOS: iosDetails);
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {     RemoteNotification? notification=message.notification;
  AndroidNotification? android=message.notification?.android;
  if(notification!=null && android!=null){
    fltNotification.show(
        notification.hashCode, notification.title, notification.
    body, generalNotificationDetails);
  }
  });
}

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  WidgetsFlutterBinding.ensureInitialized();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await Firebase.initializeApp();
  SystemChrome.setEnabledSystemUIOverlays([]);

  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(),
        home: LoginScreen(),
      ),
    );
  }
}