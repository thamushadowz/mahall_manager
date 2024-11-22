import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:mahall_manager/presentation/common_widgets/common_appbar_widget.dart';

import '../../domain/core/interfaces/validator.dart';
import '../../infrastructure/theme/colors/app_colors.dart';
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
                    _buildResetPasswordWidget(context),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  GestureDetector _buildResetPasswordWidget(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Material(
          color: AppColors.white,
          elevation: 10,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            color: AppColors.white,
            margin: const EdgeInsets.all(10),
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
                        textCapitalization: TextCapitalization.none,
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
                      textCapitalization: TextCapitalization.none,
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
                      textCapitalization: TextCapitalization.none,
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
      ),
    );
  }
}
