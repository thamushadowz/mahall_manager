import 'package:get/get.dart';

import '../../../../presentation/payment_screen/controllers/payment_screen.controller.dart';

class PaymentScreenControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentScreenController>(
      () => PaymentScreenController(),
    );
  }
}
