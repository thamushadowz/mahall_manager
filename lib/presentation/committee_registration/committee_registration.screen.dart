import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:mahall_manager/infrastructure/theme/colors/app_colors.dart';
import 'package:mahall_manager/infrastructure/theme/measures/app_measures.dart';
import 'package:mahall_manager/presentation/common_widgets/common_appbar_widget.dart';
import 'package:mahall_manager/presentation/common_widgets/common_text_field_shimmer_widget.dart';
import 'package:shimmer/shimmer.dart';

import '../../domain/core/interfaces/validator.dart';
import '../../infrastructure/theme/strings/app_strings.dart';
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
      backgroundColor: AppColors.white,
      appBar: CommonAppbarWidget(
        actions: [
          controller.adminCode.value != '1'
              ? const SizedBox()
              : IconButton(
                  onPressed: () {
                    controller.isEditMode.value = !controller.isEditMode.value;
                  },
                  icon: Obx(
                    () => Icon(controller.isEditMode.value
                        ? Icons.edit_off_outlined
                        : Icons.edit),
                  ),
                ),
          const SizedBox(width: 10),
        ],
        title: AppLocalizations.of(context)!.committee_registration,
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/dark_background.png'),
                fit: BoxFit.cover)),
        child: GestureDetector(
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
                      //Mahall Section
                      _buildMahallWidget(context),
                      const SizedBox(height: 20),
                      // Admin 1 Section
                      _buildAdmin1Widget(context),
                      const SizedBox(height: 20),

                      // Admin 2 Section
                      _buildAdmin2Widget(context),
                      const SizedBox(height: 20),

                      // Admin 3 Section
                      _buildAdmin2rWidget(context),

                      const SizedBox(height: 20),

                      controller.isEditMode.value
                          ? CommonButtonWidget(
                              isLoading: controller.isLoading,
                              onTap: () {
                                if (controller.formKey.currentState!
                                    .validate()) {
                                  if (controller.adminCode.value == '0') {
                                    controller.performCommitteeRegistration();
                                  } else if (controller.adminCode.value ==
                                      '1') {
                                    controller.performEdit();
                                  }
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
      ),
    );
  }

  _buildIconShimmerWidget() {
    return Shimmer.fromColors(
      baseColor: AppColors.lightGrey.withOpacity(0.5),
      highlightColor: AppColors.white.withOpacity(0.3),
      child: Image.asset(
        'assets/images/secretary.png',
        width: 60,
        height: 60,
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

  _buildMahallWidget(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.white.withOpacity(0.8),
      ),
      child: Column(
        children: [
          //Mahall name
          controller.isLoading.value
              ? const CommonTextFieldShimmerWidget()
              : CommonTextFormField(
                  disabledLabelColor: controller.isEditMode.value
                      ? AppColors.themeColor
                      : AppColors.blueGrey,
                  enabled: controller.isEditMode.value,
                  label: AppLocalizations.of(context)!.mahall_name,
                  keyboardType: TextInputType.name,
                  textController: controller.mahallNameController,
                  focusNode: controller.mahallNameFocusNode,
                  onFieldSubmitted: (value) {
                    FocusScope.of(context)
                        .requestFocus(controller.mahallCodeFocusNode);
                  },
                  validator: Validators.validateMahallName),
          const SizedBox(height: 10),
          //Mahall code
          controller.isLoading.value
              ? const CommonTextFieldShimmerWidget()
              : CommonTextFormField(
                  inputFormatters: [
                      LengthLimitingTextInputFormatter(4),
                    ],
                  disabledLabelColor: controller.adminCode.value == '0'
                      ? AppColors.themeColor
                      : AppColors.blueGrey,
                  enabled: controller.adminCode.value == '0' ? true : false,
                  label: AppStrings.mahallCode,
                  keyboardType: TextInputType.name,
                  textController: controller.mahallCodeController,
                  focusNode: controller.mahallCodeFocusNode,
                  onFieldSubmitted: (value) {
                    FocusScope.of(context)
                        .requestFocus(controller.mahallAddressFocusNode);
                  },
                  validator: Validators.validateMahallCode),
          const SizedBox(height: 10),
          //Mahall address
          controller.isLoading.value
              ? const CommonTextFieldShimmerWidget()
              : CommonTextFormField(
                  disabledLabelColor: controller.isEditMode.value
                      ? AppColors.themeColor
                      : AppColors.blueGrey,
                  enabled: controller.isEditMode.value,
                  label: AppLocalizations.of(context)!.mahall_address,
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
          controller.isLoading.value
              ? const CommonTextFieldShimmerWidget()
              : CommonTextFormField(
                  disabledLabelColor: controller.adminCode.value == '0'
                      ? AppColors.themeColor
                      : AppColors.blueGrey,
                  enabled: controller.adminCode.value == '0' ? true : false,
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
        ],
      ),
    );
  }

  _buildAdmin1Widget(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.white.withOpacity(0.8),
      ),
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
          controller.isLoading.value
              ? _buildIconShimmerWidget()
              : Image.asset(
                  'assets/images/secretary.png',
                  width: 60,
                  height: 60,
                ),
          const SizedBox(height: 5),
          controller.isLoading.value
              ? const CommonTextFieldShimmerWidget()
              : CommonTextFormField(
                  disabledLabelColor: controller.isEditMode.value
                      ? AppColors.themeColor
                      : AppColors.blueGrey,
                  enabled: controller.isEditMode.value,
                  label: AppStrings.designation,
                  keyboardType: TextInputType.name,
                  textController: controller.presidentDesignationController,
                  focusNode: controller.presidentDesignationFocusNode,
                  onFieldSubmitted: (value) {
                    FocusScope.of(context)
                        .requestFocus(controller.presidentFNameFocusNode);
                  },
                  validator: Validators.required),
          const SizedBox(height: 10),
          controller.isLoading.value
              ? const CommonTextFieldShimmerWidget()
              : CommonTextFormField(
                  disabledLabelColor: controller.isEditMode.value
                      ? AppColors.themeColor
                      : AppColors.blueGrey,
                  enabled: controller.isEditMode.value,
                  label: AppLocalizations.of(context)!.first_name,
                  keyboardType: TextInputType.name,
                  textController: controller.presidentFNameController,
                  focusNode: controller.presidentFNameFocusNode,
                  onFieldSubmitted: (value) {
                    FocusScope.of(context)
                        .requestFocus(controller.presidentLNameFocusNode);
                  },
                  validator: Validators.validateFName),
          const SizedBox(height: 10),
          controller.isLoading.value
              ? const CommonTextFieldShimmerWidget()
              : CommonTextFormField(
                  disabledLabelColor: controller.isEditMode.value
                      ? AppColors.themeColor
                      : AppColors.blueGrey,
                  enabled: controller.isEditMode.value,
                  label: AppLocalizations.of(context)!.last_name,
                  keyboardType: TextInputType.name,
                  textController: controller.presidentLNameController,
                  focusNode: controller.presidentLNameFocusNode,
                  onFieldSubmitted: (value) {
                    FocusScope.of(context)
                        .requestFocus(controller.presidentMobileFocusNode);
                  },
                  validator: Validators.validateLName),
          const SizedBox(height: 10),
          controller.isLoading.value
              ? const CommonTextFieldShimmerWidget()
              : CommonTextFormField(
                  disabledLabelColor: controller.isEditMode.value
                      ? AppColors.themeColor
                      : AppColors.blueGrey,
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
                        .requestFocus(controller.secretaryDesignationFocusNode);
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

  _buildAdmin2Widget(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.white.withOpacity(0.8),
      ),
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
          controller.isLoading.value
              ? _buildIconShimmerWidget()
              : Image.asset(
                  'assets/images/secretary.png',
                  width: 60,
                  height: 60,
                ),
          const SizedBox(height: 5),
          controller.isLoading.value
              ? const CommonTextFieldShimmerWidget()
              : CommonTextFormField(
                  disabledLabelColor: controller.isEditMode.value
                      ? AppColors.themeColor
                      : AppColors.blueGrey,
                  enabled: controller.isEditMode.value,
                  label: AppStrings.designation,
                  keyboardType: TextInputType.name,
                  textController: controller.secretaryDesignationController,
                  focusNode: controller.secretaryDesignationFocusNode,
                  onFieldSubmitted: (value) {
                    FocusScope.of(context)
                        .requestFocus(controller.secretaryFNameFocusNode);
                  },
                  validator: Validators.required),
          const SizedBox(height: 10),
          controller.isLoading.value
              ? const CommonTextFieldShimmerWidget()
              : CommonTextFormField(
                  disabledLabelColor: controller.isEditMode.value
                      ? AppColors.themeColor
                      : AppColors.blueGrey,
                  enabled: controller.isEditMode.value,
                  label: AppLocalizations.of(context)!.first_name,
                  keyboardType: TextInputType.name,
                  textController: controller.secretaryFNameController,
                  focusNode: controller.secretaryFNameFocusNode,
                  onFieldSubmitted: (value) {
                    FocusScope.of(context)
                        .requestFocus(controller.secretaryLNameFocusNode);
                  },
                  validator: Validators.validateFName),
          const SizedBox(height: 10),
          controller.isLoading.value
              ? const CommonTextFieldShimmerWidget()
              : CommonTextFormField(
                  disabledLabelColor: controller.isEditMode.value
                      ? AppColors.themeColor
                      : AppColors.blueGrey,
                  enabled: controller.isEditMode.value,
                  label: AppLocalizations.of(context)!.last_name,
                  keyboardType: TextInputType.name,
                  textController: controller.secretaryLNameController,
                  focusNode: controller.secretaryLNameFocusNode,
                  onFieldSubmitted: (value) {
                    FocusScope.of(context)
                        .requestFocus(controller.secretaryMobileFocusNode);
                  },
                  validator: Validators.validateLName),
          const SizedBox(height: 10),
          controller.isLoading.value
              ? const CommonTextFieldShimmerWidget()
              : CommonTextFormField(
                  disabledLabelColor: controller.isEditMode.value
                      ? AppColors.themeColor
                      : AppColors.blueGrey,
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
                        .requestFocus(controller.treasurerDesignationFocusNode);
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

  _buildAdmin2rWidget(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.white.withOpacity(0.8),
      ),
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
          controller.isLoading.value
              ? _buildIconShimmerWidget()
              : Image.asset(
                  'assets/images/secretary.png',
                  width: 60,
                  height: 60,
                ),
          const SizedBox(height: 5),
          controller.isLoading.value
              ? const CommonTextFieldShimmerWidget()
              : CommonTextFormField(
                  disabledLabelColor: controller.isEditMode.value
                      ? AppColors.themeColor
                      : AppColors.blueGrey,
                  enabled: controller.isEditMode.value,
                  label: AppStrings.designation,
                  keyboardType: TextInputType.name,
                  textController: controller.treasurerDesignationController,
                  focusNode: controller.treasurerDesignationFocusNode,
                  onFieldSubmitted: (value) {
                    FocusScope.of(context)
                        .requestFocus(controller.treasurerFNameFocusNode);
                  },
                  validator: Validators.required),
          const SizedBox(height: 10),
          controller.isLoading.value
              ? const CommonTextFieldShimmerWidget()
              : CommonTextFormField(
                  disabledLabelColor: controller.isEditMode.value
                      ? AppColors.themeColor
                      : AppColors.blueGrey,
                  enabled: controller.isEditMode.value,
                  label: AppLocalizations.of(context)!.first_name,
                  keyboardType: TextInputType.name,
                  textController: controller.treasurerFNameController,
                  focusNode: controller.treasurerFNameFocusNode,
                  onFieldSubmitted: (value) {
                    FocusScope.of(context)
                        .requestFocus(controller.treasurerLNameFocusNode);
                  },
                  validator: Validators.validateFName),
          const SizedBox(height: 10),
          controller.isLoading.value
              ? const CommonTextFieldShimmerWidget()
              : CommonTextFormField(
                  disabledLabelColor: controller.isEditMode.value
                      ? AppColors.themeColor
                      : AppColors.blueGrey,
                  enabled: controller.isEditMode.value,
                  label: AppLocalizations.of(context)!.last_name,
                  keyboardType: TextInputType.name,
                  textController: controller.treasurerLNameController,
                  focusNode: controller.treasurerLNameFocusNode,
                  onFieldSubmitted: (value) {
                    FocusScope.of(context)
                        .requestFocus(controller.treasurerMobileFocusNode);
                  },
                  validator: Validators.validateLName),
          const SizedBox(height: 10),
          controller.isLoading.value
              ? const CommonTextFieldShimmerWidget()
              : CommonTextFormField(
                  disabledLabelColor: controller.isEditMode.value
                      ? AppColors.themeColor
                      : AppColors.blueGrey,
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
