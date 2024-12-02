import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mahall_manager/infrastructure/theme/colors/app_colors.dart';
import 'package:mahall_manager/infrastructure/theme/measures/app_measures.dart';
import 'package:mahall_manager/presentation/common_widgets/common_appbar_widget.dart';
import 'package:mahall_manager/presentation/common_widgets/common_text_widget.dart';

import 'controllers/view_notification.controller.dart';

class ViewNotificationScreen extends GetView<ViewNotificationController> {
  const ViewNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CommonAppbarWidget(title: ''),
        body: Container(
          padding: const EdgeInsets.all(20),
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/dark_background.png'),
                  fit: BoxFit.cover)),
          child: SingleChildScrollView(
            child: CommonTextWidget(
              text: controller.notification.notification.toString(),
              fontWeight: AppMeasures.mediumWeight,
              color: AppColors.white,
            ),
          ),
        ));
  }
}
