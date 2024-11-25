import 'package:get/get.dart';

import '../../../../presentation/qibla_finder/controllers/qibla_finder.controller.dart';

class QiblaFinderControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QiblaFinderController>(
      () => QiblaFinderController(),
    );
  }
}
