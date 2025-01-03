import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mahall_manager/domain/core/interfaces/utility_services.dart';
import 'package:mahall_manager/infrastructure/theme/colors/app_colors.dart';
import 'package:mahall_manager/infrastructure/theme/measures/app_measures.dart';
import 'package:mahall_manager/infrastructure/theme/strings/app_strings.dart';
import 'package:mahall_manager/presentation/common_widgets/common_appbar_widget.dart';
import 'package:mahall_manager/presentation/common_widgets/common_empty_result_widget.dart';
import 'package:mahall_manager/presentation/common_widgets/common_text_field_shimmer_widget.dart';
import 'package:mahall_manager/presentation/common_widgets/common_text_widget.dart';

import 'controllers/notifications.controller.dart';

class NotificationsScreen extends GetView<NotificationsController> {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbarWidget(title: AppStrings.notifications),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/dark_background.png'),
                fit: BoxFit.cover)),
        child: Obx(() => controller.isLoading.value
            ? _buildShimmer()
            : controller.notificationList.isEmpty
                ? CommonEmptyResultWidget(
                    message: AppStrings.noNotifications,
                  )
                : _buildListView()),
      ),
    );
  }

  ListView _buildShimmer() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return const CommonTextFieldShimmerWidget(
          height: 100,
          margin: EdgeInsets.all(5),
        );
      },
      itemCount: 15,
      shrinkWrap: true,
    );
  }

  ListView _buildListView() {
    return ListView.separated(
      separatorBuilder: (context, index) {
        return controller.notificationList[index].readStatus!
            ? Container(height: 3, color: AppColors.grey.withOpacity(0.6))
            : const SizedBox(height: 5);
      },
      padding: const EdgeInsets.only(top: 10),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            controller.updateNotification(index);
          },
          child: Material(
            borderRadius: !controller.notificationList[index].readStatus!
                ? BorderRadius.circular(10)
                : null,
            elevation: controller.notificationList[index].readStatus! ? 0 : 5,
            color: controller.notificationList[index].readStatus!
                ? Colors.grey.shade900
                : AppColors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: CommonTextWidget(
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    text: controller.notificationList[index].notification
                        .toString(),
                    fontSize: AppMeasures.mediumTextSize,
                    fontWeight: AppMeasures.mediumWeight,
                    color: controller.notificationList[index].readStatus!
                        ? AppColors.white
                        : AppColors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Icon(Icons.person, color: AppColors.grey, size: 15),
                      const SizedBox(width: 5),
                      CommonTextWidget(
                        text: controller.notificationList[index].designation
                            .toString(),
                        fontSize: AppMeasures.mediumTextSize,
                        fontWeight: AppMeasures.mediumWeight,
                        color: AppColors.grey,
                      ),
                      const Spacer(),
                      Icon(Icons.access_time_filled_rounded,
                          color: AppColors.grey, size: 15),
                      const SizedBox(width: 5),
                      CommonTextWidget(
                        text: formatDateTimeToDateAndTime(
                            controller.notificationList[index].date.toString()),
                        fontSize: AppMeasures.mediumTextSize,
                        fontWeight: AppMeasures.mediumWeight,
                        color: AppColors.grey,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
      itemCount: controller.notificationList.length,
      shrinkWrap: true,
    );
  }
}
