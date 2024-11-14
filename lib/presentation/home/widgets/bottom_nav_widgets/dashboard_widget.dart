import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mahall_manager/domain/core/interfaces/validator.dart';
import 'package:mahall_manager/presentation/common_widgets/common_button_widget.dart';
import 'package:mahall_manager/presentation/common_widgets/common_text_form_field.dart';
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
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            _generatePieChartView(),
            const SizedBox(height: 10),
            _generateAnnouncementView()
          ],
        ),
      ),
    );
  }

  Material _generateAnnouncementView() {
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(20),
      color: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              CommonTextWidget(text: AppStrings.announcementManager),
              const SizedBox(height: 10),
              CommonTextFormField(
                textController: controller.announcementController,
                minLines: 10,
                maxLines: 30,
                hint: AppStrings.typeHere,
                validator: Validators.validateAnnouncement,
                suffixIcon: Icons.delete_sweep_outlined,
                onSuffixTap: () {
                  controller.announcementController.clear();
                },
              ),
              const SizedBox(height: 10),
              CommonButtonWidget(
                onTap: () {
                  if (controller.formKey.currentState!.validate()) {
                    // Handle form submission
                  }
                },
                label: AppStrings.submit,
                isLoading: false.obs,
              )
            ],
          ),
        ),
      ),
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
                Flexible(
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
