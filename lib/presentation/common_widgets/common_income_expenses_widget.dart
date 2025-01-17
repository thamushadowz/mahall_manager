import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mahall_manager/presentation/common_widgets/common_text_field_shimmer_widget.dart';

import '../../domain/core/interfaces/validator.dart';
import '../../infrastructure/theme/colors/app_colors.dart';
import '../../infrastructure/theme/measures/app_measures.dart';
import '../../infrastructure/theme/strings/app_strings.dart';
import 'common_button_widget.dart';
import 'common_text_form_field.dart';
import 'common_text_widget.dart';

class CommonIncomeExpensesWidget extends StatelessWidget {
  const CommonIncomeExpensesWidget({
    super.key,
    required this.heading,
    required this.color,
    this.descriptionController,
    required this.amountController,
    this.nameController,
    this.descriptionFocusNode,
    required this.amountFocusNode,
    this.nameFocusNode,
    this.onNameTap,
    required this.onSubmitTap,
    required this.formKey,
    required this.isLoading,
    this.isDataLoading = false,
    this.type = 0,
  });

  final String heading;
  final Color color;
  final TextEditingController? descriptionController;
  final TextEditingController? nameController;
  final TextEditingController amountController;
  final FocusNode? nameFocusNode;
  final FocusNode? descriptionFocusNode;
  final FocusNode amountFocusNode;
  final Function()? onNameTap;
  final Function() onSubmitTap;
  final Key formKey;
  final RxBool isLoading;
  final bool? isDataLoading;
  final int? type; //0 - Income/Expense, 1 - Promise, 2 - Varisankhya

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            alignment: Alignment.center,
            padding: const EdgeInsets.all(20),
            child: CommonTextWidget(
              text: heading,
              fontSize: AppMeasures.bigTextSize,
              color: AppColors.white,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.white.withOpacity(0.8),
              border: Border.all(color: color),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  // Name
                  type == 1
                      ? isDataLoading!
                          ? const CommonTextFieldShimmerWidget()
                          : CommonTextFormField(
                              disabledBorderColor: AppColors.blueGrey,
                              enabled: false,
                              label: AppStrings.name,
                              textController: nameController!,
                              focusNode: nameFocusNode!,
                              onFieldSubmitted: (value) {
                                FocusScope.of(context)
                                    .requestFocus(descriptionFocusNode);
                              },
                              onDateTap: onNameTap,
                              keyboardType: TextInputType.none,
                              validator: Validators.validateName,
                            )
                      : const SizedBox.shrink(),
                  type == 1
                      ? const SizedBox(height: 10)
                      : const SizedBox.shrink(),

                  // Date
                  /*isPromises!
                        ? isLoading.value
                            ? const CommonTextFieldShimmerWidget()
                            : CommonTextFormField(
                                disabledBorderColor: AppColors.blueGrey,
                                enabled: false,
                                label: AppStrings.date,
                                keyboardType: TextInputType.none,
                                textController: dateController,
                                focusNode: dateFocusNode,
                                onFieldSubmitted: (value) {
                                  FocusScope.of(context)
                                      .requestFocus(descriptionFocusNode);
                                },
                                onDateTap: onDateTap,
                                validator: Validators.validateDate,
                              )
                        : const SizedBox.shrink(),
                    const SizedBox(height: 10),*/

                  // Description
                  type == 2
                      ? const SizedBox.shrink()
                      : CommonTextFormField(
                          label: AppStrings.description,
                          textController: descriptionController!,
                          focusNode: descriptionFocusNode!,
                          onFieldSubmitted: (value) {
                            FocusScope.of(context)
                                .requestFocus(amountFocusNode);
                          },
                          keyboardType: TextInputType.text,
                          validator: Validators.validateDescription,
                        ),
                  type == 2
                      ? const SizedBox.shrink()
                      : const SizedBox(height: 10),

                  type == 2
                      ? CommonTextWidget(
                          color: AppColors.darkRed,
                          textAlign: TextAlign.center,
                          text: AppStrings.varisankhyaUpdateConfirmation)
                      : const SizedBox.shrink(),
                  type == 2
                      ? const SizedBox(height: 20)
                      : const SizedBox.shrink(),
                  // Amount
                  CommonTextFormField(
                    label: AppStrings.amount,
                    prefixText: '₹ ',
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    keyboardType: TextInputType.number,
                    validator: Validators.validateAmount,
                    textController: amountController,
                    focusNode: amountFocusNode,
                    onFieldSubmitted: (value) {},
                  ),
                  const SizedBox(height: 20),

                  // Submit button
                  CommonButtonWidget(
                    isLoading: isLoading,
                    color: color,
                    label: AppStrings.submit,
                    onTap: onSubmitTap,
                  ),
                ],
              ),
            ),
          ),
          // Image at the bottom
        ],
      ),
    );
  }
}
