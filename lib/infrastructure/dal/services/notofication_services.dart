import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:mahall_manager/domain/listing/models/GetNotificationsModel.dart';
import 'package:mahall_manager/infrastructure/navigation/routes.dart';

import '../../theme/strings/app_strings.dart';

class NotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      carPlay: true,
      criticalAlert: true,
      sound: true,
      badge: true,
      provisional: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('Permission Granted');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('Provisional Permission Granted');
    } else {
      print('Permission Denied');
    }
  }

  Future<String> getDeviceToken() async {
    String? token = await messaging.getToken();
    return token!;
  }

  void initLocalNotifications(BuildContext context, RemoteMessage msg) async {
    var androidInitializationSettings =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOSInitializationSettings = const DarwinInitializationSettings();

    var initializeSettings = InitializationSettings(
        android: androidInitializationSettings, iOS: iOSInitializationSettings);

    await notificationsPlugin.initialize(initializeSettings,
        onDidReceiveNotificationResponse: (payLoad) {});
  }

  Future<void> showNotification(RemoteMessage msg) async {
    AndroidNotificationChannel androidNotificationChannel =
        AndroidNotificationChannel(Random.secure().nextInt(10000).toString(),
            AppStrings.notificationChannelName,
            description: 'Channel for notifications',
            importance: Importance.max);

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      androidNotificationChannel.id.toString(),
      androidNotificationChannel.name.toString(),
      channelDescription: 'NotificationChannel Description',
      icon: '@mipmap/ic_launcher',
      importance: Importance.high,
      ticker: 'ticker',
    );

    DarwinNotificationDetails darwinNotificationDetails =
        const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);

    Future.delayed(Duration.zero, () {
      notificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(androidNotificationChannel);
      notificationsPlugin.show(0, msg.notification!.title.toString(),
          msg.notification!.body.toString(), notificationDetails);
    });
  }

  void firebaseInit() {
    FirebaseMessaging.onMessage.listen((message) {
      print('Total Notification ::: ${message.data}');
      print(message.notification!.title.toString());
      print(message.notification!.body.toString());
      showNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('Notification clicked in background: ${message.data}');
      Get.toNamed(Routes.VIEW_NOTIFICATION, arguments: {
        'notification': NotificationsData(
            notification: message.notification?.body,
            id: int.parse(message.data['id']),
            postedBy: message.data['posted_by'],
            date: message.data['date'])
      });
    });
  }

  Future<void> handleTerminatedNotification(BuildContext context) async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      Get.toNamed(Routes.VIEW_NOTIFICATION, arguments: {
        'notification': NotificationsData(
            notification: initialMessage.notification?.body,
            id: int.parse(initialMessage.data['id']),
            postedBy: initialMessage.data['posted_by'],
            date: initialMessage.data['date'])
      });
    }
  }
}
