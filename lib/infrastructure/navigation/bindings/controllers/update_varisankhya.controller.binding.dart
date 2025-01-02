import 'package:get/get.dart';

import '../../../../presentation/update_varisankhya/controllers/update_varisankhya.controller.dart';

class UpdateVarisankhyaControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateVarisankhyaController>(
      () => UpdateVarisankhyaController(),
    );
  }
}
