import 'package:flutter/cupertino.dart';

import '../../infrastructure/theme/colors/app_colors.dart';
import '../../infrastructure/theme/measures/app_measures.dart';

class CommonTextWidget extends StatelessWidget {
  const CommonTextWidget(
      {super.key,
      required this.text,
      this.fontSize,
      this.fontWeight,
      this.shadows,
      this.color,
      this.textAlign,
      this.maxLines,
      this.overflow});

  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final List<Shadow>? shadows;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      maxLines: maxLines,
      textAlign: textAlign,
      text,
      style: TextStyle(
          overflow: overflow,
          shadows: shadows,
          fontSize: fontSize ?? AppMeasures.normalTextSize,
          fontWeight: fontWeight ?? AppMeasures.normalWeight,
          color: color ?? AppColors.black),
    );
  }
}
