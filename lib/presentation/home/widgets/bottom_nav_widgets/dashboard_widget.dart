import 'package:flutter/material.dart';
import 'package:mahall_manager/presentation/home/controllers/home.controller.dart';
import 'package:mahall_manager/presentation/home/widgets/pie_chart_widget.dart';

import '../../../../infrastructure/theme/colors/app_colors.dart';
import '../../../../infrastructure/theme/measures/app_measures.dart';
import '../../../../infrastructure/theme/strings/app_strings.dart';
import '../../../common_widgets/common_text_widget.dart';

class DashboardWidget extends StatelessWidget {
  const DashboardWidget({super.key, required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.grey),
          ),
        ),
        const SizedBox(height: 20),
        _generatePieChartView(),
      ],
    );
  }

  _generatePieChartView() {
    return Material(
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
                Expanded(
                  child: Column(
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
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
