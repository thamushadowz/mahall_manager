import 'package:get/get.dart';

import '../../../../presentation/death_list/controllers/death_list.controller.dart';

class DeathListControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DeathListController>(
      () => DeathListController(),
    );
  }
}
