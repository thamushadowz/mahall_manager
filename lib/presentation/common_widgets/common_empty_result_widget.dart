import 'package:flutter/material.dart';

import '../../infrastructure/theme/colors/app_colors.dart';
import '../../infrastructure/theme/measures/app_measures.dart';
import '../../infrastructure/theme/strings/app_strings.dart';
import 'common_text_widget.dart';

class CommonEmptyResultWidget extends StatelessWidget {
  const CommonEmptyResultWidget({
    super.key,
    this.message,
  });

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/empty_result.png',
              width: 350,
              height: 300,
              fit: BoxFit.fill,
            ),
            CommonTextWidget(
              text: message ?? AppStrings.noResults,
              fontSize: AppMeasures.bigTextSize,
              fontWeight: AppMeasures.mediumWeight,
              color: AppColors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
