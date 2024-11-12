import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mahall_manager/presentation/home/controllers/home.controller.dart';

import '../../../../infrastructure/navigation/routes.dart';
import '../../../../infrastructure/theme/colors/app_colors.dart';
import '../../../../infrastructure/theme/measures/app_measures.dart';
import '../../../../infrastructure/theme/strings/app_strings.dart';
import '../../../common_widgets/common_clickable_text_widget.dart';
import '../../../common_widgets/common_text_form_field.dart';
import '../../../common_widgets/common_text_widget.dart';

class PromisesWidget extends StatelessWidget {
  const PromisesWidget({super.key, required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: CommonTextFormField(
            suffixIcon: Icons.search,
            textController: controller.promisesSearchController,
          ),
        ),
        const SizedBox(height: 20),
        _buildReportsList(),
        _buildTotalWidget(),
        const SizedBox(height: 20)
      ],
    );
  }

  Container _buildTotalWidget() {
    return Container(
      padding: const EdgeInsets.all(15),
      color: AppColors.themeColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CommonTextWidget(
            text: '${AppStrings.total} : ',
            color: AppColors.white,
          ),
          const SizedBox(width: 50),
          Obx(
            () => CommonTextWidget(
                text: controller.promisesTotal.value.toStringAsFixed(0),
                color: AppColors.white),
          ),
        ],
      ),
    );
  }

  Expanded _buildReportsList() {
    return Expanded(
        child: Obx(
      () => controller.filteredPromisesDetails.isEmpty
          ? Center(
              child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/empty_result.png',
                    width: 350,
                    height: 300,
                    fit: BoxFit.fill,
                  ),
                  CommonTextWidget(
                      text: 'No results',
                      fontSize: AppMeasures.bigTextSize,
                      fontWeight: AppMeasures.mediumWeight,
                      color: AppColors.grey),
                ],
              ),
            ))
          : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Expanded(
                  child: _buildDataTable(),
                ),
              ),
            ),
    ));
  }

  Widget _buildDataTable() {
    return DataTable(
      columnSpacing: 20,
      headingRowColor: WidgetStateProperty.all(AppColors.themeColor),
      columns: [
        DataColumn(
          label: CommonTextWidget(
            text: AppStrings.description,
            fontWeight: AppMeasures.mediumWeight,
            fontSize: AppMeasures.mediumTextSize,
            color: AppColors.white,
          ),
        ),
        DataColumn(
          label: CommonTextWidget(
            text: AppStrings.date,
            fontWeight: AppMeasures.mediumWeight,
            fontSize: AppMeasures.mediumTextSize,
            color: AppColors.white,
          ),
        ),
        DataColumn(
          label: CommonTextWidget(
            text: AppStrings.amount,
            fontWeight: AppMeasures.mediumWeight,
            fontSize: AppMeasures.mediumTextSize,
            color: AppColors.white,
          ),
        ),
        DataColumn(
          label: CommonTextWidget(
            text: AppStrings.addedBy,
            fontWeight: AppMeasures.mediumWeight,
            fontSize: AppMeasures.mediumTextSize,
            color: AppColors.white,
          ),
        ),
        DataColumn(
          label: CommonTextWidget(
            text: AppStrings.actions,
            fontWeight: AppMeasures.mediumWeight,
            fontSize: AppMeasures.mediumTextSize,
            color: AppColors.white,
          ),
        ),
      ],
      rows: controller.filteredPromisesDetails.map((promises) {
        return DataRow(
          cells: [
            DataCell(CommonTextWidget(
              text: promises.description ?? '',
              fontWeight: AppMeasures.mediumWeight,
              fontSize: AppMeasures.mediumTextSize,
            )),
            DataCell(CommonTextWidget(
              text: promises.date ?? '',
              fontWeight: AppMeasures.mediumWeight,
              fontSize: AppMeasures.smallTextSize,
              color: AppColors.darkRed.withOpacity(0.6),
            )),
            DataCell(CommonTextWidget(
              text: promises.amount.toString(),
              fontWeight: AppMeasures.mediumWeight,
              fontSize: AppMeasures.mediumTextSize,
            )),
            DataCell(CommonTextWidget(
              text: promises.addedBy ?? '',
              fontWeight: AppMeasures.mediumWeight,
              fontSize: AppMeasures.mediumTextSize,
            )),
            DataCell(
              Row(
                children: [
                  CommonClickableTextWidget(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.themeColor),
                    textColor: AppColors.themeColor,
                    title: AppStrings.collectMoney,
                    onTap: () {
                      Get.toNamed(Routes.PAYMENT_SCREEN);
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}
