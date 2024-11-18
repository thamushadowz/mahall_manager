import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mahall_manager/domain/core/interfaces/utilities.dart';
import 'package:mahall_manager/infrastructure/navigation/routes.dart';
import 'package:mahall_manager/infrastructure/theme/colors/app_colors.dart';
import 'package:mahall_manager/infrastructure/theme/measures/app_measures.dart';
import 'package:mahall_manager/presentation/common_widgets/common_button_widget.dart';
import 'package:mahall_manager/presentation/common_widgets/common_registration_success_widget.dart';
import 'package:mahall_manager/presentation/common_widgets/common_text_field_shimmer_widget.dart';
import 'package:mahall_manager/presentation/common_widgets/common_text_form_field.dart';
import 'package:mahall_manager/presentation/common_widgets/common_text_widget.dart';

import '../../domain/core/interfaces/validator.dart';
import '../../infrastructure/theme/strings/app_strings.dart';
import '../common_widgets/common_appbar_widget.dart';
import '../common_widgets/common_dropdown_form_field_widget.dart';
import 'controllers/registration.controller.dart';

class RegistrationScreen extends GetView<RegistrationController> {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CommonAppbarWidget(title: controller.mainHeading),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Obx(() => controller.isRegistrationSuccess.value
            ? CommonRegistrationSuccessWidget(
                onRegAnotherTap: () {
                  controller.isRegistrationSuccess.value =
                      !controller.isRegistrationSuccess.value;
                  controller.resetForm();
                },
                regAnotherTitle: AppLocalizations.of(context)!.register_another,
                regSuccessMsg: AppLocalizations.of(context)!.user_reg_success,
              )
            : Container(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: controller.formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 5),
                        //Register Number
                        CommonTextFormField(
                          label: AppLocalizations.of(context)!.reg_no,
                          enabled: !controller.isEditing,
                          disabledLabelColor: controller.isEditing
                              ? AppColors.blueGrey
                              : AppColors.themeColor,
                          disabledBorderColor: controller.isEditing
                              ? AppColors.blueGrey
                              : AppColors.themeColor,
                          keyboardType: TextInputType.name,
                          textController: controller.regNoController,
                          focusNode: controller.regNoFocusNode,
                          onFieldSubmitted: (value) {
                            FocusScope.of(context)
                                .requestFocus(controller.fNameFocusNode);
                          },
                        ),
                        const SizedBox(height: 10),
                        //First Name
                        CommonTextFormField(
                            label: AppLocalizations.of(context)!.first_name,
                            keyboardType: TextInputType.name,
                            textController: controller.fNameController,
                            focusNode: controller.fNameFocusNode,
                            onFieldSubmitted: (value) {
                              FocusScope.of(context)
                                  .requestFocus(controller.lNameFocusNode);
                            },
                            validator: Validators.validateFName),
                        const SizedBox(height: 10),
                        //Last Name
                        CommonTextFormField(
                            label: AppLocalizations.of(context)!.last_name,
                            keyboardType: TextInputType.name,
                            textController: controller.lNameController,
                            focusNode: controller.lNameFocusNode,
                            onFieldSubmitted: (value) {
                              FocusScope.of(context)
                                  .requestFocus(controller.houseNameFocusNode);
                            },
                            validator: Validators.validateLName),
                        const SizedBox(height: 10),
                        //House Name
                        Obx(
                          () => controller.isDataLoading.value
                              ? const CommonTextFieldShimmerWidget()
                              : Row(
                                  children: [
                                    Expanded(
                                      child: CommonTextFormField(
                                        disabledBorderColor: AppColors.blueGrey,
                                        disabledLabelColor: controller.isEditing
                                            ? AppColors.blueGrey
                                            : AppColors.themeColor,
                                        enabled: false,
                                        label: AppLocalizations.of(context)!
                                            .house_name,
                                        validator: Validators.validateHouseName,
                                        keyboardType: TextInputType.none,
                                        textController:
                                            controller.houseNameController,
                                        focusNode:
                                            controller.houseNameFocusNode,
                                        onFieldSubmitted: (value) {
                                          FocusScope.of(context).requestFocus(
                                              controller.placeFocusNode);
                                        },
                                        onDateTap: controller.isEditing
                                            ? () {}
                                            : () {
                                                Get.toNamed(
                                                        Routes.SEARCH_SCREEN,
                                                        arguments: controller
                                                            .houseData)
                                                    ?.then((onValue) {
                                                  controller.houseNameController
                                                      .text = onValue.name !=
                                                          null
                                                      ? onValue.name.toString()
                                                      : '';
                                                  controller.houseId =
                                                      onValue.id ?? 0;
                                                  print(
                                                      'HouseID ::: ${onValue.district}');
                                                  controller.placeController
                                                          .text =
                                                      onValue.place ?? '';
                                                  controller.stateController
                                                          .text =
                                                      onValue.state ?? '';
                                                  controller.districtController
                                                          .text =
                                                      onValue.district ?? '';
                                                });
                                              },
                                      ),
                                    ),
                                    controller.isEditing
                                        ? const SizedBox.shrink()
                                        : Obx(() => !controller
                                                .isHouseDataSuccessful.value
                                            ? IconButton(
                                                onPressed: () {
                                                  controller
                                                      .getHouseDetailsList();
                                                },
                                                icon: Icon(
                                                  Icons.refresh_rounded,
                                                  size: 30,
                                                  color: AppColors.darkRed,
                                                ),
                                              )
                                            : const SizedBox.shrink()),
                                  ],
                                ),
                        ),
                        const SizedBox(height: 10),
                        //Place
                        CommonTextFormField(
                          enabled: false,
                          disabledBorderColor: AppColors.blueGrey,
                          disabledLabelColor: AppColors.blueGrey,
                          label: AppLocalizations.of(context)!.place,
                          keyboardType: TextInputType.name,
                          textController: controller.placeController,
                          focusNode: controller.placeFocusNode,
                        ),
                        const SizedBox(height: 10),
                        //State
                        CommonTextFormField(
                          enabled: false,
                          disabledBorderColor: AppColors.blueGrey,
                          disabledLabelColor: AppColors.blueGrey,
                          label: AppLocalizations.of(context)!.state,
                          keyboardType: TextInputType.none,
                          textController: controller.stateController,
                          focusNode: controller.stateFocusNode,
                        ),
                        const SizedBox(height: 10),
                        //District
                        CommonTextFormField(
                          enabled: false,
                          disabledBorderColor: AppColors.blueGrey,
                          disabledLabelColor: AppColors.blueGrey,
                          label: AppLocalizations.of(context)!.district,
                          keyboardType: TextInputType.none,
                          textController: controller.districtController,
                          focusNode: controller.districtFocusNode,
                        ),
                        const SizedBox(height: 10),
                        //Mobile Number
                        CommonTextFormField(
                            label: AppLocalizations.of(context)!.mobileNo,
                            prefixText: '+91 ',
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(10),
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            keyboardType: TextInputType.number,
                            textController: controller.mobileNoController,
                            focusNode: controller.mobileNoFocusNode,
                            onFieldSubmitted: (value) {
                              FocusScope.of(context)
                                  .requestFocus(controller.passwordFocusNode);
                            },
                            validator: Validators.validateMobileNumber),
                        const SizedBox(height: 10),
                        //Gender
                        CommonDropdownFormFieldWidget(
                          focusNode: controller.genderFocusNode,
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              controller.genderController.text = newValue;
                            }
                          },
                          itemList: Utilities.getGenderList(context),
                          label: AppLocalizations.of(context)!.gender,
                          validator: Validators.validateGender,
                          selectedValue:
                              controller.genderController.text.isEmpty
                                  ? null
                                  : controller.genderController.text,
                        ),
                        const SizedBox(height: 10),
                        //Dob
                        CommonTextFormField(
                          disabledBorderColor: AppColors.blueGrey,
                          enabled: false,
                          label: AppLocalizations.of(context)!.dob,
                          keyboardType: TextInputType.none,
                          textController: controller.dobController,
                          focusNode: controller.dobFocusNode,
                          onFieldSubmitted: (value) {
                            FocusScope.of(context)
                                .requestFocus(controller.ageFocusNode);
                          },
                          onDateTap: () async {
                            FocusScope.of(context).requestFocus(FocusNode());
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                            );

                            if (pickedDate != null) {
                              String formattedDate =
                                  DateFormat('dd/MM/yyyy').format(pickedDate);
                              int age = controller.calculateAge(pickedDate);
                              controller.ageController.text = age.toString();
                              controller.dobController.text = formattedDate;
                            }
                          },
                        ),
                        const SizedBox(height: 10),
                        //Age
                        CommonTextFormField(
                            label: AppLocalizations.of(context)!.age,
                            enabled:
                                controller.dobController.text.trim().isNotEmpty
                                    ? false
                                    : true,
                            disabledLabelColor:
                                controller.dobController.text.trim().isNotEmpty
                                    ? AppColors.blueGrey
                                    : AppColors.themeColor,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            keyboardType: TextInputType.number,
                            textController: controller.ageController,
                            focusNode: controller.ageFocusNode,
                            onFieldSubmitted: (value) {
                              FocusScope.of(context)
                                  .requestFocus(controller.jobFocusNode);
                            },
                            validator: Validators.validateAge),
                        const SizedBox(height: 10),
                        //Job
                        CommonTextFormField(
                            label: AppLocalizations.of(context)!.job,
                            keyboardType: TextInputType.name,
                            textController: controller.jobController,
                            focusNode: controller.jobFocusNode,
                            onFieldSubmitted: (value) {
                              FocusScope.of(context)
                                  .requestFocus(controller.incomeFocusNode);
                            },
                            validator: Validators.validateJob),
                        const SizedBox(height: 10),
                        //Income
                        CommonDropdownFormFieldWidget(
                          focusNode: controller.incomeFocusNode,
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              controller.incomeController.text = newValue;
                            }
                          },
                          itemList: Utilities.getIncomeList(context),
                          label: AppLocalizations.of(context)!.income,
                          validator: Validators.validateIncome,
                          selectedValue:
                              controller.incomeController.text.isEmpty
                                  ? null
                                  : controller.incomeController.text,
                        ),
                        const SizedBox(height: 10),
                        //Pending Amount
                        CommonTextFormField(
                          label: AppLocalizations.of(context)!.pending_amt,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          keyboardType: TextInputType.number,
                          textController: controller.pendingAmountController,
                          focusNode: controller.pendingAmountFocusNode,
                          onFieldSubmitted: (value) {},
                        ),
                        const SizedBox(height: 10),
                        //Ready to donate blood?
                        Row(
                          children: [
                            Obx(
                              () => Checkbox(
                                activeColor: AppColors.themeColor,
                                value: controller.isWillingToDonate.value,
                                onChanged: (bool? value) {
                                  controller.isWillingToDonate.value =
                                      value ?? false;
                                },
                              ),
                            ),
                            CommonTextWidget(
                              text: AppStrings.willingToDonateBlood,
                              fontSize: AppMeasures.mediumTextSize,
                              fontWeight: AppMeasures.mediumWeight,
                            ),
                          ],
                        ),
                        //Blood Group
                        Obx(
                          () => controller.isWillingToDonate.value
                              ? CommonDropdownFormFieldWidget(
                                  focusNode: controller.bloodFocusNode,
                                  onChanged: (String? newValue) {
                                    if (newValue != null) {
                                      controller.bloodController.text =
                                          newValue;
                                    }
                                  },
                                  itemList: Utilities.getBloodList(context),
                                  label:
                                      AppLocalizations.of(context)!.blood_group,
                                  validator: Validators.validateBlood,
                                  selectedValue:
                                      controller.bloodController.text.isEmpty
                                          ? null
                                          : controller.bloodController.text,
                                )
                              : const SizedBox(),
                        ),
                        const SizedBox(height: 10),
                        //Is Expat
                        Row(
                          children: [
                            Obx(
                              () => Checkbox(
                                activeColor: AppColors.themeColor,
                                value: controller.isExpat.value,
                                onChanged: (bool? value) {
                                  controller.isExpat.value = value ?? false;
                                },
                              ),
                            ),
                            CommonTextWidget(
                              text: AppLocalizations.of(context)!.is_expat,
                              fontSize: AppMeasures.mediumTextSize,
                              fontWeight: AppMeasures.mediumWeight,
                            ),
                          ],
                        ),
                        //Country List
                        Obx(() => controller.isExpat.value
                            ? CommonTextFormField(
                                disabledBorderColor: AppColors.blueGrey,
                                enabled: false,
                                label: AppLocalizations.of(context)!.country,
                                validator: Validators.validateCountry,
                                keyboardType: TextInputType.none,
                                textController: controller.countryController,
                                focusNode: controller.countryFocusNode,
                                onFieldSubmitted: (value) {},
                                onDateTap: () {
                                  Get.toNamed(Routes.SEARCH_SCREEN,
                                          arguments:
                                              Utilities.getCountryList(context))
                                      ?.then((onValue) {
                                    controller.countryController.text =
                                        onValue.name != null
                                            ? onValue.name.toString()
                                            : '';
                                  });
                                },
                              )
                            : const SizedBox()),
                        const SizedBox(height: 10),
                        CommonButtonWidget(
                            isLoading: controller.isLoading,
                            onTap: () {
                              if (controller.formKey.currentState!.validate()) {
                                if (controller.isEditing) {
                                  controller.editUserDetails();
                                } else {
                                  controller.performRegistration();
                                }
                              }
                            },
                            label: AppLocalizations.of(context)!.submit)
                      ],
                    ),
                  ),
                ),
              )),
      ),
    );
  }
}
