import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mahall_manager/domain/core/interfaces/common_alert.dart';
import 'package:mahall_manager/infrastructure/theme/colors/app_colors.dart';
import 'package:mahall_manager/infrastructure/theme/measures/app_measures.dart';
import 'package:mahall_manager/presentation/common_widgets/common_text_form_field.dart';
import 'package:mahall_manager/presentation/common_widgets/common_text_widget.dart';

import '../../../../infrastructure/navigation/routes.dart';
import '../../../../infrastructure/theme/strings/app_strings.dart';
import '../../../common_widgets/common_clickable_text_widget.dart';
import '../../controllers/home.controller.dart';

class UsersWidget extends StatelessWidget {
  const UsersWidget({super.key, required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommonTextFormField(
          suffixIcon: Icons.search,
          hint: AppStrings.search,
          textController: controller.userSearchController,
        ),
        const SizedBox(height: 20),
        _buildUserList(),
      ],
    );
  }

  Expanded _buildUserList() {
    return Expanded(
      child: Obx(
        () {
          final groupedUsers = controller.groupedUsers();
          return groupedUsers.isEmpty
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
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: groupedUsers.length,
                  itemBuilder: (context, index) {
                    final keyName = groupedUsers.keys.elementAt(index);
                    final houses = groupedUsers[keyName];

                    return Obx(
                      () => GestureDetector(
                        onTap: () {
                          controller.toggleExpansion(index);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          margin: const EdgeInsets.all(5),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: AppColors.blueGrey),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  CommonTextWidget(
                                    text: keyName, // Display house name
                                    color: AppColors.blueGrey,
                                  ),
                                  const Spacer(),
                                  Icon(
                                    controller.isExpandedList[index]
                                        ? Icons.expand_less
                                        : Icons.expand_more,
                                    color: AppColors.blueGrey,
                                  ),
                                  const SizedBox(width: 10),
                                  IconButton(
                                    icon: Icon(
                                      Icons.delete_outline_rounded,
                                      color: AppColors.darkRed,
                                    ),
                                    onPressed: () {
                                      CommonAlert.alertDialogWidget(
                                          onConfirm: () {},
                                          onCancel: () {},
                                          title: AppStrings.warning,
                                          textConfirm: AppStrings.delete,
                                          textCancel: AppStrings.cancel,
                                          middleText:
                                              AppStrings.areYouSureToDelete);
                                    },
                                  ),
                                ],
                              ),
                              if (controller.isExpandedList[index])
                                Column(
                                  children: [
                                    const SizedBox(height: 10),
                                    // Wrap the DataTable in a horizontal SingleChildScrollView
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: DataTable(
                                        headingRowColor:
                                            WidgetStateProperty.all(
                                                AppColors.themeColor),
                                        columns: [
                                          DataColumn(
                                            label: CommonTextWidget(
                                              text: AppStrings.registerNo,
                                              fontSize:
                                                  AppMeasures.mediumTextSize,
                                              color: AppColors.white,
                                            ),
                                          ),
                                          DataColumn(
                                            label: CommonTextWidget(
                                              text: AppStrings.name,
                                              fontSize:
                                                  AppMeasures.mediumTextSize,
                                              color: AppColors.white,
                                            ),
                                          ),
                                          DataColumn(
                                            label: CommonTextWidget(
                                              text: AppStrings.mobileNo,
                                              fontSize:
                                                  AppMeasures.mediumTextSize,
                                              color: AppColors.white,
                                            ),
                                          ),
                                          DataColumn(
                                            label: CommonTextWidget(
                                              text: AppStrings.currentDue,
                                              fontSize:
                                                  AppMeasures.mediumTextSize,
                                              color: AppColors.white,
                                            ),
                                          ),
                                          DataColumn(
                                            label: CommonTextWidget(
                                              text: AppStrings.collect,
                                              fontSize:
                                                  AppMeasures.mediumTextSize,
                                              color: AppColors.white,
                                            ),
                                          ),
                                          DataColumn(
                                            label: CommonTextWidget(
                                              text: AppStrings.actions,
                                              fontSize:
                                                  AppMeasures.mediumTextSize,
                                              color: AppColors.white,
                                            ),
                                          ),
                                        ],
                                        rows: [
                                          ...houses!.map((house) {
                                            return DataRow(
                                              cells: [
                                                DataCell(CommonTextWidget(
                                                  text: house.userRegNo ?? '',
                                                  fontSize: AppMeasures
                                                      .mediumTextSize,
                                                  color: AppColors.black,
                                                )),
                                                DataCell(CommonTextWidget(
                                                  text:
                                                      '${house.fName} ${house.lName}',
                                                  fontSize: AppMeasures
                                                      .mediumTextSize,
                                                  color: AppColors.black,
                                                )),
                                                DataCell(CommonTextWidget(
                                                  text: house.phone ?? '',
                                                  fontSize: AppMeasures
                                                      .mediumTextSize,
                                                  color: AppColors.black,
                                                )),
                                                DataCell(CommonTextWidget(
                                                  text: house.due ?? '',
                                                  fontSize: AppMeasures
                                                      .mediumTextSize,
                                                  color: AppColors.black,
                                                )),
                                                DataCell(int.parse(
                                                            house.due ?? '0') >
                                                        0
                                                    ? CommonClickableTextWidget(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        border: Border.all(
                                                            color: AppColors
                                                                .darkRed),
                                                        textColor:
                                                            AppColors.darkRed,
                                                        title: AppStrings
                                                            .collectMoney,
                                                        onTap: () {
                                                          Get.toNamed(
                                                              Routes
                                                                  .PAYMENT_SCREEN,
                                                              arguments: {
                                                                'house': house,
                                                                'totalOrNot':
                                                                    false,
                                                              });
                                                        },
                                                      )
                                                    : CommonTextWidget(
                                                        text: AppStrings
                                                            .fullyPaid,
                                                        color: AppColors
                                                            .themeColor,
                                                      )),
                                                DataCell(
                                                  Row(
                                                    children: [
                                                      IconButton(
                                                        icon: Icon(
                                                          Icons
                                                              .edit_note_rounded,
                                                          color: AppColors
                                                              .blueGrey,
                                                        ),
                                                        onPressed: () async {
                                                          final updatedUser =
                                                              await Get.toNamed(
                                                                  Routes
                                                                      .REGISTRATION,
                                                                  arguments:
                                                                      house);
                                                          if (updatedUser !=
                                                              null) {
                                                            //controller.updateReportItem(updatedUser);
                                                          }
                                                        },
                                                      ),
                                                      IconButton(
                                                        icon: Icon(
                                                          Icons
                                                              .delete_outline_rounded,
                                                          color:
                                                              AppColors.darkRed,
                                                        ),
                                                        onPressed: () {
                                                          CommonAlert.alertDialogWidget(
                                                              onConfirm: () {},
                                                              onCancel: () {},
                                                              title: AppStrings
                                                                  .warning,
                                                              textConfirm:
                                                                  AppStrings
                                                                      .delete,
                                                              textCancel:
                                                                  AppStrings
                                                                      .cancel,
                                                              middleText: AppStrings
                                                                  .areYouSureToDelete);
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                              color: WidgetStateProperty.all(
                                                int.parse(house.due ?? '0') >
                                                        1000
                                                    ? AppColors.darkRed
                                                        .withOpacity(0.2)
                                                    : AppColors.white,
                                              ),
                                            );
                                          }),
                                          const DataRow(cells: [
                                            DataCell(SizedBox.shrink()),
                                            DataCell(SizedBox.shrink()),
                                            DataCell(SizedBox.shrink()),
                                            DataCell(SizedBox.shrink()),
                                            DataCell(SizedBox.shrink()),
                                            DataCell(SizedBox.shrink()),
                                          ]),
                                          DataRow(
                                            color: WidgetStateProperty.all(
                                              AppColors.themeColor
                                                  .withOpacity(0.2),
                                            ),
                                            cells: [
                                              const DataCell(SizedBox.shrink()),
                                              const DataCell(SizedBox.shrink()),
                                              DataCell(CommonTextWidget(
                                                text: houses[0].totalDue == '0'
                                                    ? AppStrings.noDues
                                                    : AppStrings.totalDue,
                                                fontSize:
                                                    AppMeasures.normalTextSize,
                                                color: AppColors.themeColor,
                                              )),
                                              DataCell(houses[0].totalDue == '0'
                                                  ? const SizedBox.shrink()
                                                  : CommonTextWidget(
                                                      text:
                                                          houses[0].totalDue ??
                                                              '',
                                                      fontSize: AppMeasures
                                                          .mediumTextSize,
                                                      color:
                                                          AppColors.themeColor,
                                                    )),
                                              DataCell(houses[0].totalDue == "0"
                                                  ? const SizedBox.shrink()
                                                  : CommonClickableTextWidget(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      border: Border.all(
                                                          color: AppColors
                                                              .themeColor),
                                                      textColor:
                                                          AppColors.themeColor,
                                                      title: AppStrings
                                                          .collectTotal,
                                                      onTap: () {
                                                        Get.toNamed(
                                                            Routes
                                                                .PAYMENT_SCREEN,
                                                            arguments: {
                                                              'house':
                                                                  houses[0],
                                                              'totalOrNot':
                                                                  true,
                                                            });
                                                      },
                                                    )),
                                              const DataCell(SizedBox.shrink()),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
