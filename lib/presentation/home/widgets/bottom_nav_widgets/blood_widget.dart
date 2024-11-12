import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mahall_manager/presentation/home/controllers/home.controller.dart';

import '../../../../infrastructure/navigation/routes.dart';
import '../../../../infrastructure/theme/colors/app_colors.dart';
import '../../../../infrastructure/theme/measures/app_measures.dart';
import '../../../../infrastructure/theme/strings/app_strings.dart';
import '../../../common_widgets/common_button_widget.dart';
import '../../../common_widgets/common_clickable_text_widget.dart';
import '../../../common_widgets/common_text_form_field.dart';
import '../../../common_widgets/common_text_widget.dart';
import '../filter_and_clear_filter_widget.dart';

class BloodWidget extends StatelessWidget {
  const BloodWidget({super.key, required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommonTextFormField(
          suffixIcon: Icons.search,
          textController: controller.bloodSearchController,
        ),
        const SizedBox(height: 20),
        _buildFilterAndClearFilterOption(),
        Obx(() => SizedBox(height: controller.isBloodFiltering.value ? 20 : 0)),
        _buildFilterWidget(context),
        const SizedBox(height: 20),
        _buildBloodList(),
      ],
    );
  }

  _buildFilterAndClearFilterOption() {
    return Obx(() => FilterAndClearFilterWidget(
        isFilterSubmitted: controller.isBloodFilterSubmitted.value,
        onClearFilterTap: controller.clearBloodFilters,
        onFilterTap: () {
          controller.isBloodFiltering.value =
              !controller.isBloodFiltering.value;
        }));
  }

  Obx _buildFilterWidget(BuildContext context) {
    return Obx(
      () => controller.isBloodFiltering.value
          ? Material(
              elevation: 10,
              color: AppColors.white,
              borderRadius: BorderRadius.circular(20),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Obx(() => Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            _buildCheckboxWidget(
                                label: AppStrings.male,
                                value: controller.isMaleChecked.value,
                                onChanged: (val) {
                                  controller.toggleMaleCheckbox();
                                }),
                            _buildCheckboxWidget(
                                label: AppStrings.female,
                                value: controller.isFemaleChecked.value,
                                onChanged: (val) {
                                  controller.toggleFemaleCheckbox();
                                }),
                          ],
                        )),
                    const Divider(),
                    Obx(() => Wrap(
                          alignment: WrapAlignment.start,
                          spacing: 5,
                          runSpacing: 5,
                          children: [
                            _buildCheckboxWidget(
                                label: AppStrings.apos,
                                value: controller.isAposChecked.value,
                                onChanged: (val) {
                                  controller.toggleAposCheckbox();
                                }),
                            _buildCheckboxWidget(
                                label: AppStrings.aneg,
                                value: controller.isAnegChecked.value,
                                onChanged: (val) {
                                  controller.toggleAnegCheckbox();
                                }),
                            _buildCheckboxWidget(
                                label: AppStrings.bpos,
                                value: controller.isBposChecked.value,
                                onChanged: (val) {
                                  controller.toggleBposCheckbox();
                                }),
                            _buildCheckboxWidget(
                                label: AppStrings.bneg,
                                value: controller.isBnegChecked.value,
                                onChanged: (val) {
                                  controller.toggleBnegCheckbox();
                                }),
                            _buildCheckboxWidget(
                                label: AppStrings.abpos,
                                value: controller.isABposChecked.value,
                                onChanged: (val) {
                                  controller.toggleABposCheckbox();
                                }),
                            _buildCheckboxWidget(
                                label: AppStrings.abneg,
                                value: controller.isABnegChecked.value,
                                onChanged: (val) {
                                  controller.toggleABnegCheckbox();
                                }),
                            _buildCheckboxWidget(
                                label: AppStrings.opos,
                                value: controller.isOposChecked.value,
                                onChanged: (val) {
                                  controller.toggleOposCheckbox();
                                }),
                            _buildCheckboxWidget(
                                label: AppStrings.oneg,
                                value: controller.isOnegChecked.value,
                                onChanged: (val) {
                                  controller.toggleOnegCheckbox();
                                }),
                          ],
                        )),
                    const Divider(),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: CommonButtonWidget(
                        width: 120,
                        onTap: () {
                          controller.isBloodFilterSubmitted.value =
                              controller.checkBloodFilters();
                          controller.applyBloodFilters();
                          controller.isBloodFiltering.value = false;
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

  _buildCheckboxWidget({
    required String label,
    required bool value,
    required Function(bool?) onChanged,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(
          value: value,
          activeColor: AppColors.themeColor,
          onChanged: onChanged,
        ),
        CommonTextWidget(
          text: label,
          fontSize: AppMeasures.smallTextSize,
        ),
      ],
    );
  }

  Expanded _buildBloodList() {
    return Expanded(
      child: Obx(
        () => controller.filteredBloodDetails.isEmpty
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
                        color: AppColors.grey,
                      ),
                    ],
                  ),
                ),
              )
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: _buildDataTable(),
                ),
              ),
      ),
    );
  }

  Widget _buildDataTable() {
    return DataTable(
        columnSpacing: 30,
        headingRowColor: WidgetStateProperty.all(AppColors.themeColor),
        columns: [
          DataColumn(
            label: CommonTextWidget(
              text: AppStrings.registerNo,
              fontWeight: AppMeasures.mediumWeight,
              fontSize: AppMeasures.mediumTextSize,
              color: AppColors.white,
            ),
          ),
          DataColumn(
            label: CommonTextWidget(
              text: AppStrings.bloodGroup,
              fontWeight: AppMeasures.mediumWeight,
              fontSize: AppMeasures.mediumTextSize,
              color: AppColors.white,
            ),
          ),
          DataColumn(
            label: CommonTextWidget(
              text: AppStrings.name,
              fontWeight: AppMeasures.mediumWeight,
              fontSize: AppMeasures.mediumTextSize,
              color: AppColors.white,
            ),
          ),
          DataColumn(
            label: CommonTextWidget(
              text: AppStrings.mobileNo,
              fontWeight: AppMeasures.mediumWeight,
              fontSize: AppMeasures.mediumTextSize,
              color: AppColors.white,
            ),
          ),
          DataColumn(
            label: CommonTextWidget(
              text: AppStrings.gender,
              fontWeight: AppMeasures.mediumWeight,
              fontSize: AppMeasures.mediumTextSize,
              color: AppColors.white,
            ),
          ),
          DataColumn(
            label: CommonTextWidget(
              text: AppStrings.houseNameAndPlace,
              fontWeight: AppMeasures.mediumWeight,
              fontSize: AppMeasures.mediumTextSize,
              color: AppColors.white,
            ),
          ),
        ],
        rows: controller.filteredBloodDetails.map((blood) {
          return DataRow(
            cells: [
              DataCell(
                CommonTextWidget(
                  text: blood.userRegNo ?? '',
                  fontSize: AppMeasures.mediumTextSize,
                ),
              ),
              DataCell(
                CommonTextWidget(
                  text: blood.bloodGroup ?? '',
                  fontSize: AppMeasures.mediumTextSize,
                ),
              ),
              DataCell(
                CommonTextWidget(
                  text: '${blood.fName} ${blood.lName}',
                  fontWeight: AppMeasures.mediumWeight,
                  fontSize: AppMeasures.mediumTextSize,
                ),
              ),
              DataCell(
                controller.userType == '2'
                    ? CommonClickableTextWidget(
                        title: AppStrings.contactAdmin,
                        textColor: AppColors.themeColor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.themeColor),
                        fontSize: AppMeasures.smallTextSize,
                        padding: const EdgeInsets.all(5),
                        onTap: () {
                          Get.toNamed(Routes.CONTACT_US);
                        })
                    : CommonTextWidget(
                        text: blood.mobileNo ?? '',
                        fontWeight: AppMeasures.mediumWeight,
                        fontSize: AppMeasures.mediumTextSize,
                      ),
              ),
              DataCell(
                CommonTextWidget(
                  text: blood.gender ?? '',
                  fontWeight: AppMeasures.mediumWeight,
                  fontSize: AppMeasures.mediumTextSize,
                ),
              ),
              DataCell(
                CommonTextWidget(
                  text: '${blood.houseName ?? ''} - ${blood.place ?? ''}',
                  fontWeight: AppMeasures.mediumWeight,
                  fontSize: AppMeasures.mediumTextSize,
                ),
              ),
            ],
          );
        }).toList());
  }
}
