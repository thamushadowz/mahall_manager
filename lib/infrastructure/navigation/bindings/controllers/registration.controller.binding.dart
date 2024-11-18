import 'package:get/get.dart';

import '../../../../presentation/user_registration/controllers/registration.controller.dart';

class RegistrationControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegistrationController>(
      () => RegistrationController(),
    );
  }
}
