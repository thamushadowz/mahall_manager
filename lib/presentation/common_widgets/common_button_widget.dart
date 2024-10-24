import 'package:flutter/material.dart';

import '../../infrastructure/theme/colors/app_colors.dart';
import '../../infrastructure/theme/measures/app_measures.dart';

class CommonButtonWidget extends StatelessWidget {
  const CommonButtonWidget({
    super.key,
    required this.onTap,
    required this.label,
    this.width,
    this.color,
    this.textColor,
    this.border,
  });

  final Function() onTap;
  final String label;
  final double? width;
  final Color? color;
  final Color? textColor;
  final Border? border;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: onTap,
      child: Container(
        width: width ?? double.infinity,
        padding: const EdgeInsets.all(15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: border ?? const Border(),
          borderRadius: BorderRadius.circular(15),
          color: color ?? AppColors.themeColor,
        ),
        child: Text(
          label,
          style: TextStyle(
              color: textColor ?? AppColors.white,
              fontSize: AppMeasures.normalTextSize,
              fontWeight: AppMeasures.normalWeight),
        ),
      ),
    );
  }
}
