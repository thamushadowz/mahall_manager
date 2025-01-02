import 'package:get/get.dart';

import '../../../../presentation/committee_details/controllers/committee_details.controller.dart';

class CommitteeDetailsControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommitteeDetailsController>(
      () => CommitteeDetailsController(),
    );
  }
}
