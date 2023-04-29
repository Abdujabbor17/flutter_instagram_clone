

 import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

 Future<void> showLocalNotification(RemoteMessage message, BuildContext context) async {
  String title = message.notification!.title!;
  String body = message.notification!.body!;


  var android = const AndroidNotificationDetails("channelId", "channelName",
   channelDescription: "channelDescription",);
  var iOS = const IOSNotificationDetails();
  var platform = NotificationDetails(android: android, iOS: iOS);

  int id = Random().nextInt((pow(2, 31) - 1).toInt());
  await FlutterLocalNotificationsPlugin().show(id, title, body, platform);
  showToastWidget(
      Container(
       width: MediaQuery.of(context).size.width*0.7,
       alignment: Alignment.centerLeft,
       height: 40,
       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
       decoration: BoxDecoration(
           color: Colors.white,
           borderRadius: BorderRadius.circular(20)
       ),
       child: Row(
        children: [
         Image.asset("assets/images/ic_launcher.png", height: 25, width: 25,),
         const SizedBox(width: 10,),
         Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),),
           const SizedBox(height: 2,),
           Expanded(child: Text(body, style: const TextStyle(fontSize: 11),)),
          ],
         )
        ],
       ),
      ),
      context: context,
      animation: StyledToastAnimation.slideFromTop,
      reverseAnimation: StyledToastAnimation.slideToTop,
      position: StyledToastPosition.top,
      startOffset: const Offset(0.0, -3.0),
      reverseEndOffset: const Offset(0.0, -3.0),
      duration: const Duration(seconds: 4),
      //Animation duration   animDuration * 2 <= duration
      animDuration: const Duration(seconds: 1),
      curve: Curves.elasticOut,
      reverseCurve: Curves.fastOutSlowIn

  );

 }
