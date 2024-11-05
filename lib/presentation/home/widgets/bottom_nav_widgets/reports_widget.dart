import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mahall_manager/infrastructure/theme/measures/app_measures.dart';
import 'package:mahall_manager/presentation/common_widgets/common_button_widget.dart';
import 'package:mahall_manager/presentation/common_widgets/common_clickable_text_widget.dart';
import 'package:mahall_manager/presentation/common_widgets/common_text_widget.dart';

import '../../../../infrastructure/theme/colors/app_colors.dart';
import '../../../../infrastructure/theme/strings/app_strings.dart';
import '../../../common_widgets/common_text_form_field.dart';
import '../../controllers/home.controller.dart';

class ReportsWidget extends StatelessWidget {
  const ReportsWidget({super.key, required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommonTextFormField(
          inputFormatters: [
            LengthLimitingTextInputFormatter(40),
          ],
          suffixIcon: Icons.search,
          textController: controller.reportSearchController,
          onFieldSubmitted: (val) {},
        ),
        const SizedBox(height: 20),
        _buildFilterAndClearFilterOption(),
        Obx(() => SizedBox(height: controller.isFiltering.value ? 20 : 0)),
        _buildFilterWidget(context),
        const SizedBox(height: 20),
        _buildReportsList(),
      ],
    );
  }

  Expanded _buildReportsList() {
    return Expanded(
        child: Obx(
      () => controller.filteredReportsDetails.isEmpty
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 500,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 20),
                    color: AppColors.themeColor,
                    child: Row(
                      children: [
                        Expanded(
                          flex:
                              2, // Adjust flex as needed for each column's width
                          child: CommonTextWidget(
                            text: AppStrings.description,
                            fontWeight: AppMeasures.mediumWeight,
                            fontSize: AppMeasures.mediumTextSize,
                            color: AppColors.white,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: CommonTextWidget(
                            text: AppStrings.date,
                            fontWeight: AppMeasures.mediumWeight,
                            fontSize: AppMeasures.mediumTextSize,
                            color: AppColors.white,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: CommonTextWidget(
                            text: AppStrings.amount,
                            fontWeight: AppMeasures.mediumWeight,
                            fontSize: AppMeasures.mediumTextSize,
                            color: AppColors.white,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: CommonTextWidget(
                            text: AppStrings.addedBy,
                            fontWeight: AppMeasures.mediumWeight,
                            fontSize: AppMeasures.mediumTextSize,
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // List of Rows
                  Expanded(
                    child: _buildUserList(),
                  ),
                ],
              ),
            ),
    ));
  }

  Obx _buildFilterWidget(BuildContext context) {
    return Obx(
      () => controller.isFiltering.value
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
                              controller.checkFilters();
                          controller.applyFilters();
                          controller.isFiltering.value = false;
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

  Row _buildFilterAndClearFilterOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Obx(() => controller.isReportFilterSubmitted.value
            ? CommonClickableTextWidget(
                title: AppStrings.clearFilters,
                onTap: controller.clearFilters,
                border: Border.all(color: AppColors.darkRed),
                fontSize: AppMeasures.mediumTextSize,
                padding: const EdgeInsets.all(7),
                borderRadius: BorderRadius.circular(10),
                textColor: AppColors.darkRed,
                fontWeight: AppMeasures.mediumWeight,
              )
            : const SizedBox()),
        const SizedBox(width: 20),
        InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: () {
            controller.isFiltering.value = !controller.isFiltering.value;
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CommonTextWidget(
                  text: AppStrings.filters,
                  fontSize: AppMeasures.mediumTextSize,
                  fontWeight: AppMeasures.smallWeight,
                ),
                const SizedBox(width: 6),
                const Icon(
                  Icons.filter_alt,
                  size: 20,
                  color: Colors.blueGrey,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 20),
      ],
    );
  }

  Widget _buildUserList() {
    return SizedBox(
      width: 600, // Set width for horizontal scroll
      child: Obx(
        () => ListView.separated(
          shrinkWrap: true,
          itemCount: controller.filteredReportsDetails.length,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.all(15),
              color:
                  controller.filteredReportsDetails[index].incomeOrExpense == 0
                      ? AppColors.themeColor.withOpacity(0.2)
                      : AppColors.darkRed.withOpacity(0.2),
              alignment: Alignment.center,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: CommonTextWidget(
                      text: controller
                              .filteredReportsDetails[index].description ??
                          '',
                      fontWeight: AppMeasures.mediumWeight,
                      fontSize: AppMeasures.mediumTextSize,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: CommonTextWidget(
                      text: controller.filteredReportsDetails[index].date ?? '',
                      fontWeight: AppMeasures.mediumWeight,
                      fontSize: AppMeasures.smallTextSize,
                      color: AppColors.darkRed.withOpacity(0.6),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: CommonTextWidget(
                      text: controller.filteredReportsDetails[index].amount
                              .toString() ??
                          '',
                      fontWeight: AppMeasures.mediumWeight,
                      fontSize: AppMeasures.mediumTextSize,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: CommonTextWidget(
                      text: controller.filteredReportsDetails[index].addedBy ??
                          '',
                      fontWeight: AppMeasures.mediumWeight,
                      fontSize: AppMeasures.mediumTextSize,
                    ),
                  ),
                  const SizedBox(width: 30),
                  Icon(
                    Icons.edit_note_rounded,
                    color: AppColors.blueGrey,
                  ),
                  const SizedBox(width: 30),
                  Icon(
                    Icons.delete_outline_rounded,
                    color: AppColors.darkRed,
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              color: AppColors.blueGrey.withOpacity(0.5),
            );
          },
        ),
      ),
    );
  }
}
