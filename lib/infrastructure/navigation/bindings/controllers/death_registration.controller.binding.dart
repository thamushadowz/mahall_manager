import 'package:get/get.dart';

import '../../../../presentation/death_registration/controllers/death_registration.controller.dart';

class DeathRegistrationControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DeathRegistrationController>(
      () => DeathRegistrationController(),
    );
  }
}
