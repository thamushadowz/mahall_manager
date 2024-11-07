import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../infrastructure/navigation/routes.dart';
import '../../infrastructure/theme/colors/app_colors.dart';
import '../../infrastructure/theme/strings/app_strings.dart';
import '../common_widgets/common_appbar_widget.dart';
import '../common_widgets/common_income_expenses_widget.dart';
import 'controllers/add_income.controller.dart';

class AddIncomeScreen extends GetView<AddIncomeController> {
  const AddIncomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbarWidget(
        title: controller.mainHeading,
      ),
      body: CommonIncomeExpensesWidget(
        heading: controller.mainHeading,
        color: AppColors.themeColor,
        dateController: controller.dateController,
        descriptionController: controller.descriptionController,
        amountController: controller.amountController,
        dateFocusNode: controller.dateFocusNode,
        descriptionFocusNode: controller.descriptionFocusNode,
        amountFocusNode: controller.amountFocusNode,
        formKey: controller.formKey,
        onSubmitTap: () {
          if (controller.formKey.currentState!.validate()) {
            if (controller.mainHeading == AppStrings.editIncome) {
              final updatedReport = {
                'id': controller.report.id,
                'date': controller.dateController.text,
                'description': controller.descriptionController.text,
                'amount': controller.amountController.text,
                'addedBy': controller.report.addedBy,
                'incomeOrExpense': controller.report.incomeOrExpense
              };
              Get.back(result: updatedReport);
            } else {
              Get.offAllNamed(Routes.HOME);
            }
          }
        },
        onDateTap: () async {
          FocusScope.of(context).requestFocus(FocusNode());
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime(2050),
          );

          if (pickedDate != null) {
            String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);

            controller.dateController.text = formattedDate;
          }
        },
        isLoading: controller.isLoading,
      ),
    );
  }
}
