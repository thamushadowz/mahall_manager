import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mahall_manager/infrastructure/theme/measures/app_measures.dart';
import 'package:mahall_manager/presentation/common_widgets/common_appbar_widget.dart';
import 'package:mahall_manager/presentation/common_widgets/common_text_widget.dart';

import '../../domain/core/interfaces/validator.dart';
import '../../infrastructure/theme/colors/app_colors.dart';
import '../../infrastructure/theme/strings/app_strings.dart';
import '../common_widgets/common_button_widget.dart';
import '../common_widgets/common_text_form_field.dart';
import 'controllers/delete_account.controller.dart';

class DeleteAccountScreen extends GetView<DeleteAccountController> {
  const DeleteAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: CommonAppbarWidget(title: AppStrings.deleteAccount),
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

                return Stack(
                  children: [
                    SingleChildScrollView(
                      padding: EdgeInsets.only(
                        top: keyboardHeight == 0
                            ? constraints.maxHeight * 0.2
                            : 20,
                        bottom: 20,
                      ),
                      child: Column(
                        mainAxisAlignment: keyboardHeight == 0
                            ? MainAxisAlignment.center
                            : MainAxisAlignment.start,
                        children: [
                          _deleteAccountWidget(context),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  _deleteAccountWidget(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: AppColors.white),
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: Form(
          key: controller.formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CommonTextWidget(
                textAlign: TextAlign.center,
                text: AppStrings.areYouSureToDeleteAccount,
                fontSize: AppMeasures.bigTextSize,
                fontWeight: AppMeasures.mediumWeight,
                color: AppColors.darkRed,
              ),
              const SizedBox(height: 30),
              CommonTextFormField(
                textController: controller.mobileController,
                label: AppStrings.mobileNo,
                suffixIcon: Icons.phone_iphone_rounded,
                prefixText: '+91 ',
                inputFormatters: [
                  LengthLimitingTextInputFormatter(10),
                  FilteringTextInputFormatter.digitsOnly,
                ],
                keyboardType: TextInputType.number,
                validator: Validators.validateMobileNumber,
                focusNode: controller.mobileFocusNode,
                onFieldSubmitted: (value) {
                  FocusScope.of(context)
                      .requestFocus(controller.passwordFocusNode);
                },
              ),
              const SizedBox(height: 20),
              Obx(() => CommonTextFormField(
                    textController: controller.passwordController,
                    obscureText: !controller.showPassword.value,
                    maxLines: 1,
                    label: AppStrings.password,
                    suffixIcon: controller.showPassword.value
                        ? Icons.remove_red_eye_outlined
                        : Icons.visibility_off_outlined,
                    onSuffixTap: () {
                      controller.showPassword.value =
                          !controller.showPassword.value;
                    },
                    inputFormatters: [LengthLimitingTextInputFormatter(15)],
                    focusNode: controller.passwordFocusNode,
                    onFieldSubmitted: (value) {},
                    validator: Validators.validatePassword,
                  )),
              const SizedBox(height: 20),
              CommonButtonWidget(
                color: AppColors.darkRed,
                isLoading: controller.isLoading,
                label: AppStrings.delete,
                onTap: () {
                  if (controller.formKey.currentState!.validate()) {}
                },
              )
            ],
          ),
        ));
  }
}
