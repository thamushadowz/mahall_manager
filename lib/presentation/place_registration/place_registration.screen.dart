import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import '../../domain/core/interfaces/utilities.dart';
import '../../domain/core/interfaces/validator.dart';
import '../../infrastructure/navigation/routes.dart';
import '../../infrastructure/theme/colors/app_colors.dart';
import '../../infrastructure/theme/strings/app_strings.dart';
import '../common_widgets/common_appbar_widget.dart';
import '../common_widgets/common_button_widget.dart';
import '../common_widgets/common_registration_success_widget.dart';
import '../common_widgets/common_text_form_field.dart';
import 'controllers/place_registration.controller.dart';

class PlaceRegistrationScreen extends GetView<PlaceRegistrationController> {
  const PlaceRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbarWidget(
        title: AppStrings.placeRegistration,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Obx(
          () => controller.isPlaceRegistrationSuccess.value
              ? CommonRegistrationSuccessWidget(
                  onRegAnotherTap: () {
                    controller.isPlaceRegistrationSuccess.value =
                        !controller.isPlaceRegistrationSuccess.value;
                    controller.resetForm();
                  },
                  regAnotherTitle:
                      AppLocalizations.of(context)!.register_another,
                  regSuccessMsg: AppStrings.placeRegistrationSuccess,
                )
              : SizedBox.expand(
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/images/lite_white_background.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
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
          borderRadius: BorderRadius.circular(20), color: AppColors.white),
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Form(
        key: controller.formKey,
        child: SingleChildScrollView(
          child: _buildPlaceRegWidget(context),
        ),
      ),
    );
  }

  _buildPlaceRegWidget(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        //Place Code
        CommonTextFormField(
            label: AppStrings.placeCode,
            keyboardType: TextInputType.name,
            textController: controller.placeCodeController,
            focusNode: controller.placeCodeFocusNode,
            onFieldSubmitted: (value) {
              FocusScope.of(context)
                  .requestFocus(controller.placeNameFocusNode);
            },
            validator: Validators.validatePlaceCode),
        const SizedBox(height: 10),
        //Place Name
        CommonTextFormField(
            label: AppStrings.placeName,
            keyboardType: TextInputType.name,
            textController: controller.placeNameController,
            focusNode: controller.placeNameFocusNode,
            onFieldSubmitted: (value) {},
            validator: Validators.validatePlaceName),
        const SizedBox(height: 10),
        //State
        CommonTextFormField(
          disabledBorderColor: AppColors.blueGrey,
          enabled: false,
          label: AppLocalizations.of(context)!.state,
          validator: Validators.validateState,
          keyboardType: TextInputType.none,
          textController: controller.stateController,
          focusNode: controller.stateFocusNode,
          onFieldSubmitted: (value) {
            FocusScope.of(context).requestFocus(controller.districtFocusNode);
          },
          onDateTap: () {
            controller.districtController.clear();
            Get.toNamed(Routes.SEARCH_SCREEN,
                    arguments: Utilities.getStateList(context))
                ?.then((onValue) {
              controller.selectedState.value = onValue.id ?? 0;
              controller.stateController.text =
                  onValue.name != null ? onValue.name.toString() : '';
            });
          },
        ),
        const SizedBox(height: 10),
        //District
        Obx(
          () => CommonTextFormField(
            disabledBorderColor: AppColors.blueGrey,
            enabled: false,
            disabledLabelColor: controller.selectedState.value == 0
                ? AppColors.blueGrey
                : AppColors.themeColor,
            label: AppLocalizations.of(context)!.district,
            validator: Validators.validateDistrict,
            keyboardType: TextInputType.none,
            textController: controller.districtController,
            focusNode: controller.districtFocusNode,
            onDateTap: controller.selectedState.value == 0
                ? () {}
                : () {
                    Get.toNamed(Routes.SEARCH_SCREEN,
                            arguments: Utilities.getDistrictList(
                                context, controller.selectedState.value))
                        ?.then((onValue) {
                      controller.districtController.text =
                          onValue.name != null ? onValue.name.toString() : '';
                    });
                  },
          ),
        ),
        const SizedBox(height: 20),
        CommonButtonWidget(
            isLoading: controller.isLoading,
            onTap: () {
              if (controller.formKey.currentState!.validate()) {
                controller.performPlaceRegistration();
              }
            },
            label: AppLocalizations.of(context)!.submit)
      ],
    );
  }
}
