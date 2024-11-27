import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mahall_manager/infrastructure/theme/colors/app_colors.dart';
import 'package:mahall_manager/presentation/common_widgets/common_appbar_widget.dart';
import 'package:mahall_manager/presentation/common_widgets/common_button_widget.dart';
import 'package:mahall_manager/presentation/common_widgets/common_text_form_field.dart';

import '../../domain/core/interfaces/validator.dart';
import '../../infrastructure/navigation/routes.dart';
import '../../infrastructure/theme/strings/app_strings.dart';
import '../common_widgets/common_text_field_shimmer_widget.dart';
import 'controllers/death_registration.controller.dart';

class DeathRegistrationScreen extends GetView<DeathRegistrationController> {
  const DeathRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: CommonAppbarWidget(title: AppStrings.deathRegistration),
        body: SizedBox.expand(
          child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/dark_background.png'),
                    fit: BoxFit.cover)),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

                return SingleChildScrollView(
                  padding: EdgeInsets.only(
                    top: keyboardHeight == 0 ? constraints.maxHeight * 0.2 : 20,
                    bottom: 20,
                  ),
                  child: Column(
                    mainAxisAlignment: keyboardHeight == 0
                        ? MainAxisAlignment.center
                        : MainAxisAlignment.start,
                    children: [
                      _buildDeceasedWidget(context),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Padding _buildDeceasedWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Material(
        color: AppColors.white.withOpacity(0.8),
        elevation: 10,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonTextFormField(
                  textController: controller.deceasedNameController,
                  label: AppStrings.nameOfDeceased,
                  focusNode: controller.deceasedNameFocusNode,
                  onFieldSubmitted: (val) {
                    FocusScope.of(context)
                        .requestFocus(controller.houseDetailsFocusNode);
                  },
                  validator: Validators.validateName,
                ),
                const SizedBox(height: 10),
                Obx(
                  () => controller.isDataLoading.value
                      ? const CommonTextFieldShimmerWidget()
                      : Row(
                          children: [
                            Expanded(
                              child: CommonTextFormField(
                                disabledBorderColor: AppColors.blueGrey,
                                enabled: false,
                                label: AppStrings.houseNameAndPlace,
                                textController:
                                    controller.houseDetailsController,
                                focusNode: controller.houseDetailsFocusNode,
                                onDateTap: () {
                                  Get.toNamed(Routes.SEARCH_SCREEN,
                                          arguments: controller.houseDetails)
                                      ?.then((onValue) {
                                    if (onValue.name != null) {
                                      controller.houseDetailsController.text =
                                          '${onValue.name}, ${onValue.place}';
                                      controller.houseId = onValue.id;
                                      print(
                                          'houseId ::: ${controller.houseId}');
                                    }
                                  });
                                },
                                keyboardType: TextInputType.none,
                                validator: Validators.validateHouseName,
                              ),
                            ),
                            Obx(() => !controller.isHouseDataSuccessful.value
                                ? IconButton(
                                    onPressed: () {
                                      controller.getHouseDetailsList();
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
                    onTap: () {
                      if (controller.formKey.currentState!.validate()) {
                        controller.registerDeath();
                      }
                    },
                    label: AppStrings.submit,
                    isLoading: controller.isLoading),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
