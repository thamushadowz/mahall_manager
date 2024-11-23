import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mahall_manager/presentation/home/controllers/home.controller.dart';

import '../../../../domain/core/interfaces/common_alert.dart';
import '../../../../infrastructure/navigation/routes.dart';
import '../../../../infrastructure/theme/colors/app_colors.dart';
import '../../../../infrastructure/theme/measures/app_measures.dart';
import '../../../../infrastructure/theme/strings/app_strings.dart';
import '../../../common_widgets/common_clickable_text_widget.dart';
import '../../../common_widgets/common_empty_result_widget.dart';
import '../../../common_widgets/common_text_form_field.dart';
import '../../../common_widgets/common_text_widget.dart';

class PromisesWidget extends StatelessWidget {
  const PromisesWidget({super.key, required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => controller.promisesDetails.isEmpty
              ? const SizedBox.shrink()
              : Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CommonTextFormField(
                    suffixIcon: Icons.search,
                    textController: controller.promisesSearchController,
                  ),
                ),
        ),
        _buildPromisesList(context),
        controller.promisesDetails.isEmpty
            ? const SizedBox.shrink()
            : _buildTotalWidget(),
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

  Expanded _buildPromisesList(BuildContext context) {
    return Expanded(
        child: RefreshIndicator(
      onRefresh: () {
        return controller.getPromisesDetails();
      },
      child: Obx(
        () => SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: controller.filteredPromisesDetails.isEmpty
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
    ));
  }

  Widget _buildDataTable(BuildContext context) {
    return DataTable(
      columnSpacing: 20,
      headingRowColor: WidgetStateProperty.all(AppColors.themeColor),
      columns: [
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
              text:
                  '${promises.userRegNo} - ${promises.fName} ${promises.lName}',
              fontWeight: AppMeasures.mediumWeight,
              fontSize: AppMeasures.mediumTextSize,
            )),
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
              text: controller.getAddedBy(promises.addedBy.toString()),
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
                      Get.toNamed(Routes.PAYMENT_SCREEN,
                          arguments: {'promises': promises});
                    },
                  ),
                  //Edit
                  IconButton(
                    icon: Icon(
                      Icons.edit_note_rounded,
                      color: AppColors.blueGrey,
                    ),
                    onPressed: () async {
                      Get.toNamed(Routes.PROMISES, arguments: promises)
                          ?.then((onValue) {
                        controller.getPromisesDetails();
                      });
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
                          messageColor: AppColors.darkRed, onYesTap: () {
                        controller.deletePromises(promises.id!);
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
    );
  }
}
