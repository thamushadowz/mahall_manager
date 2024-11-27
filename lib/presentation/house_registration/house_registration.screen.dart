import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import '../../domain/core/interfaces/validator.dart';
import '../../infrastructure/navigation/routes.dart';
import '../../infrastructure/theme/colors/app_colors.dart';
import '../../infrastructure/theme/strings/app_strings.dart';
import '../common_widgets/common_appbar_widget.dart';
import '../common_widgets/common_button_widget.dart';
import '../common_widgets/common_registration_success_widget.dart';
import '../common_widgets/common_text_field_shimmer_widget.dart';
import '../common_widgets/common_text_form_field.dart';
import 'controllers/house_registration.controller.dart';

class HouseRegistrationScreen extends GetView<HouseRegistrationController> {
  const HouseRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CommonAppbarWidget(
        title: controller.isEditScreen
            ? AppStrings.editHouse
            : AppStrings.houseRegistration,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Obx(
          () => controller.isHouseRegistrationSuccess.value
              ? CommonRegistrationSuccessWidget(
                  onRegAnotherTap: () {
                    controller.isHouseRegistrationSuccess.value = false;
                    controller.resetForm();
                  },
                  regAnotherTitle:
                      AppLocalizations.of(context)!.register_another,
                  regSuccessMsg:
                      AppLocalizations.of(context)!.house_reg_success,
                )
              : SizedBox.expand(
                  child: Container(
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image:
                                AssetImage('assets/images/dark_background.png'),
                            fit: BoxFit.cover)),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final keyboardHeight =
                            MediaQuery.of(context).viewInsets.bottom;

                        return Stack(
                          children: [
                            SingleChildScrollView(
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
                                  _buildSuccessOrMainWidget(context),
                                  const SizedBox(height: 20),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  _buildSuccessOrMainWidget(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.white.withOpacity(0.8)),
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Form(
        key: controller.formKey,
        child: SingleChildScrollView(
          child: _buildHouseRegWidget(context),
        ),
      ),
    );
  }

  _buildHouseRegWidget(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        //Register Number
        CommonTextFormField(
          enabled: !controller.isEditScreen,
          disabledBorderColor:
              controller.isEditScreen ? AppColors.grey : AppColors.themeColor,
          disabledLabelColor:
              controller.isEditScreen ? AppColors.grey : AppColors.themeColor,
          label: AppLocalizations.of(context)!.reg_no,
          keyboardType: TextInputType.name,
          textController: controller.regNoController,
          focusNode: controller.regNoFocusNode,
          onFieldSubmitted: (value) {
            FocusScope.of(context).requestFocus(controller.houseNameFocusNode);
          },
        ),
        const SizedBox(height: 10),
        //House Name
        CommonTextFormField(
            label: AppLocalizations.of(context)!.house_name,
            keyboardType: TextInputType.name,
            textController: controller.houseNameController,
            focusNode: controller.houseNameFocusNode,
            onFieldSubmitted: (value) {},
            validator: Validators.validateHouseName),
        const SizedBox(height: 10),
        //Place Name
        controller.isEditScreen
            ? const SizedBox.shrink()
            : Obx(
                () => controller.isDataLoading.value
                    ? const CommonTextFieldShimmerWidget()
                    : Row(
                        children: [
                          Expanded(
                            child: CommonTextFormField(
                              disabledBorderColor: AppColors.blueGrey,
                              enabled: false,
                              label: AppStrings.placeName,
                              validator: Validators.validatePlaceName,
                              keyboardType: TextInputType.none,
                              textController: controller.placeNameController,
                              focusNode: controller.placeNameFocusNode,
                              onDateTap: () {
                                Get.toNamed(Routes.SEARCH_SCREEN,
                                        arguments: controller.placeData)
                                    ?.then((onValue) {
                                  controller.placeNameController.text =
                                      onValue.name != null
                                          ? onValue.name.toString()
                                          : '';
                                  controller.placeId = onValue.id;
                                });
                              },
                            ),
                          ),
                          controller.isEditScreen
                              ? const SizedBox.shrink()
                              : Obx(
                                  () => !controller.isPlaceDataSuccessful.value
                                      ? IconButton(
                                          onPressed: () {
                                            controller.getPlaceDetailsList();
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
        const SizedBox(height: 20),
        CommonButtonWidget(
            isLoading: controller.isLoading,
            onTap: () {
              if (controller.formKey.currentState!.validate()) {
                if (controller.isEditScreen) {
                  controller.updateHouseName();
                } else {
                  controller.performHouseRegistration();
                }
              }
            },
            label: AppLocalizations.of(context)!.submit)
      ],
    );
  }
}
