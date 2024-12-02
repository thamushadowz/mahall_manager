import 'package:get/get.dart';
import 'package:mahall_manager/domain/listing/models/GetNotificationsModel.dart';

class ViewNotificationController extends GetxController {
  NotificationsData notification = NotificationsData();

  @override
  void onInit() {
    super.onInit();
    notification = Get.arguments;
  }
}
