import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:mahall_manager/domain/core/interfaces/validator.dart';
import 'package:mahall_manager/infrastructure/theme/colors/app_colors.dart';
import 'package:mahall_manager/infrastructure/theme/measures/app_measures.dart';
import 'package:mahall_manager/presentation/common_widgets/common_appbar_widget.dart';
import 'package:mahall_manager/presentation/common_widgets/common_clickable_text_widget.dart';

import '../common_widgets/common_button_widget.dart';
import '../common_widgets/common_language_selection_widget.dart';
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
            const GetSnackBar(
              snackPosition: SnackPosition.TOP,
              message: 'Press back again to exit',
              duration: Duration(seconds: 2),
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
          body: SingleChildScrollView(
            child: Column(
              children: [
                _languageSelectionDropdown(),
                _loginWidget(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _loginWidget(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(20),
      child: Form(
        key: controller.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min, // Prevents overflow
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
                  onTap: () {
                    controller.showPassword.value =
                        !controller.showPassword.value;
                  },
                  inputFormatters: [LengthLimitingTextInputFormatter(15)],
                  focusNode: controller.passwordFocusNode,
                  onFieldSubmitted: (value) {},
                  validator: Validators.validatePassword,
                )),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: CommonClickableTextWidget(
                title: AppLocalizations.of(context)!.forgot_password,
                textColor: AppColors.blue,
                onTap: () {},
              ),
            ),
            const SizedBox(height: 20),
            CommonButtonWidget(
              label: AppLocalizations.of(context)!.login,
              onTap: () {
                if (controller.formKey.currentState!.validate()) {
                  //Get.offAllNamed(Routes.HOME);
                  controller.performLogin();
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Align _languageSelectionDropdown() {
    return Align(
      alignment: Alignment.topRight,
      child: Obx(
        () => CommonLanguageSelectionWidget(
          selectedLanguage: controller.selectedLanguage.value,
          onChanged: (String? newValue) {
            if (newValue != null) {
              controller.selectedLanguage.value = newValue;
              controller.changeLanguage(newValue);
            }
          },
        ),
      ),
    );
  }
}
