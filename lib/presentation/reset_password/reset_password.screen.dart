import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:mahall_manager/presentation/common_widgets/common_appbar_widget.dart';

import '../../domain/core/interfaces/validator.dart';
import '../common_widgets/common_button_widget.dart';
import '../common_widgets/common_text_form_field.dart';
import 'controllers/reset_password.controller.dart';

class ResetPasswordScreen extends GetView<ResetPasswordController> {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbarWidget(
          title: AppLocalizations.of(context)!.reset_password),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: controller.formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 5),
                  //Current Password
                  CommonTextFormField(
                      label: AppLocalizations.of(context)!.current_password,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(15),
                      ],
                      keyboardType: TextInputType.name,
                      textController: controller.currentPswdController,
                      focusNode: controller.currentPswdFocusNode,
                      onFieldSubmitted: (value) {
                        FocusScope.of(context)
                            .requestFocus(controller.newPswdFocusNode);
                      },
                      validator: Validators.validatePassword),
                  const SizedBox(height: 10),
                  //New Password
                  CommonTextFormField(
                    label: AppLocalizations.of(context)!.new_password,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(15),
                    ],
                    keyboardType: TextInputType.name,
                    textController: controller.newPswdController,
                    focusNode: controller.newPswdFocusNode,
                    onFieldSubmitted: (value) {
                      FocusScope.of(context)
                          .requestFocus(controller.confirmPswdFocusNode);
                    },
                    validator: (value) => Validators.validateNewPassword(
                        value, controller.currentPswdController.text),
                  ),
                  const SizedBox(height: 10),
                  //Confirm Password
                  CommonTextFormField(
                    label: AppLocalizations.of(context)!.confirm_password,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(15),
                    ],
                    keyboardType: TextInputType.name,
                    textController: controller.confirmPswdController,
                    focusNode: controller.confirmPswdFocusNode,
                    onFieldSubmitted: (value) {},
                    validator: (value) => Validators.validateConfirmPassword(
                        value, controller.newPswdController.text),
                  ),
                  const SizedBox(height: 10),
                  CommonButtonWidget(
                      isLoading: controller.isLoading,
                      onTap: () {
                        if (controller.formKey.currentState!.validate()) {
                          controller.performReset();
                        }
                      },
                      label: AppLocalizations.of(context)!.submit)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
