import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mahall_manager/infrastructure/navigation/routes.dart';

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
      appBar: CommonAppbarWidget(title: controller.mainHeading),
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

  _promisesWidget(BuildContext context) {
    return Obx(
      () => CommonIncomeExpensesWidget(
        isPromises: true,
        heading: AppStrings.promises,
        color: AppColors.orange,
        nameController: controller.nameController,
        descriptionController: controller.descriptionController,
        amountController: controller.amountController,
        nameFocusNode: controller.nameFocusNode,
        descriptionFocusNode: controller.descriptionFocusNode,
        amountFocusNode: controller.amountFocusNode,
        formKey: controller.formKey,
        onSubmitTap: () {
          if (controller.formKey.currentState!.validate()) {
            if (controller.mainHeading == AppStrings.promises) {
              controller.addPromises(false);
            } else {
              controller.addPromises(true);
            }
          }
        },
        onNameTap: controller.args != null
            ? () {}
            : () {
                Get.toNamed(Routes.SEARCH_SCREEN,
                        arguments: controller.userDetails)
                    ?.then((onValue) {
                  if (onValue.name != null) {
                    controller.nameController.text = onValue.name.toString();
                    controller.userId = onValue.id;
                    print('userId ::: ${controller.userId}');
                  }
                });
              },
        isLoading: controller.isLoading,
        isDataLoading: controller.isDataLoading.value,
      ),
    );
  }
}
