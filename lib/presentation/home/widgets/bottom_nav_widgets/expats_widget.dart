import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mahall_manager/presentation/home/widgets/user_profile_widget.dart';

import '../../../../infrastructure/navigation/routes.dart';
import '../../../../infrastructure/theme/colors/app_colors.dart';
import '../../../../infrastructure/theme/measures/app_measures.dart';
import '../../../../infrastructure/theme/strings/app_strings.dart';
import '../../../common_widgets/common_clickable_text_widget.dart';
import '../../../common_widgets/common_empty_result_widget.dart';
import '../../../common_widgets/common_text_form_field.dart';
import '../../../common_widgets/common_text_widget.dart';
import '../../controllers/home.controller.dart';

class ExpatsWidget extends StatelessWidget {
  const ExpatsWidget({super.key, required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return controller.userType == '2'
        ? UserProfileWidget(controller: controller)
        : Obx(
            () => Column(
              children: [
                controller.expatDetails.isEmpty
                    ? const SizedBox.shrink()
                    : Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CommonTextFormField(
                          suffixIcon: Icons.search,
                          textController: controller.expatSearchController,
                        ),
                      ),
                _buildExpatsList(context),
              ],
            ),
          );
  }

  Expanded _buildExpatsList(BuildContext context) {
    return Expanded(
      child: RefreshIndicator(
        color: AppColors.themeColor,
        backgroundColor: AppColors.white,
        onRefresh: () {
          return controller.getExpatsDetails();
        },
        child: Obx(() => SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: controller.filteredExpatDetails.isEmpty
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: const CommonEmptyResultWidget())
                  : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: _buildDataTable(),
                      ),
                    ),
            )),
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
              text: AppStrings.country,
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
              text: AppStrings.houseNameAndPlace,
              fontWeight: AppMeasures.mediumWeight,
              fontSize: AppMeasures.mediumTextSize,
              color: AppColors.white,
            ),
          ),
        ],
        rows: controller.filteredExpatDetails.map((expat) {
          return DataRow(
            cells: [
              DataCell(
                CommonTextWidget(
                  text: expat.userRegNo ?? '',
                  fontSize: AppMeasures.mediumTextSize,
                ),
              ),
              DataCell(
                CommonTextWidget(
                  text: expat.country ?? '',
                  fontSize: AppMeasures.mediumTextSize,
                ),
              ),
              DataCell(
                CommonTextWidget(
                  text: '${expat.fName} ${expat.lName}',
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
                        text: expat.mobileNo ?? '',
                        fontWeight: AppMeasures.mediumWeight,
                        fontSize: AppMeasures.mediumTextSize,
                      ),
              ),
              DataCell(
                CommonTextWidget(
                  text: '${expat.houseName ?? ''} - ${expat.place ?? ''}',
                  fontWeight: AppMeasures.mediumWeight,
                  fontSize: AppMeasures.mediumTextSize,
                ),
              ),
            ],
          );
        }).toList());
  }
}
