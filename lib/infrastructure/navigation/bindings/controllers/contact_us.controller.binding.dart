import 'package:get/get.dart';

import '../../../../presentation/contact_us/controllers/contact_us.controller.dart';

class ContactUsControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContactUsController>(
      () => ContactUsController(),
    );
  }
}
