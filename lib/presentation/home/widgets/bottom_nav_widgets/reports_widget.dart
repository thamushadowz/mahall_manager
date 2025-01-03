import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mahall_manager/domain/core/interfaces/utility_services.dart';
import 'package:mahall_manager/infrastructure/theme/measures/app_measures.dart';
import 'package:mahall_manager/presentation/common_widgets/common_button_widget.dart';
import 'package:mahall_manager/presentation/common_widgets/common_clickable_text_widget.dart';
import 'package:mahall_manager/presentation/common_widgets/common_text_widget.dart';
import 'package:mahall_manager/presentation/home/widgets/filter_and_clear_filter_widget.dart';
import 'package:toastification/toastification.dart';

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
    return Obx(
      () => controller.isReportsListLoading.value
          ? Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/dark_background.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Image.asset(
                  'assets/images/spin_loader.gif',
                  color: AppColors.white,
                  width: 60,
                  height: 60,
                ),
              ),
            )
          : Column(
              children: [
                controller.reportsDetails.isEmpty &&
                        controller.reportSearchController.text.isEmpty
                    ? const SizedBox.shrink()
                    : Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CommonTextFormField(
                          suffixIcon: Icons.search,
                          textController: controller.reportSearchController,
                          onSuffixTap: () {
                            controller.reportPage.value = 1;
                            controller.reportsDetails.clear();
                            controller.getReportsDetails();
                          },
                          onFieldSubmitted: (val) {
                            controller.reportPage.value = 1;
                            controller.reportsDetails.clear();
                            controller.getReportsDetails();
                          },
                        ),
                      ),
                controller.reportsDetails.isEmpty
                    ? const SizedBox.shrink()
                    : _buildFilterAndClearFilterOption(),
                Obx(() => SizedBox(
                    height: controller.isReportFiltering.value ? 10 : 0)),
                _buildFilterWidget(context),
                const SizedBox(height: 10),
                _buildReportsList(context),
                controller.reportsDetails.isEmpty
                    ? const SizedBox.shrink()
                    : _buildTotalWidget(),
                const SizedBox(height: 20)
              ],
            ),
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
                text: '₹ ${controller.reportTotal.value.toStringAsFixed(0)}',
                color: AppColors.white),
          ),
        ],
      ),
    );
  }

  _buildReportsList(BuildContext context) {
    return Expanded(
      child: RefreshIndicator(
        color: AppColors.themeColor,
        backgroundColor: AppColors.white,
        onRefresh: () {
          controller.reportPage.value = 1;
          controller.reportsDetails.clear();
          return controller.getReportsDetails();
        },
        child: Obx(
          () => SingleChildScrollView(
            controller: controller.reportScrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            child: controller.reportsDetails.isEmpty
                ? SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: const CommonEmptyResultWidget())
                : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: _buildDataTable(context),
                    ),
                  ),
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
              color: AppColors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(20),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  transitionBuilder: (child, animation) {
                    final flipAnimation = Tween(begin: 1.0, end: 0.0)
                        .chain(CurveTween(curve: Curves.easeInOut))
                        .animate(animation);

                    return AnimatedBuilder(
                      animation: flipAnimation,
                      builder: (context, child) {
                        final angle =
                            flipAnimation.value * 3.14159; // Convert to radians
                        return Transform(
                          transform: Matrix4.identity()
                            ..setEntry(3, 2, 0.001) // Perspective
                            ..rotateY(angle),
                          alignment: Alignment.center,
                          child: flipAnimation.value <= 0.5
                              ? child
                              : const Opacity(
                                  opacity: 0,
                                  child: SizedBox(), // Prevent flickering
                                ),
                        );
                      },
                      child: child,
                    );
                  },
                  child: controller.isReportLoading.value
                      ? SizedBox(
                          key: const ValueKey('loading'),
                          width: double.infinity,
                          height: 100,
                          child: Image.asset(
                            'assets/images/spin_loader.gif',
                            color: AppColors.themeColor,
                            fit: BoxFit.fitHeight,
                            width: 30,
                            height: 30,
                          ),
                        )
                      : controller.reportPdfUrl.value.isNotEmpty
                          ? Row(
                              key: const ValueKey('reportGenerated'),
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CommonTextWidget(
                                        text: AppStrings.reportGenerated,
                                        fontSize: AppMeasures.mediumTextSize,
                                        fontWeight: AppMeasures.smallWeight,
                                        color: AppColors.blueGrey,
                                      ),
                                      const SizedBox(height: 10),
                                      GestureDetector(
                                        onTap: () {
                                          _generateBottomSheet();
                                        },
                                        child: CommonTextWidget(
                                          text:
                                              '${controller.reportPdfName.value}.pdf',
                                          color: AppColors.blue,
                                          fontWeight: AppMeasures.mediumWeight,
                                          fontSize: AppMeasures.mediumTextSize,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      controller.reportPdfUrl.value = '';
                                    },
                                    icon: Material(
                                        color: AppColors.darkRed,
                                        elevation: 3,
                                        borderRadius: BorderRadius.circular(40),
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Icon(
                                            Icons.close,
                                            color: AppColors.white,
                                          ),
                                        ))),
                              ],
                            )
                          : Column(
                              children: [
                                //Date Filter
                                Row(
                                  children: [
                                    CommonClickableTextWidget(
                                      padding: const EdgeInsets.all(5),
                                      fontSize: AppMeasures.mediumTextSize,
                                      borderRadius: BorderRadius.circular(10),
                                      title: controller.fromDate.value,
                                      onTap: () async {
                                        FocusScope.of(context)
                                            .requestFocus(FocusNode());
                                        DateTime? pickedDate =
                                            await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1900),
                                          lastDate: DateTime.now(),
                                        );

                                        if (pickedDate != null) {
                                          controller.fromDate.value =
                                              DateFormat('dd/MM/yyyy')
                                                  .format(pickedDate);
                                          // Automatically set toDate if it's not set or invalid
                                          if (controller.toDate.value !=
                                              AppStrings.selectToDate) {
                                            DateTime selectedToDate =
                                                DateFormat('dd/MM/yyyy').parse(
                                                    controller.toDate.value);
                                            if (pickedDate
                                                .isAfter(selectedToDate)) {
                                              controller.toDate.value =
                                                  ''; // Clear toDate if it's less than fromDate
                                            }
                                          }
                                        }
                                      },
                                      textColor: AppColors.themeColor,
                                      border: Border.all(
                                          color: AppColors.themeColor),
                                    ),
                                    controller.fromDate.value ==
                                            AppStrings.selectFromDate
                                        ? const SizedBox.shrink()
                                        : const SizedBox(width: 30),
                                    Obx(
                                      () => controller.fromDate.value ==
                                              AppStrings.selectFromDate
                                          ? const SizedBox.shrink()
                                          : CommonClickableTextWidget(
                                              title: controller.toDate.value,
                                              onTap: () async {
                                                FocusScope.of(context)
                                                    .requestFocus(FocusNode());
                                                DateTime? fromPicked =
                                                    controller.fromDate.value !=
                                                            AppStrings
                                                                .selectFromDate
                                                        ? DateFormat(
                                                                'dd/MM/yyyy')
                                                            .parse(controller
                                                                .fromDate.value)
                                                        : null;
                                                DateTime? pickedDate =
                                                    await showDatePicker(
                                                  context: context,
                                                  initialDate: fromPicked ??
                                                      DateTime.now(),
                                                  firstDate: fromPicked ??
                                                      DateTime(1900),
                                                  lastDate: DateTime.now(),
                                                );

                                                if (pickedDate != null) {
                                                  String formattedDate =
                                                      DateFormat('dd/MM/yyyy')
                                                          .format(pickedDate);

                                                  controller.toDate.value =
                                                      formattedDate;
                                                }
                                              },
                                              fontSize:
                                                  AppMeasures.mediumTextSize,
                                              padding: const EdgeInsets.all(5),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              textColor: AppColors.themeColor,
                                              border: Border.all(
                                                  color: AppColors.themeColor),
                                            ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                const Divider(),
                                //Income Expense Filter
                                controller.isGenerateReport.value
                                    ? const SizedBox.shrink()
                                    : Obx(() => Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Checkbox(
                                              value: controller
                                                  .isIncomeChecked.value,
                                              activeColor: AppColors.themeColor,
                                              onChanged: (value) {
                                                controller
                                                    .toggleIncomeCheckbox();
                                              },
                                            ),
                                            CommonTextWidget(
                                              text: 'Income',
                                              fontSize:
                                                  AppMeasures.mediumTextSize,
                                            ),
                                            Checkbox(
                                              value: controller
                                                  .isExpenseChecked.value,
                                              activeColor: AppColors.themeColor,
                                              onChanged: (value) {
                                                controller
                                                    .toggleExpenseCheckbox();
                                              },
                                            ),
                                            CommonTextWidget(
                                              text: 'Expense',
                                              fontSize:
                                                  AppMeasures.mediumTextSize,
                                            ),
                                          ],
                                        )),
                                controller.isGenerateReport.value
                                    ? const SizedBox.shrink()
                                    : const Divider(),
                                //Admin Filter
                                controller.isGenerateReport.value
                                    ? const SizedBox.shrink()
                                    : Obx(() => Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Checkbox(
                                              value: controller
                                                  .isPresidentChecked.value,
                                              activeColor: AppColors.themeColor,
                                              onChanged: (value) {
                                                controller
                                                    .togglePresidentCheckbox();
                                              },
                                            ),
                                            CommonTextWidget(
                                              text: 'President',
                                              fontSize:
                                                  AppMeasures.mediumTextSize,
                                            ),
                                            Checkbox(
                                              value: controller
                                                  .isSecretaryChecked.value,
                                              activeColor: AppColors.themeColor,
                                              onChanged: (value) {
                                                controller
                                                    .toggleSecretaryCheckbox();
                                              },
                                            ),
                                            CommonTextWidget(
                                              text: 'Secretary',
                                              fontSize:
                                                  AppMeasures.mediumTextSize,
                                            ),
                                            Checkbox(
                                              value: controller
                                                  .isTreasurerChecked.value,
                                              activeColor: AppColors.themeColor,
                                              onChanged: (value) {
                                                controller
                                                    .toggleTreasurerCheckbox();
                                              },
                                            ),
                                            CommonTextWidget(
                                              text: 'Treasurer',
                                              fontSize:
                                                  AppMeasures.mediumTextSize,
                                            ),
                                          ],
                                        )),
                                controller.isGenerateReport.value
                                    ? const SizedBox.shrink()
                                    : const Divider(),
                                const SizedBox(height: 10),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: CommonButtonWidget(
                                    width: 120,
                                    onTap: () {
                                      if (controller.isGenerateReport.value) {
                                        if (controller.fromDate.value ==
                                            AppStrings.selectFromDate) {
                                          showToast(
                                              title: AppStrings
                                                  .selectDateToGenerate,
                                              type: ToastificationType.error);
                                        } else {
                                          controller.generateReportsPdf({
                                            "from_date":
                                                controller.fromDate.value,
                                            "to_date":
                                                controller.toDate.value ==
                                                        AppStrings.selectToDate
                                                    ? controller.fromDate.value
                                                    : controller.toDate.value
                                          });
                                        }
                                      } else {
                                        controller
                                                .isReportFilterSubmitted.value =
                                            controller.checkReportFilters();
                                        controller.reportPage.value = 1;
                                        controller.reportsDetails.clear();
                                        controller.getReportsDetails();
                                        controller.isReportFiltering.value =
                                            false;
                                      }
                                    },
                                    label: AppStrings.submit,
                                    isLoading: false.obs,
                                  ),
                                )
                              ],
                            ),
                ),
              ),
            )
          : const SizedBox(),
    );
  }

  _buildFilterAndClearFilterOption() {
    return Obx(
      () => FilterAndClearFilterWidget(
        isFromReports: true,
        isFilterSubmitted: controller.isReportFilterSubmitted.value,
        onClearFilterTap: controller.clearReportFilters,
        onFilterTap: () {
          controller.isReportFiltering.value =
              !controller.isReportFiltering.value;
          controller.isGenerateReport.value = false;
          controller.reportPdfUrl.value = '';
          controller.reportPdfName.value = '';
        },
        onGenerateTap: () {
          controller.isGenerateReport.value = true;
          controller.isReportFiltering.value =
              !controller.isReportFiltering.value;
        },
      ),
    );
  }

  Widget _buildDataTable(BuildContext context) {
    return Container(
      color: AppColors.white.withOpacity(0.8),
      child: DataTable(
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
        rows: controller.reportsDetails.map((report) {
          return DataRow(
            color: WidgetStateProperty.all(report.incomeOrExpense == '0'
                ? AppColors.themeColor.withOpacity(0.2)
                : AppColors.darkRed.withOpacity(0.2)),
            cells: [
              DataCell(CommonTextWidget(
                text: report.referenceNo.toString(),
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
                text: report.designation ?? '',
                fontWeight: AppMeasures.mediumWeight,
                fontSize: AppMeasures.mediumTextSize,
              )),
              DataCell(
                //Details
                report.isSharable ?? false
                    ? IconButton(
                        icon: Icon(
                          Icons.share_rounded,
                          size: 20,
                          color: AppColors.blueGrey,
                        ),
                        onPressed: () async {
                          Get.toNamed(Routes.PAYMENT_SCREEN,
                              arguments: {'report': report});
                        },
                      )
                    : Row(
                        children: [
                          //Edit
                          IconButton(
                            icon: Icon(
                              Icons.edit_note_rounded,
                              color: AppColors.blueGrey,
                            ),
                            onPressed: () async {
                              if (report.incomeOrExpense == '0') {
                                Get.toNamed(Routes.ADD_INCOME,
                                        arguments: report)
                                    ?.then((onValue) {
                                  if (onValue != null && onValue == true) {
                                    controller.reportPage.value = 1;
                                    controller.reportsDetails.clear();
                                    controller.getReportsDetails();
                                    controller.getChartData();
                                  }
                                });
                              } else {
                                Get.toNamed(Routes.ADD_EXPENSES,
                                        arguments: report)
                                    ?.then((onValue) {
                                  if (onValue != null && onValue == true) {
                                    controller.reportPage.value = 1;
                                    controller.reportsDetails.clear();
                                    controller.getReportsDetails();
                                    controller.getChartData();
                                  }
                                });
                              }
                            },
                          ),
                          //Delete
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
                                  onYesTap: () {
                                controller.deleteReport(report.id!);
                                Get.close(0);
                              });
                            },
                          ),
                        ],
                      ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  void _generateBottomSheet() {
    Get.bottomSheet(
      backgroundColor: AppColors.white,
      SizedBox(
        height: 140,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _generateContactButton(
              iconColor: AppColors.themeColor,
              title: AppStrings.viewPdf,
              onTap: () {
                Get.toNamed(
                  Routes.PDF_VIEWER,
                  arguments: {
                    AppStrings.pdfName: controller.reportPdfName.value,
                    AppStrings.pdfUrl: controller.reportPdfUrl.value
                  },
                )?.then((onValue) {
                  Get.close(0);
                });
              },
              icon: Icons.picture_as_pdf_rounded,
            ),
            _generateContactButton(
              iconColor: AppColors.blue,
              title: AppStrings.download,
              onTap: () {
                controller.savePdf(controller.reportPdfName.value,
                    controller.reportPdfUrl.value);
              },
              icon: Icons.download_rounded,
            ),
          ],
        ),
      ),
    );
  }

  /// Action Button Widget
  Widget _generateContactButton({
    required String title,
    required Function() onTap,
    required IconData icon,
    required Color iconColor,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(50),
          onTap: onTap,
          radius: 40,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.lightGrey.withOpacity(0.3),
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: AppColors.blueGrey),
            ),
            child: Icon(
              icon,
              size: 30,
              color: iconColor,
            ),
          ),
        ),
        const SizedBox(height: 8),
        CommonTextWidget(
          text: title,
          fontSize: AppMeasures.smallTextSize,
          fontWeight: FontWeight.w500,
          color: AppColors.black,
        ),
      ],
    );
  }
}
