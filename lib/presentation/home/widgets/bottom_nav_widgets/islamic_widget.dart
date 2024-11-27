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
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/dark_background.png'),
              fit: BoxFit.cover)),
      padding: const EdgeInsets.all(20.0),
      child: Wrap(
        spacing: 20,
        runSpacing: 20,
        children: [
          _buildItemWidget(
              onTap: () {
                Get.toNamed(Routes.QIBLA_FINDER);
              },
              icon: 'assets/images/qibla.png',
              text: AppStrings.qiblaFinder),
          _buildItemWidget(
              onTap: () {
                Get.toNamed(Routes.PRAYER_TIME);
              },
              icon: 'assets/images/namaz.png',
              text: AppStrings.prayerTime),
          _buildItemWidget(
              onTap: () {},
              icon: 'assets/images/dua.png',
              text: AppStrings.dua),
          _buildItemWidget(
              onTap: () {},
              icon: 'assets/images/dasbiha.png',
              text: AppStrings.azkar),
        ],
      ),
    );
  }

  _buildItemWidget(
      {required Function() onTap, required String icon, required String text}) {
    return GestureDetector(
      onTap: onTap,
      child: Material(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
        elevation: 4,
        child: Container(
          width: 110,
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Image.asset(
                icon,
                width: 40,
                height: 40,
                color: AppColors.themeColor,
              ),
              const SizedBox(height: 10),
              CommonTextWidget(
                text: text,
                fontSize: AppMeasures.mediumTextSize,
                fontWeight: AppMeasures.smallWeight,
                color: AppColors.themeColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
