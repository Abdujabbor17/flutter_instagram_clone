import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../service/auth_service.dart';
import '../service/prefs_service.dart';
import '../utils/log_service.dart';



class SplashPage extends StatefulWidget {

  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;


  @override
  void initState() {
    super.initState();
    _initTimer();
    _initNotification();
  }

  _initTimer(){
    Timer(const Duration(seconds: 2), (){
      _callNextPage();
    });
  }

  _callNextPage(){
    if(AuthService.isLoggedIn()){
      Navigator.pushReplacementNamed(context, '/MainView');
    }else{
      Navigator.pushReplacementNamed(context, '/SignInPage');
    }
  }


  _initNotification() async{
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if(settings.authorizationStatus == AuthorizationStatus.authorized){
      Log.i('User granted permission');
    }else{
      Log.i('User declined or has not accepted permission');
    }

    _firebaseMessaging.getToken().then((value) async{
      String fcmToken = value.toString();
      await Prefs.saveFCM(fcmToken);
      String token = await Prefs.loadFCM();
      Log.i("FCM Token: ${token}");
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      String title = message.notification!.title.toString();
      String body = message.notification!.body.toString();
      Log.i(title);
      Log.i(body);
      Log.i(message.data.toString());
      //
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(193, 53, 132, 1),
                Color.fromRGBO(131, 58, 180, 1),
              ]),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            Expanded(
              child: Center(
                child: Text(
                  "Instagram",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 45,
                      fontFamily: "Billabong"),
                ),
              ),
            ),
            Text(
              "From Meta",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
