import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:mahall_manager/domain/core/interfaces/common_alert.dart';
import 'package:mahall_manager/infrastructure/theme/colors/app_colors.dart';
import 'package:mahall_manager/infrastructure/theme/measures/app_measures.dart';
import 'package:mahall_manager/presentation/common_widgets/common_appbar_widget.dart';

import '../../domain/core/interfaces/validator.dart';
import '../common_widgets/common_button_widget.dart';
import '../common_widgets/common_text_form_field.dart';
import '../common_widgets/common_text_widget.dart';
import 'controllers/committee_registration.controller.dart';

class CommitteeRegistrationScreen
    extends GetView<CommitteeRegistrationController> {
  const CommitteeRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbarWidget(
        actions: [
          controller.adminCode.value == 0
              ? const SizedBox()
              : InkWell(
                  onTap: () {
                    controller.performEdit();
                    controller.isEditMode.value = !controller.isEditMode.value;
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Obx(
                      () => Icon(controller.isEditMode.value
                          ? Icons.edit_off_outlined
                          : Icons.edit),
                    ),
                  ),
                )
        ],
        title: AppLocalizations.of(context)!.committee_registration,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Obx(
          () => Container(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: controller.formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 5),
                    //Mahall name
                    CommonTextFormField(
                        disabledLabelColor: controller.isEditMode.value
                            ? AppColors.themeColor
                            : AppColors.grey,
                        enabled: controller.isEditMode.value,
                        label: AppLocalizations.of(context)!.mahall_name,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(40),
                        ],
                        keyboardType: TextInputType.name,
                        textController: controller.mahallNameController,
                        focusNode: controller.mahallNameFocusNode,
                        onFieldSubmitted: (value) {
                          FocusScope.of(context)
                              .requestFocus(controller.mahallAddressFocusNode);
                        },
                        validator: Validators.validateMahallName),
                    const SizedBox(height: 10),
                    //Mahall address
                    CommonTextFormField(
                        disabledLabelColor: controller.isEditMode.value
                            ? AppColors.themeColor
                            : AppColors.grey,
                        enabled: controller.isEditMode.value,
                        label: AppLocalizations.of(context)!.mahall_address,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(80),
                        ],
                        keyboardType: TextInputType.name,
                        textController: controller.mahallAddressController,
                        focusNode: controller.mahallAddressFocusNode,
                        onFieldSubmitted: (value) {
                          FocusScope.of(context)
                              .requestFocus(controller.mahallPinFocusNode);
                        },
                        validator: Validators.validateMahallAddress),
                    const SizedBox(height: 10),
                    //Mahall pin
                    CommonTextFormField(
                        disabledLabelColor: controller.adminCode.value == 0
                            ? AppColors.themeColor
                            : AppColors.grey,
                        enabled: controller.adminCode.value == 0 ? true : false,
                        label: AppLocalizations.of(context)!.mahall_pin,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(6),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        keyboardType: TextInputType.number,
                        textController: controller.mahallPinController,
                        focusNode: controller.mahallPinFocusNode,
                        onFieldSubmitted: (value) {
                          FocusScope.of(context)
                              .requestFocus(controller.presidentFNameFocusNode);
                        },
                        validator: Validators.validateMahallPin),
                    const SizedBox(height: 20),
                    // President Section
                    _buildPresidentWidget(context),
                    const SizedBox(height: 20),

                    // Secretary Section
                    _buildSecretaryWidget(context),
                    const SizedBox(height: 20),

                    // Treasurer Section
                    _buildTreasurerWidget(context),

                    const SizedBox(height: 20),

                    controller.isEditMode.value
                        ? CommonButtonWidget(
                            onTap: () {
                              if (controller.formKey.currentState!.validate()) {
                                controller.performCommitteeRegistration();
                              }
                            },
                            label: AppLocalizations.of(context)!.submit)
                        : const SizedBox()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  buildCommonTextWidget(
      {required BuildContext context, required String title}) {
    return CommonTextWidget(
        text: title,
        fontSize: AppMeasures.normalTextSize,
        fontWeight: AppMeasures.normalWeight);
  }

  _commonAlertWidget({required Function() onConfirm}) {
    CommonAlert.alertDialogWidget(
        onConfirm: onConfirm,
        onCancel: () {},
        title: AppLocalizations.of(Get.context!)!.delete,
        textConfirm: AppLocalizations.of(Get.context!)!.delete,
        textCancel: AppLocalizations.of(Get.context!)!.cancel,
        middleText: AppLocalizations.of(Get.context!)!.are_you_sure_to_delete);
  }

  _buildPresidentWidget(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.blueGrey)),
      child: Column(
        children: [
          /*controller.isEditMode.value
              ? Align(
                  alignment: Alignment.topRight,
                  child: CommonDeleteButtonWidget(
                    onTap: () {
                      _commonAlertWidget(onConfirm: () {
                        controller.clearPresidentDetails();
                        Get.back();
                      });
                    },
                  ),
                )
              : const SizedBox(),*/
          Image.asset(
            'assets/images/president.png',
            width: 60,
            height: 60,
          ),
          const SizedBox(height: 5),
          buildCommonTextWidget(
              context: context, title: AppLocalizations.of(context)!.president),
          const SizedBox(height: 5),
          CommonTextFormField(
              disabledLabelColor: controller.isEditMode.value
                  ? AppColors.themeColor
                  : AppColors.grey,
              enabled: controller.isEditMode.value,
              label: AppLocalizations.of(context)!.first_name,
              inputFormatters: [
                LengthLimitingTextInputFormatter(40),
              ],
              keyboardType: TextInputType.name,
              textController: controller.presidentFNameController,
              focusNode: controller.presidentFNameFocusNode,
              onFieldSubmitted: (value) {
                FocusScope.of(context)
                    .requestFocus(controller.presidentLNameFocusNode);
              },
              validator: Validators.validateFName),
          const SizedBox(height: 10),
          CommonTextFormField(
              disabledLabelColor: controller.isEditMode.value
                  ? AppColors.themeColor
                  : AppColors.grey,
              enabled: controller.isEditMode.value,
              label: AppLocalizations.of(context)!.last_name,
              inputFormatters: [
                LengthLimitingTextInputFormatter(40),
              ],
              keyboardType: TextInputType.name,
              textController: controller.presidentLNameController,
              focusNode: controller.presidentLNameFocusNode,
              onFieldSubmitted: (value) {
                FocusScope.of(context)
                    .requestFocus(controller.presidentMobileFocusNode);
              },
              validator: Validators.validateLName),
          const SizedBox(height: 10),
          CommonTextFormField(
              disabledLabelColor: controller.isEditMode.value
                  ? AppColors.themeColor
                  : AppColors.grey,
              enabled: controller.isEditMode.value,
              label: AppLocalizations.of(context)!.mobileNo,
              prefixText: '+91 ',
              inputFormatters: [
                LengthLimitingTextInputFormatter(10),
                FilteringTextInputFormatter.digitsOnly,
              ],
              keyboardType: TextInputType.phone,
              textController: controller.presidentMobileController,
              focusNode: controller.presidentMobileFocusNode,
              onFieldSubmitted: (value) {
                FocusScope.of(context)
                    .requestFocus(controller.presidentPasswordFocusNode);
              },
              validator: Validators.validateMobileNumber),
          const SizedBox(height: 10),
          /*CommonTextFormField(
              label: AppLocalizations.of(context)!.password,
              inputFormatters: [
                LengthLimitingTextInputFormatter(40),
              ],
              keyboardType: TextInputType.visiblePassword,
              textController: controller.presidentPasswordController,
              focusNode: controller.presidentPasswordFocusNode,
              onFieldSubmitted: (value) {
                FocusScope.of(context)
                    .requestFocus(controller.secretaryFNameFocusNode);
              },
              validator: Validators.validatePassword),*/
        ],
      ),
    );
  }

  _buildSecretaryWidget(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.blueGrey)),
      child: Column(
        children: [
          /*controller.isEditMode.value
              ? Align(
                  alignment: Alignment.topRight,
                  child: CommonDeleteButtonWidget(onTap: () {
                    _commonAlertWidget(onConfirm: () {
                      controller.clearSecretaryDetails();
                      Get.back();
                    });
                  }))
              : const SizedBox(),*/
          Image.asset(
            'assets/images/secretary.png',
            width: 60,
            height: 60,
          ),
          const SizedBox(height: 5),
          buildCommonTextWidget(
              context: context, title: AppLocalizations.of(context)!.secretary),
          const SizedBox(height: 5),
          CommonTextFormField(
              disabledLabelColor: controller.isEditMode.value
                  ? AppColors.themeColor
                  : AppColors.grey,
              enabled: controller.isEditMode.value,
              label: AppLocalizations.of(context)!.first_name,
              inputFormatters: [
                LengthLimitingTextInputFormatter(40),
              ],
              keyboardType: TextInputType.name,
              textController: controller.secretaryFNameController,
              focusNode: controller.secretaryFNameFocusNode,
              onFieldSubmitted: (value) {
                FocusScope.of(context)
                    .requestFocus(controller.secretaryLNameFocusNode);
              },
              validator: Validators.validateFName),
          const SizedBox(height: 10),
          CommonTextFormField(
              disabledLabelColor: controller.isEditMode.value
                  ? AppColors.themeColor
                  : AppColors.grey,
              enabled: controller.isEditMode.value,
              label: AppLocalizations.of(context)!.last_name,
              inputFormatters: [
                LengthLimitingTextInputFormatter(40),
              ],
              keyboardType: TextInputType.name,
              textController: controller.secretaryLNameController,
              focusNode: controller.secretaryLNameFocusNode,
              onFieldSubmitted: (value) {
                FocusScope.of(context)
                    .requestFocus(controller.secretaryMobileFocusNode);
              },
              validator: Validators.validateLName),
          const SizedBox(height: 10),
          CommonTextFormField(
              disabledLabelColor: controller.isEditMode.value
                  ? AppColors.themeColor
                  : AppColors.grey,
              enabled: controller.isEditMode.value,
              label: AppLocalizations.of(context)!.mobileNo,
              prefixText: '+91 ',
              inputFormatters: [
                LengthLimitingTextInputFormatter(10),
                FilteringTextInputFormatter.digitsOnly,
              ],
              keyboardType: TextInputType.phone,
              textController: controller.secretaryMobileController,
              focusNode: controller.secretaryMobileFocusNode,
              onFieldSubmitted: (value) {
                FocusScope.of(context)
                    .requestFocus(controller.secretaryPasswordFocusNode);
              },
              validator: Validators.validateMobileNumber),
          const SizedBox(height: 10),
          /*CommonTextFormField(
              label: AppLocalizations.of(context)!.password,
              inputFormatters: [
                LengthLimitingTextInputFormatter(40),
              ],
              keyboardType: TextInputType.visiblePassword,
              textController: controller.secretaryPasswordController,
              focusNode: controller.secretaryPasswordFocusNode,
              onFieldSubmitted: (value) {
                FocusScope.of(context)
                    .requestFocus(controller.treasurerFNameFocusNode);
              },
              validator: Validators.validatePassword),*/
        ],
      ),
    );
  }

  _buildTreasurerWidget(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.blueGrey)),
      child: Column(
        children: [
          /*controller.isEditMode.value
              ? Align(
                  alignment: Alignment.topRight,
                  child: CommonDeleteButtonWidget(onTap: () {
                    _commonAlertWidget(onConfirm: () {
                      controller.clearTreasurerDetails();
                      Get.back();
                    });
                  }))
              : const SizedBox(),*/
          Image.asset(
            'assets/images/treasurer.png',
            width: 60,
            height: 60,
          ),
          const SizedBox(height: 5),
          buildCommonTextWidget(
              context: context, title: AppLocalizations.of(context)!.treasurer),
          const SizedBox(height: 5),
          CommonTextFormField(
              disabledLabelColor: controller.isEditMode.value
                  ? AppColors.themeColor
                  : AppColors.grey,
              enabled: controller.isEditMode.value,
              label: AppLocalizations.of(context)!.first_name,
              inputFormatters: [
                LengthLimitingTextInputFormatter(40),
              ],
              keyboardType: TextInputType.name,
              textController: controller.treasurerFNameController,
              focusNode: controller.treasurerFNameFocusNode,
              onFieldSubmitted: (value) {
                FocusScope.of(context)
                    .requestFocus(controller.treasurerLNameFocusNode);
              },
              validator: Validators.validateFName),
          const SizedBox(height: 10),
          CommonTextFormField(
              disabledLabelColor: controller.isEditMode.value
                  ? AppColors.themeColor
                  : AppColors.grey,
              enabled: controller.isEditMode.value,
              label: AppLocalizations.of(context)!.last_name,
              inputFormatters: [
                LengthLimitingTextInputFormatter(40),
              ],
              keyboardType: TextInputType.name,
              textController: controller.treasurerLNameController,
              focusNode: controller.treasurerLNameFocusNode,
              onFieldSubmitted: (value) {
                FocusScope.of(context)
                    .requestFocus(controller.treasurerMobileFocusNode);
              },
              validator: Validators.validateLName),
          const SizedBox(height: 10),
          CommonTextFormField(
              disabledLabelColor: controller.isEditMode.value
                  ? AppColors.themeColor
                  : AppColors.grey,
              enabled: controller.isEditMode.value,
              label: AppLocalizations.of(context)!.mobileNo,
              prefixText: '+91 ',
              inputFormatters: [
                LengthLimitingTextInputFormatter(10),
                FilteringTextInputFormatter.digitsOnly,
              ],
              keyboardType: TextInputType.phone,
              textController: controller.treasurerMobileController,
              focusNode: controller.treasurerMobileFocusNode,
              onFieldSubmitted: (value) {
                FocusScope.of(context)
                    .requestFocus(controller.treasurerPasswordFocusNode);
              },
              validator: Validators.validateMobileNumber),
          const SizedBox(height: 10),
          /*CommonTextFormField(
              label: AppLocalizations.of(context)!.password,
              inputFormatters: [
                LengthLimitingTextInputFormatter(40),
              ],
              keyboardType: TextInputType.visiblePassword,
              textController: controller.treasurerPasswordController,
              focusNode: controller.treasurerPasswordFocusNode,
              onFieldSubmitted: (value) {},
              validator: Validators.validatePassword),*/
        ],
      ),
    );
  }
}
