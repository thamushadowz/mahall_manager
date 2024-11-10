import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

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
    required this.dateController,
    required this.descriptionController,
    required this.amountController,
    required this.dateFocusNode,
    required this.descriptionFocusNode,
    required this.amountFocusNode,
    required this.onDateTap,
    required this.onSubmitTap,
    required this.formKey,
    required this.isLoading,
  });

  final String heading;
  final Color color;
  final TextEditingController dateController;
  final TextEditingController descriptionController;
  final TextEditingController amountController;
  final FocusNode dateFocusNode;
  final FocusNode descriptionFocusNode;
  final FocusNode amountFocusNode;
  final Function() onDateTap;
  final Function() onSubmitTap;
  final Key formKey;
  final RxBool isLoading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Padding(
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
                color: color.withOpacity(0.2),
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
                    // Date
                    CommonTextFormField(
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
                    ),
                    const SizedBox(height: 10),

                    // Description
                    CommonTextFormField(
                      label: AppStrings.description,
                      textController: descriptionController,
                      focusNode: descriptionFocusNode,
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).requestFocus(amountFocusNode);
                      },
                      keyboardType: TextInputType.text,
                      validator: Validators.validateDescription,
                    ),
                    const SizedBox(height: 10),

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
      ),
    );
  }
}
