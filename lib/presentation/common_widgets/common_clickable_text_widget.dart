import 'package:flutter/material.dart';

import '../../infrastructure/theme/colors/app_colors.dart';
import '../../infrastructure/theme/measures/app_measures.dart';

class CommonClickableTextWidget extends StatelessWidget {
  const CommonClickableTextWidget(
      {super.key,
      required this.title,
      required this.onTap,
      this.textColor,
      this.fillColor,
      this.iconColor,
      this.fontWeight,
      this.image,
      this.fontSize,
      this.border,
      this.borderRadius,
      this.padding});

  final String title;
  final Color? textColor;
  final Color? fillColor;
  final Color? iconColor;
  final Function() onTap;
  final double? fontSize;
  final FontWeight? fontWeight;
  final String? image;
  final BoxBorder? border;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding ??
            (border == null || borderRadius == null
                ? const EdgeInsets.all(0)
                : const EdgeInsets.all(5)),
        decoration: BoxDecoration(
            border: border,
            borderRadius: borderRadius,
            color: fillColor ?? Colors.transparent),
        child: Row(
          mainAxisAlignment: border == null || borderRadius == null
              ? MainAxisAlignment.start
              : MainAxisAlignment.center,
          children: [
            image == null
                ? const SizedBox()
                : Image.asset(
                    image ?? '',
                    width: 20,
                    height: 20,
                    color: iconColor ?? AppColors.white,
                  ),
            image == null ? const SizedBox() : const SizedBox(width: 10),
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
