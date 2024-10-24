import 'package:flutter/cupertino.dart';

import '../../infrastructure/theme/colors/app_colors.dart';
import '../../infrastructure/theme/measures/app_measures.dart';

class CommonTextWidget extends StatelessWidget {
  const CommonTextWidget(
      {super.key,
      required this.text,
      this.fontSize,
      this.fontWeight,
      this.color});

  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: fontSize ?? AppMeasures.normalTextSize,
          fontWeight: fontWeight ?? AppMeasures.normalWeight,
          color: color ?? AppColors.black),
    );
  }
}
