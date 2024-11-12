import 'package:get/get.dart';

import '../../../../presentation/promises/controllers/promises.controller.dart';

class PromisesControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PromisesController>(
      () => PromisesController(),
    );
  }
}
