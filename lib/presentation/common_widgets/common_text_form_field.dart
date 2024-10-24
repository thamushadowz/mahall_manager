import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../infrastructure/theme/colors/app_colors.dart';
import '../../infrastructure/theme/measures/app_measures.dart';

class CommonTextFormField extends StatelessWidget {
  const CommonTextFormField(
      {super.key,
      required this.label,
      required this.inputFormatters,
      required this.textController,
      required this.focusNode,
      this.validator,
      required this.onFieldSubmitted,
      this.suffixIcon,
      this.prefixText,
      this.obscureText,
      this.enabled,
      this.keyboardType,
      this.onTap,
      this.disabledBorderColor,
      this.disabledLabelColor,
      this.onDateTap});

  final String label;
  final IconData? suffixIcon;
  final String? prefixText;
  final Function()? onTap;
  final Function()? onDateTap;
  final String? Function(String?)? validator;
  final Function(String?) onFieldSubmitted;
  final List<TextInputFormatter> inputFormatters;
  final TextInputType? keyboardType;
  final TextEditingController textController;
  final FocusNode focusNode;
  final bool? obscureText;
  final bool? enabled;
  final Color? disabledBorderColor;
  final Color? disabledLabelColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onDateTap,
      child: TextFormField(
        focusNode: focusNode,
        onFieldSubmitted: onFieldSubmitted,
        style: TextStyle(
            color: AppColors.black,
            fontSize: AppMeasures.mediumTextSize,
            fontWeight: AppMeasures.mediumWeight),
        enabled: enabled,
        validator: validator,
        obscureText: obscureText ?? false,
        controller: textController,
        inputFormatters: inputFormatters,
        keyboardType: keyboardType ?? TextInputType.text,
        decoration: InputDecoration(
            errorStyle: TextStyle(
              color: AppColors.darkRed,
              fontSize: 10.0,
            ),
            disabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: disabledBorderColor ?? AppColors.grey),
                borderRadius: BorderRadius.circular(10)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.blueGrey),
                borderRadius: BorderRadius.circular(10)),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            label: Text(
              label,
              style: TextStyle(
                  color: disabledLabelColor ?? AppColors.themeColor,
                  fontSize: AppMeasures.mediumTextSize,
                  fontWeight: AppMeasures.normalWeight),
            ),
            prefix: Text(prefixText ?? ''),
            suffixIcon: InkWell(
              onTap: onTap,
              child: Icon(
                suffixIcon,
                color: AppColors.themeColor,
              ),
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.themeColor),
                borderRadius: BorderRadius.circular(20))),
      ),
    );
  }
}