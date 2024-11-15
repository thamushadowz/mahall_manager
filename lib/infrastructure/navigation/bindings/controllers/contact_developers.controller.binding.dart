import 'package:get/get.dart';

import '../../../../presentation/contact_developers/controllers/contact_developers.controller.dart';

class ContactDevelopersControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContactDevelopersController>(
      () => ContactDevelopersController(),
    );
  }
}
