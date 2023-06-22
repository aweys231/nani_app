// ignore_for_file: avoid_print, unused_import, unused_element, prefer_const_constructors, use_rethrow_when_possible, unused_local_variable, prefer_final_fields

import 'dart:io';
// import 'dart:ui';

import 'package:flutter/cupertino.dart';

import 'package:flutter_native_timezone/flutter_native_timezone.dart';
// import 'package:flutter_push_notifications/utils/download_util.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService with ChangeNotifier {
  
  final BehaviorSubject<String> behaviorSubject = BehaviorSubject();

  //Singleton pattern
  static final NotificationService _notificationService =   NotificationService._internal();
  factory NotificationService() {
    return _notificationService;
  }
  NotificationService._internal();

  //instance of FlutterLocalNotificationsPlugin
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  Future<void> initNotification() async {
    try {
       //Initialization Settings for Android
      final AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('@mipmap/ic_launcher');

      //Initialization Settings for iOS devices
      final DarwinInitializationSettings initializationSettingsIOS =
       DarwinInitializationSettings(
        requestSoundPermission: false,
        requestBadgePermission: false,
        requestAlertPermission: false,
      );

      //InitializationSettings for initializing settings for both platforms (Android & iOS)

      final InitializationSettings initializationSettings =
          InitializationSettings(
              android: initializationSettingsAndroid,
              iOS: initializationSettingsIOS);
      //initialize timezone package here 
    tz.initializeTimeZones();  //  

    
   
      await flutterLocalNotificationsPlugin.initialize(initializationSettings,
          );
    } catch (error) {
      print(error);
      throw error;
    }
  }

  // Future selectNotification(String payload) async {
  //   await Navigator.push(
  //     context,
  //     MaterialPageRoute<void>(builder: (context) => SecondScreen(payload)),
  //   );
  // }

 void selectNotification(String? payload) {
    if (payload != null && payload.isNotEmpty) {
      behaviorSubject.add(payload);
    }
  }
  NotificationDetails notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails('channelId', 'channelName',
          importance: Importance.max, priority: Priority.max),
      iOS: DarwinNotificationDetails(
          sound: 'default.wav',
          threadIdentifier: "thread1",
          presentAlert: true,
          presentBadge: true,
          presentSound: true
          // attachments: <IOSNotificationAttachment>[
          //   IOSNotificationAttachment(bigPicture)
          // ]
          ));

  Future<void> showNotifications(
      {int id = 0, String? title, String? body, String? payLoad}) async {
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      notificationDetails,
      payload: payLoad,
    );
  }

   Future<void> scheduleNotifications({int id = 0,
      String? title,
      String? body,
      String? payLoad,
      }) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
         id,
        title,
        body,
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
        notificationDetails,
        // ignore: deprecated_member_use
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

 Future<void> cancelNotifications() async {
    // await flutterLocalNotificationsPlugin.cancel(NOTIFICATION_ID);
  }
 
 Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}

