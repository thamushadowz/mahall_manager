import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mahall_manager/infrastructure/theme/colors/app_colors.dart';
import 'package:mahall_manager/presentation/home/controllers/home.controller.dart';

class PieChartWidget extends StatelessWidget {
  const PieChartWidget({super.key, required this.controller});
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() => PieChart(
          PieChartData(
            sections: controller.chartData.asMap().entries.map((entry) {
              int index = entry.key;
              final data = entry.value;
              final isIncome = data.category == "Income";
              final isSelected = index == controller.selectedSectionIndex.value;

              // Display amount if selected, otherwise display percentage
              final titleText = isSelected
                  ? "₹${data.amount.toStringAsFixed(1)}"
                  : "${((data.amount / (controller.income.value + controller.expense.value)) * 100).toStringAsFixed(1)}%";

              return PieChartSectionData(
                color: isIncome ? AppColors.themeColor : AppColors.darkRed,
                value: data.amount,
                title: titleText,
                radius: isSelected ? 100 : 80, // Expanded radius if selected
                titleStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
              );
            }).toList(),
            centerSpaceRadius: 40,
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
        ));
  }
}
