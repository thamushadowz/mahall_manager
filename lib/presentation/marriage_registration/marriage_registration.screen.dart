import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mahall_manager/domain/core/interfaces/validator.dart';
import 'package:mahall_manager/infrastructure/theme/strings/app_strings.dart';
import 'package:mahall_manager/presentation/common_widgets/common_appbar_widget.dart';
import 'package:mahall_manager/presentation/common_widgets/common_button_widget.dart';
import 'package:mahall_manager/presentation/common_widgets/common_text_form_field.dart';

import '../../infrastructure/navigation/routes.dart';
import '../../infrastructure/theme/colors/app_colors.dart';
import '../../infrastructure/theme/measures/app_measures.dart';
import '../common_widgets/common_text_field_shimmer_widget.dart';
import '../common_widgets/common_text_widget.dart';
import 'controllers/marriage_registration.controller.dart';

class MarriageRegistrationScreen
    extends GetView<MarriageRegistrationController> {
  const MarriageRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: CommonAppbarWidget(title: AppStrings.marriageRegistration),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Form(
              key: controller.detailsKey,
              child: Column(
                children: [
                  _buildHeadingWidget(context),
                  _buildDataWidget(context),
                  const SizedBox(height: 10),
                  _buildWitnessWidget(context),
                  const SizedBox(height: 20),
                  CommonButtonWidget(
                    onTap: () async {
                      controller.isExpanded.value = true;
                      controller.isGroomDetailsExpanded.value = true;
                      controller.isBrideDetailsExpanded.value = true;
                      controller.isWitnessDetailsExpanded.value = true;
                      await Future.delayed(const Duration(milliseconds: 50));
                      if (controller.detailsKey.currentState!.validate()) {}
                    },
                    label: AppStrings.register,
                    isLoading: false.obs,
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildHeadingWidget(BuildContext context) {
    return Obx(
      () => Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.blueGrey)),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                controller.isExpanded.value = !controller.isExpanded.value;
              },
              child: SizedBox(
                child: Row(
                  children: [
                    CommonTextWidget(text: AppStrings.mahallDetails),
                    const Spacer(),
                    Icon(controller.isExpanded.value
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded)
                  ],
                ),
              ),
            ),
            !controller.isExpanded.value
                ? controller.mahallNameController.text.trim().isEmpty ||
                        controller.mahallAddressController.text
                            .trim()
                            .isEmpty ||
                        controller.committeeNameController.text.trim().isEmpty
                    ? const SizedBox.shrink()
                    : CommonTextWidget(
                        fontSize: AppMeasures.mediumTextSize,
                        fontWeight: AppMeasures.smallWeight,
                        color: AppColors.blueGrey,
                        text:
                            '${controller.mahallNameController.text.trim()}, ${controller.committeeNameController.text.trim()}, ${controller.mahallAddressController.text.trim()}')
                : Column(
                    children: [
                      const SizedBox(height: 10),
                      CommonTextFormField(
                        textController: controller.mahallNameController,
                        focusNode: controller.mahallNameFocusNode,
                        label: AppStrings.mahallName,
                        validator: Validators.required,
                        onFieldSubmitted: (value) {
                          FocusScope.of(context)
                              .requestFocus(controller.committeeNameFocusNode);
                        },
                      ),
                      const SizedBox(height: 10),
                      CommonTextFormField(
                        textController: controller.committeeNameController,
                        focusNode: controller.committeeNameFocusNode,
                        label: AppStrings.committeeName,
                        validator: Validators.required,
                        onFieldSubmitted: (value) {
                          FocusScope.of(context)
                              .requestFocus(controller.mahallAddressFocusNode);
                        },
                      ),
                      const SizedBox(height: 10),
                      CommonTextFormField(
                        textController: controller.mahallAddressController,
                        focusNode: controller.mahallAddressFocusNode,
                        label: AppStrings.address,
                        validator: Validators.required,
                      ),
                    ],
                  )
          ],
        ),
      ),
    );
  }

  _buildDataWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        CommonTextWidget(text: AppStrings.marriageDetails),
        const SizedBox(height: 20),
        CommonTextFormField(
          textController: controller.regNoController,
          focusNode: controller.regNoFocusNode,
          label: AppStrings.registerNo,
        ),
        const SizedBox(height: 10),
        _buildGroomWidget(context),
        const SizedBox(height: 10),
        _buildBrideWidget(context),
      ],
    );
  }

  _buildGroomWidget(BuildContext context) {
    return Obx(
      () => Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.blueGrey)),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  controller.isGroomDetailsExpanded.value =
                      !controller.isGroomDetailsExpanded.value;
                },
                child: SizedBox(
                  child: Row(
                    children: [
                      CommonTextWidget(text: AppStrings.groomDetails),
                      const Spacer(),
                      Icon(controller.isGroomDetailsExpanded.value
                          ? Icons.keyboard_arrow_up_rounded
                          : Icons.keyboard_arrow_down_rounded)
                    ],
                  ),
                ),
              ),
              !controller.isGroomDetailsExpanded.value
                  ? controller.groomNameController.text.trim().isEmpty ||
                          controller.groomFatherNameController.text
                              .trim()
                              .isEmpty ||
                          controller.groomAddressController.text.trim().isEmpty
                      ? const SizedBox.shrink()
                      : CommonTextWidget(
                          fontSize: AppMeasures.mediumTextSize,
                          fontWeight: AppMeasures.smallWeight,
                          color: AppColors.blueGrey,
                          text:
                              '${controller.groomNameController.text.trim()}, (S/O) ${controller.groomFatherNameController.text.trim()},${controller.groomMotherNameController.text.trim().isNotEmpty ? '${controller.groomMotherNameController.text.trim()},' : ''} ${controller.groomPhoneController.text.trim().isNotEmpty ? '${controller.groomPhoneController.text.trim()},' : ''} ${controller.groomAddressController.text.trim()}')
                  : Column(
                      children: [
                        const SizedBox(height: 10),
                        //Groom Name
                        CommonTextFormField(
                          textController: controller.groomNameController,
                          focusNode: controller.groomNameFocusNode,
                          label: AppStrings.nameOfGroom,
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).requestFocus(
                                controller.groomFatherNameFocusNode);
                          },
                          validator: Validators.validateName,
                        ),
                        const SizedBox(height: 10),
                        //Father Name
                        CommonTextFormField(
                          textController: controller.groomFatherNameController,
                          focusNode: controller.groomFatherNameFocusNode,
                          label: AppStrings.nameOfFather,
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).requestFocus(
                                controller.groomMotherNameFocusNode);
                          },
                          validator: Validators.validateName,
                        ),
                        const SizedBox(height: 10),
                        //Mother Name
                        CommonTextFormField(
                          textController: controller.groomMotherNameController,
                          focusNode: controller.groomMotherNameFocusNode,
                          label: AppStrings.nameOfMother,
                          onFieldSubmitted: (value) {
                            FocusScope.of(context)
                                .requestFocus(controller.groomAddressFocusNode);
                          },
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Obx(
                              () => Checkbox(
                                activeColor: AppColors.themeColor,
                                value: controller.isGroomOurMahall.value,
                                onChanged: (bool? value) {
                                  controller.isGroomOurMahall.value =
                                      value ?? false;
                                  controller.groomAddressController.clear();
                                },
                              ),
                            ),
                            CommonTextWidget(
                              text: AppStrings.isFromOurMahall,
                              fontSize: AppMeasures.mediumTextSize,
                              fontWeight: AppMeasures.mediumWeight,
                            ),
                          ],
                        ),
                        //Address
                        Obx(
                          () => controller.isGroomOurMahall.value
                              ? controller.isDataLoading.value
                                  ? const CommonTextFieldShimmerWidget()
                                  : Row(
                                      children: [
                                        Expanded(
                                          child: CommonTextFormField(
                                            disabledBorderColor:
                                                AppColors.blueGrey,
                                            disabledLabelColor:
                                                AppColors.themeColor,
                                            enabled: false,
                                            label: AppStrings.address,
                                            validator:
                                                Validators.validateAddress,
                                            keyboardType: TextInputType.none,
                                            textController: controller
                                                .groomAddressController,
                                            focusNode: controller
                                                .groomAddressFocusNode,
                                            onFieldSubmitted: (value) {
                                              FocusScope.of(context)
                                                  .requestFocus(controller
                                                      .groomPhoneFocusNode);
                                            },
                                            onDateTap: () {
                                              Get.toNamed(Routes.SEARCH_SCREEN,
                                                      arguments:
                                                          controller.houseData)
                                                  ?.then((onValue) {
                                                controller
                                                    .groomAddressController
                                                    .text = onValue.name !=
                                                        null
                                                    ? '${onValue.name}, ${onValue.place}, ${onValue.district}, ${onValue.state}.'
                                                    : '';
                                                controller.groomHouseId =
                                                    onValue.id ?? 0;
                                              });
                                            },
                                          ),
                                        ),
                                        Obx(() => !controller
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
                                    )
                              : CommonTextFormField(
                                  textController:
                                      controller.groomAddressController,
                                  focusNode: controller.groomAddressFocusNode,
                                  label: AppStrings.address,
                                  onFieldSubmitted: (value) {
                                    FocusScope.of(context).requestFocus(
                                        controller.groomPhoneFocusNode);
                                  },
                                  validator: Validators.validateAddress,
                                ),
                        ),
                        const SizedBox(height: 10),
                        //Mobile Number
                        CommonTextFormField(
                          textController: controller.groomPhoneController,
                          focusNode: controller.groomPhoneFocusNode,
                          label: AppStrings.mobileNo,
                          onFieldSubmitted: (value) {
                            FocusScope.of(context)
                                .requestFocus(controller.brideNameFocusNode);
                          },
                          prefixText: '+91 ',
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          keyboardType: TextInputType.number,
                          validator: Validators.validateMobileNumber,
                        ),
                        const SizedBox(height: 10),
                      ],
                    )
            ],
          )),
    );
  }

  _buildBrideWidget(BuildContext context) {
    return Obx(
      () => Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.blueGrey)),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  controller.isBrideDetailsExpanded.value =
                      !controller.isBrideDetailsExpanded.value;
                },
                child: SizedBox(
                  child: Row(
                    children: [
                      CommonTextWidget(text: AppStrings.brideDetails),
                      const Spacer(),
                      Icon(controller.isBrideDetailsExpanded.value
                          ? Icons.keyboard_arrow_up_rounded
                          : Icons.keyboard_arrow_down_rounded)
                    ],
                  ),
                ),
              ),
              !controller.isBrideDetailsExpanded.value
                  ? controller.brideNameController.text.trim().isEmpty ||
                          controller.brideFatherNameController.text
                              .trim()
                              .isEmpty ||
                          controller.brideAddressController.text.trim().isEmpty
                      ? const SizedBox.shrink()
                      : CommonTextWidget(
                          fontSize: AppMeasures.mediumTextSize,
                          fontWeight: AppMeasures.smallWeight,
                          color: AppColors.blueGrey,
                          text:
                              '${controller.brideNameController.text.trim()}, (D/O) ${controller.brideFatherNameController.text.trim()},${controller.brideMotherNameController.text.trim().isNotEmpty ? '${controller.brideMotherNameController.text.trim()},' : ''} ${controller.bridePhoneController.text.trim().isNotEmpty ? '${controller.bridePhoneController.text.trim()},' : ''} ${controller.brideAddressController.text.trim()} ')
                  : Column(
                      children: [
                        const SizedBox(height: 10),
                        //Bride Name
                        CommonTextFormField(
                          textController: controller.brideNameController,
                          focusNode: controller.brideNameFocusNode,
                          label: AppStrings.nameOfBride,
                          validator: Validators.validateName,
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).requestFocus(
                                controller.brideFatherNameFocusNode);
                          },
                        ),
                        const SizedBox(height: 10),
                        //Father Name
                        CommonTextFormField(
                          textController: controller.brideFatherNameController,
                          focusNode: controller.brideFatherNameFocusNode,
                          label: AppStrings.nameOfFather,
                          validator: Validators.validateName,
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).requestFocus(
                                controller.brideMotherNameFocusNode);
                          },
                        ),
                        const SizedBox(height: 10),
                        //Mother Name
                        CommonTextFormField(
                          textController: controller.brideMotherNameController,
                          focusNode: controller.brideMotherNameFocusNode,
                          label: AppStrings.nameOfMother,
                          onFieldSubmitted: (value) {
                            FocusScope.of(context)
                                .requestFocus(controller.brideAddressFocusNode);
                          },
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Obx(
                              () => Checkbox(
                                activeColor: AppColors.themeColor,
                                value: controller.isBrideOurMahall.value,
                                onChanged: (bool? value) {
                                  controller.isBrideOurMahall.value =
                                      value ?? false;
                                  controller.brideAddressController.clear();
                                },
                              ),
                            ),
                            CommonTextWidget(
                              text: AppStrings.isFromOurMahall,
                              fontSize: AppMeasures.mediumTextSize,
                              fontWeight: AppMeasures.mediumWeight,
                            ),
                          ],
                        ),
                        //Address
                        Obx(
                          () => controller.isBrideOurMahall.value
                              ? controller.isDataLoading.value
                                  ? const CommonTextFieldShimmerWidget()
                                  : Row(
                                      children: [
                                        Expanded(
                                          child: CommonTextFormField(
                                            disabledBorderColor:
                                                AppColors.blueGrey,
                                            disabledLabelColor:
                                                AppColors.themeColor,
                                            enabled: false,
                                            label: AppStrings.address,
                                            validator:
                                                Validators.validateAddress,
                                            keyboardType: TextInputType.none,
                                            textController: controller
                                                .brideAddressController,
                                            focusNode: controller
                                                .brideAddressFocusNode,
                                            onFieldSubmitted: (value) {
                                              FocusScope.of(context)
                                                  .requestFocus(controller
                                                      .bridePhoneFocusNode);
                                            },
                                            onDateTap: () {
                                              Get.toNamed(Routes.SEARCH_SCREEN,
                                                      arguments:
                                                          controller.houseData)
                                                  ?.then((onValue) {
                                                controller
                                                    .brideAddressController
                                                    .text = onValue.name !=
                                                        null
                                                    ? '${onValue.name}, ${onValue.place}, ${onValue.district}, ${onValue.state}.'
                                                    : '';
                                                controller.brideHouseId =
                                                    onValue.id ?? 0;
                                              });
                                            },
                                          ),
                                        ),
                                        Obx(() => !controller
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
                                    )
                              : CommonTextFormField(
                                  textController:
                                      controller.brideAddressController,
                                  focusNode: controller.brideAddressFocusNode,
                                  label: AppStrings.address,
                                  validator: Validators.validateAddress,
                                  onFieldSubmitted: (val) {
                                    FocusScope.of(context).requestFocus(
                                        controller.bridePhoneFocusNode);
                                  },
                                ),
                        ),
                        const SizedBox(height: 10),
                        //Mobile Number
                        CommonTextFormField(
                          textController: controller.bridePhoneController,
                          focusNode: controller.bridePhoneFocusNode,
                          prefixText: '+91 ',
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          keyboardType: TextInputType.number,
                          label: AppStrings.mobileNo,
                          onFieldSubmitted: (value) {},
                          validator: Validators.validateMobileNumber,
                        ),
                        const SizedBox(height: 10),
                      ],
                    )
            ],
          )),
    );
  }

  _buildWitnessWidget(BuildContext context) {
    return Obx(
      () => Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.blueGrey)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  controller.isWitnessDetailsExpanded.value =
                      !controller.isWitnessDetailsExpanded.value;
                },
                child: SizedBox(
                  child: Row(
                    children: [
                      CommonTextWidget(text: AppStrings.witnessDetails),
                      const Spacer(),
                      Icon(controller.isWitnessDetailsExpanded.value
                          ? Icons.keyboard_arrow_up_rounded
                          : Icons.keyboard_arrow_down_rounded)
                    ],
                  ),
                ),
              ),
              !controller.isWitnessDetailsExpanded.value
                  ? controller.witness1NameController.text.trim().isEmpty ||
                          controller.witness1PhoneController.text
                              .trim()
                              .isEmpty ||
                          controller.witness2NameController.text
                              .trim()
                              .isEmpty ||
                          controller.witness2PhoneController.text.trim().isEmpty
                      ? const SizedBox.shrink()
                      : CommonTextWidget(
                          fontSize: AppMeasures.mediumTextSize,
                          fontWeight: AppMeasures.smallWeight,
                          color: AppColors.blueGrey,
                          text:
                              '${controller.witness1NameController.text.trim()} (${controller.witness1PhoneController.text.trim()}), ${controller.witness2NameController.text.trim()} (${controller.witness2PhoneController.text.trim()})')
                  : Column(
                      children: [
                        const SizedBox(height: 10),
                        //Witness1 Name
                        CommonTextFormField(
                          textController: controller.witness1NameController,
                          focusNode: controller.witness1NameFocusNode,
                          label: AppStrings.nameOfWitness1,
                          validator: Validators.validateName,
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).requestFocus(
                                controller.witness1PhoneFocusNode);
                          },
                        ),
                        const SizedBox(height: 10),
                        //Witness1 Mobile Number
                        CommonTextFormField(
                          textController: controller.witness1PhoneController,
                          focusNode: controller.witness1PhoneFocusNode,
                          label: AppStrings.mobileNo,
                          prefixText: '+91 ',
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          keyboardType: TextInputType.number,
                          validator: Validators.validateMobileNumber,
                          onFieldSubmitted: (value) {
                            FocusScope.of(context)
                                .requestFocus(controller.witness2NameFocusNode);
                          },
                        ),
                        const SizedBox(height: 10),
                        //Witness2 Name
                        CommonTextFormField(
                          textController: controller.witness2NameController,
                          focusNode: controller.witness2NameFocusNode,
                          label: AppStrings.nameOfWitness2,
                          validator: Validators.validateName,
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).requestFocus(
                                controller.witness2PhoneFocusNode);
                          },
                        ),
                        const SizedBox(height: 10),
                        //Witness2 Mobile Number
                        CommonTextFormField(
                          textController: controller.witness2PhoneController,
                          focusNode: controller.witness2PhoneFocusNode,
                          prefixText: '+91 ',
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          keyboardType: TextInputType.number,
                          label: AppStrings.mobileNo,
                          onFieldSubmitted: (value) {},
                          validator: Validators.validateMobileNumber,
                        ),
                        const SizedBox(height: 10),
                      ],
                    )
            ],
          )),
    );
  }
}
