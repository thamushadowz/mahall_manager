import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    this.isLoading,
  });

  final Function() onTap;
  final String label;
  final double? width;
  final Color? color;
  final Color? textColor;
  final Border? border;
  final RxBool? isLoading;

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
        child: Obx(
          () => isLoading!.value
              ? Image.asset(
                  'assets/images/spin_loader.gif',
                  width: 30,
                  height: 30,
                )
              : Text(
                  label,
                  style: TextStyle(
                      color: textColor ?? AppColors.white,
                      fontSize: AppMeasures.normalTextSize,
                      fontWeight: AppMeasures.normalWeight),
                ),
        ),
      ),
    );
  }
}
