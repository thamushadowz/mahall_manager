import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mahall_manager/infrastructure/theme/colors/app_colors.dart';
import 'package:mahall_manager/infrastructure/theme/measures/app_measures.dart';
import 'package:mahall_manager/presentation/home/controllers/home.controller.dart';

class PieChartWidget extends StatelessWidget {
  const PieChartWidget({super.key, required this.controller});
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        sections: [
          PieChartSectionData(
            color: AppColors.themeColor,
            value: double.parse(controller.chartData.totalIncome ?? ''),
            title: '₹ ${controller.chartData.totalIncome}',
            radius: 80,
            titleStyle: TextStyle(
              fontSize: AppMeasures.mediumTextSize,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
            ),
          ),
          PieChartSectionData(
            color: AppColors.darkRed,
            value: double.parse(controller.chartData.totalExpense ?? ''),
            title: '₹ ${controller.chartData.totalExpense}',
            radius: 70,
            titleStyle: TextStyle(
              fontSize: AppMeasures.mediumTextSize,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
            ),
          )
        ],
        centerSpaceRadius: 10,
        sectionsSpace: 2,
        pieTouchData: PieTouchData(
          touchCallback: (FlTouchEvent event, pieTouchResponse) {
            if (!event.isInterestedForInteractions ||
                pieTouchResponse == null ||
                pieTouchResponse.touchedSection == null) {
              controller.selectedSectionIndex.value = -1;
              return;
            }
            controller.selectedSectionIndex.value =
                pieTouchResponse.touchedSection!.touchedSectionIndex;
          },
        ),
      ),
    );
  }
}
