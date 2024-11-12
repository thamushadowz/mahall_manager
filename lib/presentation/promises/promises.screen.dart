import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../infrastructure/theme/colors/app_colors.dart';
import '../../infrastructure/theme/strings/app_strings.dart';
import '../common_widgets/common_appbar_widget.dart';
import '../common_widgets/common_income_expenses_widget.dart';
import 'controllers/promises.controller.dart';

class PromisesScreen extends GetView<PromisesController> {
  const PromisesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbarWidget(title: AppStrings.promises),
      body: SizedBox.expand(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/lite_white_background.jpg'),
              fit: BoxFit.cover,
            ),
          ),
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
                    _promisesWidget(context),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  CommonIncomeExpensesWidget _promisesWidget(BuildContext context) {
    return CommonIncomeExpensesWidget(
      heading: AppStrings.promises,
      color: AppColors.orange,
      dateController: controller.dateController,
      descriptionController: controller.descriptionController,
      amountController: controller.amountController,
      dateFocusNode: controller.dateFocusNode,
      descriptionFocusNode: controller.descriptionFocusNode,
      amountFocusNode: controller.amountFocusNode,
      formKey: controller.formKey,
      onSubmitTap: () {
        if (controller.formKey.currentState!.validate()) {}
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
    );
  }
}
