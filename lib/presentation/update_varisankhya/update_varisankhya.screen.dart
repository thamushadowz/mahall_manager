import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mahall_manager/infrastructure/theme/strings/app_strings.dart';

import '../../infrastructure/theme/colors/app_colors.dart';
import '../common_widgets/common_appbar_widget.dart';
import '../common_widgets/common_income_expenses_widget.dart';
import 'controllers/update_varisankhya.controller.dart';

class UpdateVarisankhyaScreen extends GetView<UpdateVarisankhyaController> {
  const UpdateVarisankhyaScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: CommonAppbarWidget(title: AppStrings.updateVarisankhya),
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
                      _promisesWidget(context),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  _promisesWidget(BuildContext context) {
    return CommonIncomeExpensesWidget(
      type: 2,
      heading: AppStrings.updateVarisankhya,
      color: AppColors.blueGrey,
      amountController: controller.amountController,
      amountFocusNode: controller.amountFocusNode,
      formKey: controller.formKey,
      onSubmitTap: () {
        if (controller.formKey.currentState!.validate()) {
          controller.updateVarisankhya();
        }
      },
      isLoading: controller.isLoading,
    );
  }
}
