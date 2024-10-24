import 'package:get/get.dart';

import '../../../../presentation/house_registration/controllers/house_registration.controller.dart';

class HouseRegistrationControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HouseRegistrationController>(
      () => HouseRegistrationController(),
    );
  }
}
