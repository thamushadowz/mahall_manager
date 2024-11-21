import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:toastification/toastification.dart';

import '../../../infrastructure/theme/colors/app_colors.dart';
import '../../../infrastructure/theme/measures/app_measures.dart';
import '../../../presentation/common_widgets/common_text_widget.dart';

void showToast(
    {String? message,
    required String title,
    required ToastificationType type}) {
  Toastification().show(
      title: CommonTextWidget(
        text: title,
        fontSize: AppMeasures.mediumTextSize,
        color: AppColors.white,
      ),
      style: ToastificationStyle.fillColored,
      icon: Icon(type == ToastificationType.success
          ? Icons.check_circle_outline
          : Icons.error_outline),
      type: type,
      autoCloseDuration: const Duration(seconds: 4),
      showProgressBar: false);
}

String getCurrentDate() {
  final DateTime now = DateTime.now();
  String formattedDate = DateFormat('dd/MM/yyyy').format(now);
  return formattedDate;
}
