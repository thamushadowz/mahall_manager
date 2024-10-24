import 'package:get/get.dart';

import '../../../../presentation/committee_registration/controllers/committee_registration.controller.dart';

class CommitteeRegistrationControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommitteeRegistrationController>(
      () => CommitteeRegistrationController(),
    );
  }
}
