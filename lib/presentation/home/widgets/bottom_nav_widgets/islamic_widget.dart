import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mahall_manager/infrastructure/theme/colors/app_colors.dart';
import 'package:mahall_manager/infrastructure/theme/measures/app_measures.dart';
import 'package:mahall_manager/presentation/common_widgets/common_text_widget.dart';

import '../../../../infrastructure/navigation/routes.dart';
import '../../../../infrastructure/theme/strings/app_strings.dart';

class IslamicWidget extends StatelessWidget {
  const IslamicWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Material(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.QIBLA_FINDER);
                },
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/qibla.png',
                      width: 30,
                      height: 30,
                      color: AppColors.themeColor,
                    ),
                    const SizedBox(height: 10),
                    CommonTextWidget(
                      text: AppStrings.qiblaFinder,
                      fontSize: AppMeasures.mediumTextSize,
                      fontWeight: AppMeasures.smallWeight,
                      color: AppColors.themeColor,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
