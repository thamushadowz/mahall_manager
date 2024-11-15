import 'package:flutter/cupertino.dart';

import '../../infrastructure/theme/colors/app_colors.dart';
import '../../infrastructure/theme/measures/app_measures.dart';
import 'common_text_widget.dart';

class CommonEmptyResultWidget extends StatelessWidget {
  const CommonEmptyResultWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              'assets/images/empty_result.png',
              width: 350,
              height: 300,
              fit: BoxFit.fill,
            ),
            CommonTextWidget(
              text: 'No results',
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
