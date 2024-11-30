import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mahall_manager/presentation/home/controllers/home.controller.dart';
import 'package:mahall_manager/presentation/home/widgets/pie_chart_widget.dart';
import 'package:shimmer/shimmer.dart';

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
      onRefresh: () => controller.getChartData(),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              _buildMahallName(),
              const SizedBox(height: 20),
              _generatePieChartView(context),
              const SizedBox(height: 20),
              _buildClickableIconsGridView(),
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
        ),
      ],
    );
  }

  Material _generatePieChartView(BuildContext context) {
    return Material(
      color: AppColors.white.withOpacity(0.8),
      elevation: 10,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            CommonTextWidget(
              text: AppStrings.incomeAndExpenses,
              fontWeight: AppMeasures.normalWeight,
            ),
            const SizedBox(height: 10),
            Obx(() => controller.isChartDataLoading.value
                ? SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: Center(
                        child: Image.asset(
                      'assets/images/spin_loader.gif',
                      width: 40,
                      height: 40,
                      color: AppColors.themeColor,
                    )),
                  )
                : SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: PieChartWidget(
                      controller: controller,
                    ),
                  )),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLegendItem(AppColors.themeColor, AppStrings.income),
                const SizedBox(height: 10),
                _buildLegendItem(AppColors.darkRed, AppStrings.expenses),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 10),
          width: 15,
          height: 15,
          color: color,
        ),
        CommonTextWidget(
          text: label,
          fontSize: AppMeasures.smallTextSize,
        ),
      ],
    );
  }

  _buildClickableIconsGridView() {
    return SizedBox(
      width: MediaQuery.of(Get.context!).size.width,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 4,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Get.toNamed(controller.reportsGrid[index]['onClick']);
            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      controller.reportsGrid[index]['icon'],
                      width: 30,
                      height: 30,
                      color: AppColors.themeColor,
                    ),
                    const SizedBox(height: 10),
                    CommonTextWidget(
                      text: controller.reportsGrid[index]['title'],
                      fontSize: 10,
                      color: AppColors.themeColor,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2,
          childAspectRatio: 1,
        ),
      ),
    );
  }
}
