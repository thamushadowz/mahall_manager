import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../domain/listing/models/get_reports_model.dart';
import '../../../infrastructure/theme/strings/app_strings.dart';

class AddExpensesController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final RxBool isLoading = false.obs;
  final dateController = TextEditingController();
  final descriptionController = TextEditingController();
  final amountController = TextEditingController();

  final dateFocusNode = FocusNode();
  final descriptionFocusNode = FocusNode();
  final amountFocusNode = FocusNode();
  ReportsData report = ReportsData();
  String mainHeading = AppStrings.addExpenses;

  @override
  void onInit() {
    if (Get.arguments != null) {
      mainHeading = AppStrings.editExpenses;
      report = Get.arguments;
      dateController.text = report.date ?? '';
      descriptionController.text = report.description ?? '';
      amountController.text = report.amount.toString() ?? '';
    }
    super.onInit();
  }
}
