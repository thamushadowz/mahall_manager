import 'package:get/get.dart';

import '../../../../presentation/marriage_registration/controllers/marriage_registration.controller.dart';

class MarriageRegistrationControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MarriageRegistrationController>(
      () => MarriageRegistrationController(),
    );
  }
}
