import 'package:get/get.dart';

import '../../../../presentation/reset_password/controllers/reset_password.controller.dart';

class ResetPasswordControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ResetPasswordController>(
      () => ResetPasswordController(),
    );
  }
}
