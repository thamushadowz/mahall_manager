import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../infrastructure/theme/colors/app_colors.dart';

class CommonTextFieldShimmerWidget extends StatelessWidget {
  const CommonTextFieldShimmerWidget({super.key, this.margin, this.height});

  final EdgeInsets? margin;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.zero,
      child: Shimmer.fromColors(
          baseColor: AppColors.lightGrey.withOpacity(0.5),
          highlightColor: AppColors.white.withOpacity(0.3),
          child: Container(
            height: height ?? 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: Colors.red),
          )),
    );
  }
}
