import 'package:get/get.dart';

import '../../../../presentation/add_income/controllers/add_income.controller.dart';

class AddIncomeControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddIncomeController>(
      () => AddIncomeController(),
    );
  }
}
