import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
      body: SizedBox.expand(
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/dark_background.png'),
                  fit: BoxFit.cover)),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

              return SingleChildScrollView(
                padding: EdgeInsets.only(
                  top: keyboardHeight == 0 ? constraints.maxHeight * 0.2 : 20,
                  bottom: 20,
                ),
                child: Column(
                  mainAxisAlignment: keyboardHeight == 0
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.start,
                  children: [
                    _incomeWidget(context),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  CommonIncomeExpensesWidget _incomeWidget(BuildContext context) {
    return CommonIncomeExpensesWidget(
      heading: controller.mainHeading,
      color: AppColors.themeColor,
      descriptionController: controller.descriptionController,
      amountController: controller.amountController,
      descriptionFocusNode: controller.descriptionFocusNode,
      amountFocusNode: controller.amountFocusNode,
      formKey: controller.formKey,
      onSubmitTap: () {
        if (controller.formKey.currentState!.validate()) {
          if (controller.mainHeading == AppStrings.editIncome) {
            controller.addOrEditIncome(true);
          } else {
            controller.addOrEditIncome(false);
          }
        }
      },
      isLoading: controller.isLoading,
    );
  }
}
