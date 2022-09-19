import 'dart:ui';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:quiznp/screens/home/body.dart';
import 'package:quiznp/screens/leaderboard/leaderboard.dart';
import 'package:quiznp/screens/payment/payment.dart';
import 'package:quiznp/screens/settings/settings.dart';
import 'package:quiznp/screens/shop/shop.dart';

import '../../main.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin fltNotification= FlutterLocalNotificationsPlugin();
  void pushFCMtoken() async {
    String? token=await messaging.getToken();
    print(token);
//you will get token here in the console
  }
  @override
  void initState() {
    super.initState();
    pushFCMtoken();
    initMessaging();
  }

  void initMessaging() {
    var androiInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInit = IOSInitializationSettings();
    var initSetting = InitializationSettings(android: androiInit, iOS: iosInit);
    fltNotification = FlutterLocalNotificationsPlugin();
    fltNotification.initialize(initSetting);
    var androidDetails =
    AndroidNotificationDetails('1', 'channelName', 'channel Description');
    var iosDetails = IOSNotificationDetails();
    var generalNotificationDetails =
    NotificationDetails(android: androidDetails, iOS: iosDetails);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification=message.notification;
      AndroidNotification? android=message.notification?.android;
      if(notification!=null && android!=null){
        fltNotification.show(
            notification.hashCode, notification.title, notification.body, generalNotificationDetails);
      }});}

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      if (_selectedIndex == 0)
      {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return SettingsScreen();
              },
            )
        );
      }
      else if (_selectedIndex == 1)
      {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return ShopScreen();
              },
            )
        );
      }
      else if (_selectedIndex == 2)
      {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return PaymentScreen();
              },
            )
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  colors: [
                    Color(0xFFFEAC5E),
                    Color(0xFFC779D0),
                    Color(0xFF4BC0C8),
                  ]
              )
          ),
          child: Body()
      ),
      bottomNavigationBar: new Theme(
        data: Theme.of(context).copyWith(
          // sets the background color of the `BottomNavigationBar`
            canvasColor: Colors.white,
            // sets the active color of the `BottomNavigationBar` if `Brightness` is light
            primaryColor: Colors.blueGrey,
            textTheme: Theme
                .of(context)
                .textTheme
                .copyWith(caption: new TextStyle(color: Colors.blueGrey))), // sets the inactive color of the `BottomNavigationBar`
        child: new BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          //backgroundColor: Colors.black54,
          unselectedItemColor: Colors.blueGrey,
          selectedItemColor: Colors.blueGrey,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Setting',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/images/shop.png'),
                color: Colors.blueGrey,
              ),
              label: 'Shop',
            ),
          /*  BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/images/np.png'),
                color: Color(0xFF000000),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.leaderboard),
              label: 'Leader Board',
            ),*/
            BottomNavigationBarItem(
              icon: Icon(Icons.payment,color: Colors.orange,),
              label: 'Payment',
            ),
          ],
        ),
      ),
    );
  }
}
