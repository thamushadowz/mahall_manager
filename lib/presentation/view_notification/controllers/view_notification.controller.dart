import 'package:get/get.dart';
import 'package:mahall_manager/domain/listing/models/GetNotificationsModel.dart';
import 'package:mahall_manager/domain/listing/models/dua_model.dart';

class ViewNotificationController extends GetxController {
  NotificationsData notification = NotificationsData();
  DuaData dua = DuaData();
  final args = Get.arguments;

  @override
  void onInit() {
    super.onInit();
    if (args['dua'] != null) {
      dua = args['dua'];
    } else {
      notification = args['notification'];
    }
  }
}
