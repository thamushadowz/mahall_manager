import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mahall_manager/infrastructure/theme/measures/app_measures.dart';
import 'package:mahall_manager/presentation/common_widgets/common_empty_result_widget.dart';
import 'package:mahall_manager/presentation/common_widgets/common_text_widget.dart';
import 'package:mahall_manager/presentation/home/controllers/home.controller.dart';
import 'package:shimmer/shimmer.dart';

import '../../../infrastructure/theme/colors/app_colors.dart';
import '../../../infrastructure/theme/strings/app_strings.dart';

class SingleUserWidget extends StatelessWidget {
  const SingleUserWidget({super.key, required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/dark_background.png'),
              fit: BoxFit.cover)),
      child: Obx(
        () => controller.isLoading.value
            ? Center(
                child: Image.asset(
                  'assets/images/spin_loader.gif',
                  width: 70,
                  height: 70,
                ),
              )
            : RefreshIndicator(
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: controller.userDetails.isEmpty
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height * 0.8,
                          child: const CommonEmptyResultWidget())
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 20),
                            _buildMahallName(),
                            const SizedBox(height: 20),
                            _buildUserTable(),
                            controller.promisesDetails.isEmpty
                                ? const SizedBox.shrink()
                                : const SizedBox(height: 50),
                            controller.promisesDetails.isEmpty
                                ? const SizedBox.shrink()
                                : _buildPromisesWidget(context),
                            const SizedBox(height: 20),
                          ],
                        ),
                ),
                onRefresh: () {
                  controller.getSingleHousePromises();
                  return controller.getSingleHouseAndUsers();
                }),
      ),
    );
  }

  _buildMahallName() {
    return Column(
      children: [
        Shimmer.fromColors(
          baseColor: Colors.green,
          highlightColor: Colors.red,
          child: Obx(
            () => CommonTextWidget(
              text: controller.mahallName.value,
              textAlign: TextAlign.center,
              fontSize: AppMeasures.bigTextSize,
            ),
          ),
        ),
        Shimmer.fromColors(
          baseColor: Colors.green,
          highlightColor: Colors.red,
          child: const Divider(indent: 10, endIndent: 10),
        )
      ],
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
            text:
                '${controller.userDetails.first.houseRegNo ?? 'KNY01'} - ${controller.userDetails.first.houseName ?? 'White House'}',
            fontSize: AppMeasures.bigTextSize,
            color: AppColors.white,
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            headingRowColor: WidgetStateProperty.all(AppColors.themeColor),
            dataRowColor:
                WidgetStateProperty.all(AppColors.white.withOpacity(0.8)),
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
              ...controller.userDetails.map((user) {
                return DataRow(
                  color:
                      WidgetStateProperty.all(AppColors.white.withOpacity(0.8)),
                  cells: [
                    DataCell(CommonTextWidget(
                      text: user.userRegNo ?? '',
                      fontSize: AppMeasures.mediumTextSize,
                      color: AppColors.black,
                    )),
                    DataCell(CommonTextWidget(
                      text: '${user.fName ?? ''} ${user.lName ?? ''}',
                      fontSize: AppMeasures.mediumTextSize,
                      color: AppColors.black,
                    )),
                    DataCell(CommonTextWidget(
                      text: user.phone ?? '',
                      fontSize: AppMeasures.mediumTextSize,
                      color: AppColors.black,
                    )),
                    DataCell(CommonTextWidget(
                      text: user.due ?? '',
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
                );
              }),
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
                  AppColors.themeColor,
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
                    color: AppColors.white,
                  )),
                  DataCell(
                      /*houses[0].totalDue == '0'
                        ? const SizedBox.shrink()
                        : */
                      CommonTextWidget(
                    text: controller.userDetails.first.totalDue ?? '5600',
                    fontSize: AppMeasures.mediumTextSize,
                    color: AppColors.white,
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

  _buildPromisesWidget(BuildContext context) {
    return Column(
      children: [
        CommonTextWidget(
            color: AppColors.white,
            text: '${AppStrings.promises} (${AppStrings.vagdhanangal})'),
        const Divider(),
        _buildDataTable(context),
      ],
    );
  }

  Widget _buildDataTable(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 20,
        headingRowColor: WidgetStateProperty.all(AppColors.themeColor),
        dataRowColor: WidgetStateProperty.all(AppColors.white.withOpacity(0.8)),
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
          /*DataColumn(
            label: CommonTextWidget(
              text: AppStrings.actions,
              fontWeight: AppMeasures.mediumWeight,
              fontSize: AppMeasures.mediumTextSize,
              color: AppColors.white,
            ),
          ),*/
        ],
        rows: controller.promisesDetails.map((promises) {
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
              /*DataCell(
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
              ),*/
            ],
          );
        }).toList(),
      ),
    );
  }
}
