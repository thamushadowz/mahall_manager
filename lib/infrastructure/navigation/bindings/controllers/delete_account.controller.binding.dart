import 'package:get/get.dart';

import '../../../../presentation/delete_account/controllers/delete_account.controller.dart';

class DeleteAccountControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DeleteAccountController>(
      () => DeleteAccountController(),
    );
  }
}
