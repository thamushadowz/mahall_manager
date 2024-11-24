import 'package:get/get.dart';

import '../../../../presentation/reports_list/controllers/reports_list.controller.dart';

class ReportsListControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReportsListController>(
      () => ReportsListController(),
    );
  }
}
