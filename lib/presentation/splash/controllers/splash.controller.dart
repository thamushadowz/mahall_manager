import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:mahall_manager/infrastructure/dal/services/storage_service.dart';
import 'package:mahall_manager/infrastructure/navigation/routes.dart';

class SplashController extends GetxController {
  final StorageService _storageService = StorageService();

  FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  bool checkLogin() {
    if (_storageService.isLoggedIn()) {
      Get.offAllNamed(Routes.HOME);
      return true;
    } else {
      Get.offAllNamed(Routes.LOGIN);
      return false;
    }
  }

  void moveToScreen() async {
    final NotificationAppLaunchDetails? notificationAppLaunchDetails =
        await notificationsPlugin.getNotificationAppLaunchDetails();
    final didNotificationLaunchApp =
        notificationAppLaunchDetails?.didNotificationLaunchApp ?? false;
    if (didNotificationLaunchApp) {
      if (checkLogin()) {
        Get.offNamed(Routes.HOME);
        Get.toNamed(Routes.NOTIFICATIONS);
      }
    } else {
      checkLogin();
    }
  }
}
