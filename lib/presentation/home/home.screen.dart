import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mahall_manager/infrastructure/theme/colors/app_colors.dart';
import 'package:mahall_manager/infrastructure/theme/measures/app_measures.dart';
import 'package:mahall_manager/presentation/common_widgets/common_text_widget.dart';
import 'package:mahall_manager/presentation/home/widgets/bottom_nav_widget.dart';
import 'package:mahall_manager/presentation/home/widgets/bottom_nav_widgets/blood_widget.dart';
import 'package:mahall_manager/presentation/home/widgets/bottom_nav_widgets/dashboard_widget.dart';
import 'package:mahall_manager/presentation/home/widgets/bottom_nav_widgets/expats_widget.dart';
import 'package:mahall_manager/presentation/home/widgets/bottom_nav_widgets/islamic_widget.dart';
import 'package:mahall_manager/presentation/home/widgets/bottom_nav_widgets/promises_widget.dart';
import 'package:mahall_manager/presentation/home/widgets/bottom_nav_widgets/reports_widget.dart';
import 'package:mahall_manager/presentation/home/widgets/bottom_nav_widgets/users_widget.dart';
import 'package:mahall_manager/presentation/home/widgets/drawer_widget.dart';

import '../../infrastructure/theme/strings/app_strings.dart';
import '../common_widgets/common_appbar_widget.dart';
import 'controllers/home.controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          final now = DateTime.now();
          if (controller.lastPressedAt == null ||
              now.difference(controller.lastPressedAt!) >
                  const Duration(seconds: 2)) {
            controller.lastPressedAt = now;
            Get.showSnackbar(
              GetSnackBar(
                snackPosition: SnackPosition.BOTTOM,
                messageText: CommonTextWidget(
                  text: AppStrings.pressBackExit,
                  fontSize: AppMeasures.mediumTextSize,
                  color: AppColors.themeColor,
                ),
                duration: const Duration(seconds: 2),
                backgroundColor: AppColors.white,
              ),
            );
            return false;
          }
          return true;
        },
        child: Obx(
          () => controller.isLoggingOut.value
              ? Container(
                  color: AppColors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Lottie.asset('assets/animations/logout.json',
                          width: 200, height: 200),
                    ],
                  ),
                )
              : Scaffold(
                  backgroundColor: AppColors.white,
                  drawer: DrawerWidget(controller: controller),
                  bottomNavigationBar: BottomNavWidget(
                    controller: controller,
                    onTap: (index) {
                      controller.selectedNavIndex.value = index;
                      controller.appBarTitle.value =
                          controller.bottomNavTitles[index];
                    },
                  ),
                  appBar: CommonAppbarWidget(
                    title: controller.appBarTitle.value,
                  ),
                  body: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    child: Obx(() => IndexedStack(
                          index: controller.selectedNavIndex.value,
                          children: controller.userType == '2'
                              ? [
                                  UsersWidget(controller: controller),
                                  const IslamicWidget(),
                                  BloodWidget(controller: controller),
                                  ExpatsWidget(controller: controller),
                                ]
                              : [
                                  DashboardWidget(controller: controller),
                                  UsersWidget(controller: controller),
                                  PromisesWidget(controller: controller),
                                  ReportsWidget(controller: controller),
                                  BloodWidget(controller: controller),
                                  ExpatsWidget(controller: controller),
                                ],
                        )),
                  ),
                ),
        ),
      ),
    );
  }
}
