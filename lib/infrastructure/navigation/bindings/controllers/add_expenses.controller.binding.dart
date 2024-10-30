import 'package:get/get.dart';

import '../../../../presentation/add_expenses/controllers/add_expenses.controller.dart';

class AddExpensesControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddExpensesController>(
      () => AddExpensesController(),
    );
  }
}
