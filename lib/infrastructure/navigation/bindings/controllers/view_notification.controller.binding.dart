import 'package:get/get.dart';

import '../../../../presentation/view_notification/controllers/view_notification.controller.dart';

class ViewNotificationControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ViewNotificationController>(
      () => ViewNotificationController(),
    );
  }
}
