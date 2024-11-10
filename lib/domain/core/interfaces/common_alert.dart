import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../infrastructure/theme/colors/app_colors.dart';
import '../../../infrastructure/theme/measures/app_measures.dart';

class CommonAlert {
  static alertDialogWidget({
    required Function() onConfirm,
    required Function() onCancel,
    required String title,
    required String textConfirm,
    required String textCancel,
    required String middleText,
  }) {
    Get.defaultDialog(
      buttonColor: AppColors.themeColor,
      confirmTextColor: AppColors.white,
      cancelTextColor: AppColors.blueGrey,
      contentPadding: const EdgeInsets.all(30),
      titlePadding: const EdgeInsets.all(10),
      title: title,
      middleTextStyle: TextStyle(
          color: AppColors.darkRed, fontSize: AppMeasures.normalTextSize),
      middleText: middleText,
      onConfirm: onConfirm,
      onCancel: onCancel,
      textConfirm: textConfirm,
      textCancel: textCancel,
    );
  }
}
