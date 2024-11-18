import 'package:get/get.dart';

import '../../../../presentation/place_registration/controllers/place_registration.controller.dart';

class PlaceRegistrationControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PlaceRegistrationController>(
      () => PlaceRegistrationController(),
    );
  }
}
