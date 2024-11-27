import 'package:get/get.dart';

import '../../../../presentation/prayer_time/controllers/prayer_time.controller.dart';

class PrayerTimeControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PrayerTimeController>(
      () => PrayerTimeController(),
    );
  }
}
