import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mahall_manager/presentation/home/controllers/home.controller.dart';
import 'package:mahall_manager/presentation/home/widgets/pie_chart_widget.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../infrastructure/navigation/routes.dart';
import '../../../../infrastructure/theme/colors/app_colors.dart';
import '../../../../infrastructure/theme/measures/app_measures.dart';
import '../../../../infrastructure/theme/strings/app_strings.dart';
import '../../../common_widgets/common_text_widget.dart';

class DashboardWidget extends StatelessWidget {
  const DashboardWidget({super.key, required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        return controller.getChartData();
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              _buildMahallName(),
              const SizedBox(height: 20),
              _generatePieChartView(),
              const SizedBox(height: 20),
              _buildClickableIcons(),
            ],
          ),
        ),
      ),
    );
  }

  _buildMahallName() {
    return Column(
      children: [
        Shimmer.fromColors(
          baseColor: Colors.green,
          highlightColor: Colors.red,
          child: Obx(
            () => CommonTextWidget(
              text: controller.mahallName.value,
              textAlign: TextAlign.center,
              fontSize: AppMeasures.bigTextSize,
            ),
          ),
        ),
        Shimmer.fromColors(
          baseColor: Colors.green,
          highlightColor: Colors.red,
          child: const Divider(indent: 10, endIndent: 10),
        )
      ],
    );
  }

  Material _generatePieChartView() {
    return Material(
      color: AppColors.white,
      elevation: 10,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            CommonTextWidget(
              text: AppStrings.incomeAndExpenses,
              fontWeight: AppMeasures.normalWeight,
            ),
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 250,
                  height: 250,
                  child: PieChartWidget(
                    controller: controller,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 20),
                          width: 15,
                          height: 15,
                          color: AppColors.themeColor,
                        ),
                        CommonTextWidget(
                          text: AppStrings.income,
                          fontSize: AppMeasures.smallTextSize,
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 20),
                          width: 15,
                          height: 15,
                          color: AppColors.darkRed,
                        ),
                        CommonTextWidget(
                          text: AppStrings.expenses,
                          fontSize: AppMeasures.smallTextSize,
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  _buildClickableIcons() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        _buildIconWithText(
            title: AppStrings.announcement,
            image: 'assets/images/announcement.png',
            onTap: () {
              Get.toNamed(Routes.ANNOUNCEMENT);
            }),
        _buildIconWithText(
            title: AppStrings.marriageCertificates,
            image: 'assets/images/marriage.png',
            onTap: () {
              Get.toNamed(Routes.MARRIAGE_CERTIFICATES);
            }),
        _buildIconWithText(
            title: AppStrings.listOfDeceased,
            image: 'assets/images/deceased.png',
            onTap: () {
              Get.toNamed(Routes.DEATH_LIST);
            }),
        _buildIconWithText(
            title: AppStrings.listOfReports,
            image: 'assets/images/report.png',
            onTap: () {
              Get.toNamed(Routes.REPORTS_LIST);
            }),
      ],
    );
  }

  _buildIconWithText(
      {required String title,
      required String image,
      required Function() onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Material(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Image.asset(
                image,
                width: 30,
                height: 30,
                color: AppColors.themeColor,
              ),
              const SizedBox(height: 10),
              CommonTextWidget(
                text: title,
                fontSize: 10,
                color: AppColors.themeColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
