import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import '../../domain/core/interfaces/validator.dart';
import '../common_widgets/common_appbar_widget.dart';
import '../common_widgets/common_button_widget.dart';
import '../common_widgets/common_registration_success_widget.dart';
import '../common_widgets/common_text_form_field.dart';
import 'controllers/house_registration.controller.dart';

class HouseRegistrationScreen extends GetView<HouseRegistrationController> {
  const HouseRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbarWidget(
        title: AppLocalizations.of(context)!.house_registration,
      ),
      body: Obx(() => controller.isHouseRegistrationSuccess.value
          ? CommonRegistrationSuccessWidget(
              onRegAnotherTap: () {
                controller.isHouseRegistrationSuccess.value =
                    !controller.isHouseRegistrationSuccess.value;
                controller.resetForm();
              },
              regAnotherTitle: AppLocalizations.of(context)!.register_another,
              regSuccessMsg: AppLocalizations.of(context)!.house_reg_success,
            )
          : Container(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: controller.formKey,
                child: SingleChildScrollView(
                  child: _buildTreasurerWidget(context),
                ),
              ),
            )),
    );
  }

  _buildTreasurerWidget(BuildContext context) {
    return Column(
      children: [
        CommonTextFormField(
            label: AppLocalizations.of(context)!.reg_no,
            inputFormatters: [
              LengthLimitingTextInputFormatter(40),
            ],
            keyboardType: TextInputType.name,
            textController: controller.regNoController,
            focusNode: controller.regNoFocusNode,
            onFieldSubmitted: (value) {
              FocusScope.of(context)
                  .requestFocus(controller.houseNameFocusNode);
            },
            validator: Validators.validateRegNo),
        const SizedBox(height: 10),
        CommonTextFormField(
            label: AppLocalizations.of(context)!.house_name,
            inputFormatters: [
              LengthLimitingTextInputFormatter(40),
            ],
            keyboardType: TextInputType.name,
            textController: controller.houseNameController,
            focusNode: controller.houseNameFocusNode,
            onFieldSubmitted: (value) {
              FocusScope.of(context)
                  .requestFocus(controller.houseHolderNameFocusNode);
            },
            validator: Validators.validateHouseName),
        const SizedBox(height: 10),
        CommonTextFormField(
            label: AppLocalizations.of(context)!.house_holder_name,
            inputFormatters: [
              LengthLimitingTextInputFormatter(40),
            ],
            keyboardType: TextInputType.text,
            textController: controller.houseHolderNameController,
            focusNode: controller.houseHolderNameFocusNode,
            onFieldSubmitted: (value) {},
            validator: Validators.validateHouseholderName),
        const SizedBox(height: 20),
        CommonButtonWidget(
            onTap: () {
              if (controller.formKey.currentState!.validate()) {
                controller.performHouseRegistration();
              }
            },
            label: AppLocalizations.of(context)!.submit)
      ],
    );
  }
}
