import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:mahall_manager/infrastructure/dal/services/storage_service.dart';
import 'package:mahall_manager/infrastructure/navigation/routes.dart';

class SplashController extends GetxController {
  final StorageService _storageService = StorageService();

  FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  checkLogin() {
    if (_storageService.isLoggedIn()) {
      Get.offAllNamed(Routes.HOME);
    } else {
      Get.offAllNamed(Routes.LOGIN);
    }
  }

  void moveToScreen() async {
    final NotificationAppLaunchDetails? notificationAppLaunchDetails =
        await notificationsPlugin.getNotificationAppLaunchDetails();
    final didNotificationLaunchApp =
        notificationAppLaunchDetails?.didNotificationLaunchApp ?? false;
    if (didNotificationLaunchApp) {
      // appStorage.writeIsFirstTime(true);
      Map<String, dynamic> payLoad = jsonDecode(
          notificationAppLaunchDetails?.notificationResponse?.payload ?? "");
      print('Payload in notification is ::: \n$payLoad');
      Get.offAllNamed(Routes.NOTIFICATIONS);
    } else {
      checkLogin();
    }
  }
}
