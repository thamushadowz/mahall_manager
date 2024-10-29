import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mahall_manager/domain/core/interfaces/utilities.dart';
import 'package:mahall_manager/infrastructure/theme/colors/app_colors.dart';
import 'package:mahall_manager/infrastructure/theme/measures/app_measures.dart';
import 'package:mahall_manager/presentation/common_widgets/common_button_widget.dart';
import 'package:mahall_manager/presentation/common_widgets/common_registration_success_widget.dart';
import 'package:mahall_manager/presentation/common_widgets/common_text_form_field.dart';
import 'package:mahall_manager/presentation/common_widgets/common_text_widget.dart';

import '../../domain/core/interfaces/validator.dart';
import '../common_widgets/common_appbar_widget.dart';
import '../common_widgets/common_dropdown_form_field_widget.dart';
import 'controllers/registration.controller.dart';

class RegistrationScreen extends GetView<RegistrationController> {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          CommonAppbarWidget(title: AppLocalizations.of(context)!.registration),
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
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(40),
                            ],
                            keyboardType: TextInputType.name,
                            textController: controller.regNoController,
                            focusNode: controller.regNoFocusNode,
                            onFieldSubmitted: (value) {
                              FocusScope.of(context)
                                  .requestFocus(controller.fNameFocusNode);
                            },
                            validator: Validators.validateRegNo),
                        const SizedBox(height: 10),
                        //First Name
                        CommonTextFormField(
                            label: AppLocalizations.of(context)!.first_name,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(40),
                            ],
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
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(40),
                            ],
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
                                  .requestFocus(controller.placeFocusNode);
                            },
                            validator: Validators.validateHouseName),
                        const SizedBox(height: 10),
                        //Place
                        CommonTextFormField(
                            label: AppLocalizations.of(context)!.place,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(40),
                            ],
                            keyboardType: TextInputType.name,
                            textController: controller.placeController,
                            focusNode: controller.placeFocusNode,
                            onFieldSubmitted: (value) {
                              FocusScope.of(context)
                                  .requestFocus(controller.districtFocusNode);
                            },
                            validator: Validators.validatePlaceName),
                        const SizedBox(height: 10),
                        //District
                        CommonDropdownFormFieldWidget(
                          focusNode: controller.districtFocusNode,
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              controller.districtController.text = newValue;
                            }
                          },
                          itemList: Utilities.getDistrictList(context),
                          label: AppLocalizations.of(context)!.district,
                          validator: Validators.validateDistrict,
                          selectedValue:
                              controller.districtController.text.isEmpty
                                  ? null
                                  : controller.districtController.text,
                        ),
                        const SizedBox(height: 10),
                        //State
                        CommonDropdownFormFieldWidget(
                          focusNode: controller.stateFocusNode,
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              controller.stateController.text = newValue;
                            }
                          },
                          itemList: Utilities.getStateList(context),
                          label: AppLocalizations.of(context)!.state,
                          validator: Validators.validateState,
                          selectedValue: controller.stateController.text.isEmpty
                              ? null
                              : controller.stateController.text,
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
                        /*//Password
                  CommonTextFormField(
                      label: AppLocalizations.of(context)!.password,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(40),
                      ],
                      keyboardType: TextInputType.name,
                      textController: controller.passwordController,
                      focusNode: controller.passwordFocusNode,
                      onFieldSubmitted: (value) {
                        FocusScope.of(context)
                            .requestFocus(controller.genderFocusNode);
                      },
                      validator: Validators.validatePassword),
                  const SizedBox(height: 10),*/
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
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(40),
                          ],
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
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(40),
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
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(40),
                            ],
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
                        //Blood Group
                        CommonDropdownFormFieldWidget(
                          focusNode: controller.bloodFocusNode,
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              controller.bloodController.text = newValue;
                            }
                          },
                          itemList: Utilities.getBloodList(context),
                          label: AppLocalizations.of(context)!.blood_group,
                          validator: Validators.validateBlood,
                          selectedValue: controller.bloodController.text.isEmpty
                              ? null
                              : controller.bloodController.text,
                        ),
                        const SizedBox(height: 10),
                        //Pending Amount
                        CommonTextFormField(
                          label: AppLocalizations.of(context)!.pending_amt,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(40),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          keyboardType: TextInputType.number,
                          textController: controller.pendingAmountController,
                          focusNode: controller.pendingAmountFocusNode,
                          onFieldSubmitted: (value) {},
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
                            ? CommonDropdownFormFieldWidget(
                                focusNode: controller.countryFocusNode,
                                onChanged: (String? newValue) {
                                  if (newValue != null) {
                                    controller.countryController.text =
                                        newValue;
                                  }
                                },
                                itemList: Utilities.getCountryList(context),
                                label: AppLocalizations.of(context)!.country,
                                validator: controller.isExpat.value
                                    ? Validators.validateCountry
                                    : null,
                                selectedValue:
                                    controller.countryController.text.isEmpty
                                        ? null
                                        : controller.countryController.text,
                              )
                            : const SizedBox()),
                        const SizedBox(height: 10),
                        CommonButtonWidget(
                            onTap: () {
                              if (controller.formKey.currentState!.validate()) {
                                controller.performRegistration();
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
