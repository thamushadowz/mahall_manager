import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mahall_manager/infrastructure/theme/measures/app_measures.dart';
import 'package:mahall_manager/presentation/common_widgets/common_button_widget.dart';
import 'package:mahall_manager/presentation/common_widgets/common_clickable_text_widget.dart';
import 'package:mahall_manager/presentation/common_widgets/common_text_widget.dart';
import 'package:mahall_manager/presentation/home/widgets/filter_and_clear_filter_widget.dart';

import '../../../../domain/core/interfaces/common_alert.dart';
import '../../../../infrastructure/navigation/routes.dart';
import '../../../../infrastructure/theme/colors/app_colors.dart';
import '../../../../infrastructure/theme/strings/app_strings.dart';
import '../../../common_widgets/common_empty_result_widget.dart';
import '../../../common_widgets/common_text_form_field.dart';
import '../../controllers/home.controller.dart';

class ReportsWidget extends StatelessWidget {
  const ReportsWidget({super.key, required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: CommonTextFormField(
            suffixIcon: Icons.search,
            textController: controller.reportSearchController,
          ),
        ),
        _buildFilterAndClearFilterOption(),
        Obx(() =>
            SizedBox(height: controller.isReportFiltering.value ? 10 : 0)),
        _buildFilterWidget(context),
        const SizedBox(height: 10),
        _buildReportsList(context),
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
                text: controller.reportTotal.value.toStringAsFixed(0),
                color: AppColors.white),
          ),
        ],
      ),
    );
  }

  _buildReportsList(BuildContext context) {
    return Expanded(
      child: Obx(
        () => controller.filteredReportsDetails.isEmpty
            ? const CommonEmptyResultWidget()
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: _buildDataTable(context),
                ),
              ),
      ),
    );
  }

  Obx _buildFilterWidget(BuildContext context) {
    return Obx(
      () => controller.isReportFiltering.value
          ? Material(
              elevation: 10,
              color: AppColors.white,
              borderRadius: BorderRadius.circular(20),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CommonClickableTextWidget(
                          padding: const EdgeInsets.all(5),
                          fontSize: AppMeasures.mediumTextSize,
                          borderRadius: BorderRadius.circular(10),
                          title: controller.fromDate.value,
                          onTap: () async {
                            FocusScope.of(context).requestFocus(FocusNode());
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                            );

                            if (pickedDate != null) {
                              controller.fromDate.value =
                                  DateFormat('dd/MM/yyyy').format(pickedDate);
                              // Automatically set toDate if it's not set or invalid
                              if (controller.toDate.value !=
                                  AppStrings.selectToDate) {
                                DateTime selectedToDate =
                                    DateFormat('dd/MM/yyyy')
                                        .parse(controller.toDate.value);
                                if (pickedDate.isAfter(selectedToDate)) {
                                  controller.toDate.value =
                                      ''; // Clear toDate if it's less than fromDate
                                }
                              }
                            }
                          },
                          textColor: AppColors.themeColor,
                          border: Border.all(color: AppColors.themeColor),
                        ),
                        const SizedBox(width: 30),
                        CommonClickableTextWidget(
                          title: controller.toDate.value,
                          onTap: () async {
                            FocusScope.of(context).requestFocus(FocusNode());
                            DateTime? fromPicked = controller.fromDate.value !=
                                    AppStrings.selectFromDate
                                ? DateFormat('dd/MM/yyyy')
                                    .parse(controller.fromDate.value)
                                : null;
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: fromPicked ?? DateTime.now(),
                              firstDate: fromPicked ?? DateTime(1900),
                              lastDate: DateTime.now(),
                            );

                            if (pickedDate != null) {
                              String formattedDate =
                                  DateFormat('dd/MM/yyyy').format(pickedDate);

                              controller.toDate.value = formattedDate;
                            }
                          },
                          fontSize: AppMeasures.mediumTextSize,
                          padding: const EdgeInsets.all(5),
                          borderRadius: BorderRadius.circular(10),
                          textColor: AppColors.themeColor,
                          border: Border.all(color: AppColors.themeColor),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Divider(),
                    Obx(() => Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(
                              value: controller.isIncomeChecked.value,
                              activeColor: AppColors.themeColor,
                              onChanged: (value) {
                                controller.toggleIncomeCheckbox();
                              },
                            ),
                            CommonTextWidget(
                              text: 'Income',
                              fontSize: AppMeasures.mediumTextSize,
                            ),
                            Checkbox(
                              value: controller.isExpenseChecked.value,
                              activeColor: AppColors.themeColor,
                              onChanged: (value) {
                                controller.toggleExpenseCheckbox();
                              },
                            ),
                            CommonTextWidget(
                              text: 'Expense',
                              fontSize: AppMeasures.mediumTextSize,
                            ),
                          ],
                        )),
                    const Divider(),
                    Obx(() => Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(
                              value: controller.isPresidentChecked.value,
                              activeColor: AppColors.themeColor,
                              onChanged: (value) {
                                controller.togglePresidentCheckbox();
                              },
                            ),
                            CommonTextWidget(
                              text: 'President',
                              fontSize: AppMeasures.mediumTextSize,
                            ),
                            Checkbox(
                              value: controller.isSecretaryChecked.value,
                              activeColor: AppColors.themeColor,
                              onChanged: (value) {
                                controller.toggleSecretaryCheckbox();
                              },
                            ),
                            CommonTextWidget(
                              text: 'Secretary',
                              fontSize: AppMeasures.mediumTextSize,
                            ),
                            Checkbox(
                              value: controller.isTreasurerChecked.value,
                              activeColor: AppColors.themeColor,
                              onChanged: (value) {
                                controller.toggleTreasurerCheckbox();
                              },
                            ),
                            CommonTextWidget(
                              text: 'Treasurer',
                              fontSize: AppMeasures.mediumTextSize,
                            ),
                          ],
                        )),
                    const Divider(),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: CommonButtonWidget(
                        width: 120,
                        onTap: () {
                          controller.isReportFilterSubmitted.value =
                              controller.checkReportFilters();
                          controller.applyFilters();
                          controller.isReportFiltering.value = false;
                        },
                        label: AppStrings.submit,
                        isLoading: false.obs,
                      ),
                    )
                  ],
                ),
              ),
            )
          : const SizedBox(),
    );
  }

  _buildFilterAndClearFilterOption() {
    return Obx(() => FilterAndClearFilterWidget(
        isFilterSubmitted: controller.isReportFilterSubmitted.value,
        onClearFilterTap: controller.clearReportFilters,
        onFilterTap: () {
          controller.isReportFiltering.value =
              !controller.isReportFiltering.value;
        }));
  }

  Widget _buildDataTable(BuildContext context) {
    return DataTable(
      columnSpacing: 20,
      headingRowColor: WidgetStateProperty.all(AppColors.themeColor),
      columns: [
        DataColumn(
          label: CommonTextWidget(
            text: AppStrings.id,
            fontWeight: AppMeasures.mediumWeight,
            fontSize: AppMeasures.mediumTextSize,
            color: AppColors.white,
          ),
        ),
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
      rows: controller.filteredReportsDetails.map((report) {
        return DataRow(
          color: WidgetStateProperty.all(report.incomeOrExpense == '0'
              ? AppColors.themeColor.withOpacity(0.1)
              : AppColors.darkRed.withOpacity(0.1)),
          cells: [
            DataCell(CommonTextWidget(
              text: report.id.toString(),
              fontWeight: AppMeasures.mediumWeight,
              fontSize: AppMeasures.mediumTextSize,
            )),
            DataCell(CommonTextWidget(
              text: report.description ?? '',
              fontWeight: AppMeasures.mediumWeight,
              fontSize: AppMeasures.mediumTextSize,
            )),
            DataCell(CommonTextWidget(
              text: report.date ?? '',
              fontWeight: AppMeasures.mediumWeight,
              fontSize: AppMeasures.smallTextSize,
              color: AppColors.darkRed.withOpacity(0.6),
            )),
            DataCell(CommonTextWidget(
              text: report.amount.toString(),
              fontWeight: AppMeasures.mediumWeight,
              fontSize: AppMeasures.mediumTextSize,
            )),
            DataCell(CommonTextWidget(
              text: report.addedBy ?? '',
              fontWeight: AppMeasures.mediumWeight,
              fontSize: AppMeasures.mediumTextSize,
            )),
            DataCell(
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.edit_note_rounded,
                      color: AppColors.blueGrey,
                    ),
                    onPressed: () async {
                      if (report.incomeOrExpense == '0') {
                        final updatedReport = await Get.toNamed(
                            Routes.ADD_INCOME,
                            arguments: report);
                        if (updatedReport != null) {
                          controller.updateReportItem(updatedReport);
                        }
                      } else {
                        final updatedReport = await Get.toNamed(
                            Routes.ADD_EXPENSES,
                            arguments: report);
                        if (updatedReport != null) {
                          controller.updateReportItem(updatedReport);
                        }
                      }
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.delete_outline_rounded,
                      color: AppColors.darkRed,
                    ),
                    onPressed: () {
                      showCommonDialog(context,
                          message: AppStrings.areYouSureToDelete,
                          yesButtonName: AppStrings.delete,
                          messageColor: AppColors.darkRed,
                          onYesTap: () {});
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
