import 'package:flutter/material.dart';
import 'package:mahall_manager/infrastructure/theme/measures/app_measures.dart';
import 'package:mahall_manager/presentation/common_widgets/common_text_widget.dart';
import 'package:mahall_manager/presentation/home/controllers/home.controller.dart';

import '../../../infrastructure/theme/colors/app_colors.dart';
import '../../../infrastructure/theme/strings/app_strings.dart';

class SingleUserWidget extends StatelessWidget {
  const SingleUserWidget({super.key, required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildUserTable(),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  _buildUserTable() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border.all(
            color: AppColors.themeColor,
            width: 2,
          )),
          child: CommonTextWidget(
            text: 'KNY01 - White House',
            fontSize: AppMeasures.bigTextSize,
            color: AppColors.themeColor,
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            headingRowColor: WidgetStateProperty.all(AppColors.themeColor),
            columns: [
              DataColumn(
                label: CommonTextWidget(
                  text: AppStrings.registerNo,
                  fontSize: AppMeasures.mediumTextSize,
                  color: AppColors.white,
                ),
              ),
              DataColumn(
                label: CommonTextWidget(
                  text: AppStrings.name,
                  fontSize: AppMeasures.mediumTextSize,
                  color: AppColors.white,
                ),
              ),
              DataColumn(
                label: CommonTextWidget(
                  text: AppStrings.mobileNo,
                  fontSize: AppMeasures.mediumTextSize,
                  color: AppColors.white,
                ),
              ),
              DataColumn(
                label: CommonTextWidget(
                  text: AppStrings.currentDue,
                  fontSize: AppMeasures.mediumTextSize,
                  color: AppColors.white,
                ),
              ),
              /*DataColumn(
                  label: CommonTextWidget(
                    text: AppStrings.payNow,
                    fontSize:
                    AppMeasures.mediumTextSize,
                    color: AppColors.white,
                  ),
                ),*/
              /*DataColumn(
                  label: CommonTextWidget(
                    text: AppStrings.actions,
                    fontSize:
                    AppMeasures.mediumTextSize,
                    color: AppColors.white,
                  ),
                ),*/
            ],
            rows: [
              DataRow(
                cells: [
                  DataCell(CommonTextWidget(
                    text: 'U01',
                    fontSize: AppMeasures.mediumTextSize,
                    color: AppColors.black,
                  )),
                  DataCell(CommonTextWidget(
                    text: 'Shameer Muhammed',
                    fontSize: AppMeasures.mediumTextSize,
                    color: AppColors.black,
                  )),
                  DataCell(CommonTextWidget(
                    text: '+918745632712',
                    fontSize: AppMeasures.mediumTextSize,
                    color: AppColors.black,
                  )),
                  DataCell(CommonTextWidget(
                    text: '5600',
                    fontSize: AppMeasures.mediumTextSize,
                    color: AppColors.black,
                  )),
                  /*DataCell(int.parse(
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
                    )),*/
                  /*DataCell(
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
                              showCommonDialog(
                                  context,
                                  title: AppStrings
                                      .warning,
                                  message: AppStrings
                                      .areYouSureToDelete,
                                  yesButtonName:
                                  AppStrings
                                      .delete,
                                  messageColor:
                                  AppColors
                                      .darkRed,
                                  onYesTap: () {});
                            },
                          ),
                        ],
                      ),
                    ),*/
                ],
                color: WidgetStateProperty.all(
                  AppColors.white,
                ),
              ),
              const DataRow(cells: [
                DataCell(SizedBox.shrink()),
                DataCell(SizedBox.shrink()),
                DataCell(SizedBox.shrink()),
                DataCell(SizedBox.shrink()),
                /*DataCell(SizedBox.shrink()),
                  DataCell(SizedBox.shrink()),*/
              ]),
              DataRow(
                color: WidgetStateProperty.all(
                  AppColors.themeColor.withOpacity(0.2),
                ),
                cells: [
                  const DataCell(SizedBox.shrink()),
                  const DataCell(SizedBox.shrink()),
                  DataCell(CommonTextWidget(
                    text: /*houses[0].totalDue == '0'
                          ? AppStrings.noDues
                          : */
                        AppStrings.totalDue,
                    fontSize: AppMeasures.normalTextSize,
                    color: AppColors.themeColor,
                  )),
                  DataCell(
                      /*houses[0].totalDue == '0'
                        ? const SizedBox.shrink()
                        : */
                      CommonTextWidget(
                    text:
                        /*houses[0].totalDue ??*/
                        '5600',
                    fontSize: AppMeasures.mediumTextSize,
                    color: AppColors.themeColor,
                  )),
                  /*DataCell(houses[0].totalDue == "0"
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
                    )),*/
                  /*const DataCell(SizedBox.shrink()),*/
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}