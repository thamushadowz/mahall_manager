import 'package:flutter/material.dart';

import '../../infrastructure/theme/colors/app_colors.dart';
import '../../infrastructure/theme/measures/app_measures.dart';

class CommonDropdownFormFieldWidget extends StatelessWidget {
  const CommonDropdownFormFieldWidget(
      {super.key,
      required this.label,
      required this.itemList,
      this.selectedValue,
      this.validator,
      required this.onChanged,
      required this.focusNode});

  final String label;
  final String? selectedValue;
  final List<String> itemList;
  final Function(String?) onChanged;
  final String? Function(String?)? validator;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      validator: validator,
      focusNode: focusNode,
      decoration: InputDecoration(
        errorStyle: TextStyle(
          color: AppColors.darkRed,
          fontSize: 10.0,
        ),
        label: Text(
          label,
          style: TextStyle(
              color: AppColors.themeColor,
              fontSize: AppMeasures.mediumTextSize,
              fontWeight: AppMeasures.normalWeight),
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.themeColor),
            borderRadius: BorderRadius.circular(20)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.grey),
            borderRadius: BorderRadius.circular(10)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.blueGrey),
            borderRadius: BorderRadius.circular(10)),
      ),
      value: selectedValue,
      borderRadius: BorderRadius.circular(20),
      items: itemList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: TextStyle(
                color: AppColors.black,
                fontSize: AppMeasures.mediumTextSize,
                fontWeight: AppMeasures.mediumWeight),
          ),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
