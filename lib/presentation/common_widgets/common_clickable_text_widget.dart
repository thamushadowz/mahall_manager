import 'package:flutter/material.dart';

import '../../infrastructure/theme/colors/app_colors.dart';
import '../../infrastructure/theme/measures/app_measures.dart';

class CommonClickableTextWidget extends StatelessWidget {
  const CommonClickableTextWidget(
      {super.key,
      required this.title,
      required this.onTap,
      this.textColor,
      this.fontWeight,
      this.icon,
      this.fontSize,
      this.border,
      this.borderRadius,
      this.padding});

  final String title;
  final Color? textColor;
  final Function() onTap;
  final double? fontSize;
  final FontWeight? fontWeight;
  final IconData? icon;
  final BoxBorder? border;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: padding ??
            (border == null || borderRadius == null
                ? const EdgeInsets.all(0)
                : const EdgeInsets.all(5)),
        decoration: BoxDecoration(border: border, borderRadius: borderRadius),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon == null
                ? const SizedBox()
                : Icon(
                    icon,
                    size: 20,
                    color: AppColors.blueGrey,
                  ),
            icon == null ? const SizedBox() : const SizedBox(width: 10),
            Text(
              title,
              style: TextStyle(
                  color: textColor ?? AppColors.black,
                  fontWeight: fontWeight ?? AppMeasures.normalWeight,
                  fontSize: fontSize ?? AppMeasures.normalTextSize),
            ),
          ],
        ),
      ),
    );
  }
}
