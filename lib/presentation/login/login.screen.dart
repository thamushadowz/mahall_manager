import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:mahall_manager/domain/core/interfaces/validator.dart';
import 'package:mahall_manager/infrastructure/theme/colors/app_colors.dart';
import 'package:mahall_manager/infrastructure/theme/measures/app_measures.dart';
import 'package:mahall_manager/infrastructure/theme/strings/app_strings.dart';
import 'package:mahall_manager/presentation/common_widgets/common_appbar_widget.dart';

import '../common_widgets/common_button_widget.dart';
import '../common_widgets/common_text_form_field.dart';
import 'controllers/login.controller.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final now = DateTime.now();
        if (controller.lastPressedAt == null ||
            now.difference(controller.lastPressedAt!) >
                const Duration(seconds: 2)) {
          controller.lastPressedAt = now;
          Get.showSnackbar(
            GetSnackBar(
              snackPosition: SnackPosition.TOP,
              message: AppStrings.pressBackExit,
              duration: const Duration(seconds: 2),
            ),
          );
          return false;
        }
        return true;
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          appBar:
              CommonAppbarWidget(title: AppLocalizations.of(context)!.log_in),
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
                  final keyboardHeight =
                      MediaQuery.of(context).viewInsets.bottom;

                  return SingleChildScrollView(
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
                        _loginWidget(context),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  _loginWidget(BuildContext context) {
    return Padding(
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppLocalizations.of(context)!.login_desc,
                    style: TextStyle(
                        color: AppColors.grey,
                        fontSize: AppMeasures.normalTextSize,
                        fontWeight: AppMeasures.mediumWeight),
                  ),
                ),
                const SizedBox(height: 30),
                CommonTextFormField(
                  textController: controller.mobileController,
                  label: AppLocalizations.of(context)!.mobileNo,
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
                      label: AppLocalizations.of(context)!.password,
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
                /*const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: CommonClickableTextWidget(
                    title: AppLocalizations.of(context)!.forgot_password,
                    textColor: AppColors.blue,
                    onTap: () {},
                  ),
                ),*/
                const SizedBox(height: 20),
                CommonButtonWidget(
                  isLoading: controller.isLoading,
                  label: AppLocalizations.of(context)!.login,
                  onTap: () {
                    if (controller.formKey.currentState!.validate()) {
                      controller.performLogin();
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
