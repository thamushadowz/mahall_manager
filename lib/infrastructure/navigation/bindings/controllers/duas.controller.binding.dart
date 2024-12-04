import 'package:get/get.dart';

import '../../../../presentation/duas/controllers/duas.controller.dart';

class DuasControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DuasController>(
      () => DuasController(),
    );
  }
}
