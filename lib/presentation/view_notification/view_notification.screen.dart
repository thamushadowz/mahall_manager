import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mahall_manager/infrastructure/theme/colors/app_colors.dart';
import 'package:mahall_manager/infrastructure/theme/measures/app_measures.dart';
import 'package:mahall_manager/presentation/common_widgets/common_appbar_widget.dart';
import 'package:mahall_manager/presentation/common_widgets/common_text_widget.dart';

import '../../infrastructure/theme/strings/app_strings.dart';
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
            child: controller.args['dua'] != null
                ? _buildDuaDetails()
                : _buildNotificationDetails(),
          ),
        ));
  }

  _buildNotificationDetails() {
    return Column(
      children: [
        CommonTextWidget(
          text: controller.notification.notification.toString(),
          fontWeight: AppMeasures.mediumWeight,
          color: AppColors.white,
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Icon(Icons.person, color: AppColors.white, size: 15),
            const SizedBox(width: 5),
            CommonTextWidget(
              text: controller.notification.postedBy.toString(),
              fontWeight: AppMeasures.mediumWeight,
              fontSize: AppMeasures.mediumTextSize,
              color: AppColors.white,
            ),
            const Spacer(),
            Icon(Icons.access_time_filled_rounded,
                color: AppColors.white, size: 15),
            const SizedBox(width: 5),
            CommonTextWidget(
              text: controller.notification.date.toString(),
              fontWeight: AppMeasures.mediumWeight,
              fontSize: AppMeasures.mediumTextSize,
              color: AppColors.white,
            ),
          ],
        )
      ],
    );
  }

  _buildDuaDetails() {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: const DecorationImage(
                image: AssetImage(
                  'assets/images/pattern_background.jpg',
                ),
                colorFilter: ColorFilter.linearToSrgbGamma(),
                fit: BoxFit.cover,
              )),
          child: CommonTextWidget(
            textAlign: TextAlign.end,
            text: controller.dua.arabic.toString(),
            fontWeight: AppMeasures.mediumWeight,
            fontSize: AppMeasures.textSize25,
            color: AppColors.black,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10),
          width: double.infinity,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: const DecorationImage(
                image: AssetImage('assets/images/pattern_background.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.linearToSrgbGamma(),
              )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonTextWidget(
                text: AppStrings.transliteration,
                fontWeight: AppMeasures.normalWeight,
                color: AppColors.black,
              ),
              const SizedBox(height: 10),
              CommonTextWidget(
                text: controller.dua.transliteration.toString(),
                fontWeight: AppMeasures.mediumWeight,
                color: AppColors.black,
              ),
              Divider(
                color: AppColors.grey.withOpacity(0.7),
                thickness: 3,
                endIndent: 50,
                indent: 50,
                height: 40,
              ),
              CommonTextWidget(
                text: AppStrings.translation,
                fontWeight: AppMeasures.normalWeight,
                color: AppColors.black,
              ),
              const SizedBox(height: 10),
              CommonTextWidget(
                text: controller.dua.translation.toString(),
                fontWeight: AppMeasures.mediumWeight,
                color: AppColors.black,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
