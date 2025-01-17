import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mahall_manager/domain/listing/models/get_house_and_users_model.dart';
import 'package:mahall_manager/presentation/common_widgets/common_text_form_field.dart';

import '../../../../domain/core/interfaces/common_alert.dart';
import '../../../../infrastructure/navigation/routes.dart';
import '../../../../infrastructure/theme/colors/app_colors.dart';
import '../../../../infrastructure/theme/measures/app_measures.dart';
import '../../../../infrastructure/theme/strings/app_strings.dart';
import '../../../common_widgets/common_clickable_text_widget.dart';
import '../../../common_widgets/common_empty_result_widget.dart';
import '../../../common_widgets/common_text_field_shimmer_widget.dart';
import '../../../common_widgets/common_text_widget.dart';
import '../../controllers/home.controller.dart';
import '../single_user_widget.dart';

class UsersWidget extends StatelessWidget {
  const UsersWidget({super.key, required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return controller.userType == '2'
        ? SingleUserWidget(controller: controller)
        : Obx(
            () => Column(
              children: [
                controller.userDetails.isEmpty &&
                        controller.userSearchController.text.isEmpty
                    ? const SizedBox.shrink()
                    : Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CommonTextFormField(
                          suffixIcon: Icons.search,
                          hint: AppStrings.search,
                          textInputAction: TextInputAction.search,
                          textController: controller.userSearchController,
                          onSuffixTap: () {
                            controller.userPage.value = 1;
                            controller.userDetails.clear();
                            controller.getUserDetails();
                          },
                          onFieldSubmitted: (val) {
                            controller.userPage.value = 1;
                            controller.userDetails.clear();
                            controller.getUserDetails();
                          },
                        ),
                      ),
                _buildUserList(context),
              ],
            ),
          );
  }

  Expanded _buildUserList(BuildContext context) {
    return Expanded(
      child: RefreshIndicator(
        color: AppColors.themeColor,
        backgroundColor: AppColors.white,
        onRefresh: () {
          controller.userPage.value = 1;
          controller.userDetails.clear();
          return controller.getUserDetails();
        },
        child: Obx(
          () {
            final groupedUsers = controller.groupedUsers();
            return SingleChildScrollView(
              controller: controller.userScrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              child: controller.isUsersListLoading.value
                  ? ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 20,
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(10),
                      itemBuilder: (context, index) {
                        return const CommonTextFieldShimmerWidget(
                          margin: EdgeInsets.all(7),
                          height: 80,
                        );
                      })
                  : groupedUsers.isEmpty
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height * 0.8,
                          child: const CommonEmptyResultWidget())
                      : ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: groupedUsers.length +
                              (controller.isUsersListLoadingMore.value ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index == groupedUsers.length &&
                                controller.isUsersListLoadingMore.value) {
                              return const CommonTextFieldShimmerWidget();
                            }

                            final keyName = groupedUsers.keys.elementAt(index);
                            final houses = groupedUsers[keyName];

                            return Obx(
                              () => GestureDetector(
                                onTap: () {
                                  controller.toggleExpansion(index);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(15),
                                  margin: const EdgeInsets.only(
                                      left: 10, right: 10, top: 5, bottom: 5),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: AppColors.white.withOpacity(0.8),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.55,
                                            child: CommonTextWidget(
                                              text: keyName.split(' : ').first,
                                              color: AppColors.black,
                                            ),
                                          ),
                                          const Spacer(),
                                          Icon(
                                            controller.isExpandedList[index]
                                                ? Icons.expand_less
                                                : Icons.expand_more,
                                            color: AppColors.black,
                                          ),
                                          const SizedBox(width: 10),
                                          IconButton(
                                            icon: Icon(
                                              Icons.edit_note_rounded,
                                              color: AppColors.black,
                                            ),
                                            onPressed: () {
                                              Get.toNamed(
                                                  Routes.HOUSE_REGISTRATION,
                                                  arguments: {
                                                    'key_name': keyName,
                                                    'is_from_edit': true
                                                  })?.then((onValue) {
                                                if (onValue != null &&
                                                    onValue == true) {
                                                  controller.userPage.value = 1;
                                                  controller.userDetails
                                                      .clear();
                                                  controller.getUserDetails();
                                                }
                                              });
                                            },
                                          ),
                                          const SizedBox(width: 10),
                                          IconButton(
                                            icon: Icon(
                                              Icons.delete_outline_rounded,
                                              color: AppColors.darkRed,
                                            ),
                                            onPressed: () {
                                              showCommonDialog(context,
                                                  message: AppStrings
                                                      .areYouSureToDelete,
                                                  yesButtonName:
                                                      AppStrings.delete,
                                                  messageColor: AppColors
                                                      .darkRed, onYesTap: () {
                                                Get.close(0);
                                                controller.deleteHouse(
                                                    int.parse(keyName
                                                        .split(' : ')
                                                        .last
                                                        .trim()));
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                      if (controller.isExpandedList[index])
                                        Column(
                                          children: [
                                            const SizedBox(height: 10),
                                            SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: _buildDataTable(
                                                  houses, context),
                                            ),
                                          ],
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
            );
          },
        ),
      ),
    );
  }

  DataTable _buildDataTable(List<PeopleData>? houses, BuildContext context) {
    return DataTable(
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
        DataColumn(
          label: CommonTextWidget(
            text: AppStrings.collect,
            fontSize: AppMeasures.mediumTextSize,
            color: AppColors.white,
          ),
        ),
        DataColumn(
          label: CommonTextWidget(
            text: AppStrings.actions,
            fontSize: AppMeasures.mediumTextSize,
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
                fontSize: AppMeasures.mediumTextSize,
                color: AppColors.black,
              )),
              DataCell(CommonTextWidget(
                text: '${house.fName} ${house.lName}',
                fontSize: AppMeasures.mediumTextSize,
                color: AppColors.black,
              )),
              DataCell(CommonTextWidget(
                text: house.phone ?? '',
                fontSize: AppMeasures.mediumTextSize,
                color: AppColors.black,
              )),
              DataCell(CommonTextWidget(
                text: house.due ?? '',
                fontSize: AppMeasures.mediumTextSize,
                color: AppColors.black,
              )),
              DataCell(int.parse(house.due ?? '0') > 0
                  ? CommonClickableTextWidget(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.darkRed),
                      textColor: AppColors.darkRed,
                      title: AppStrings.collectMoney,
                      onTap: () {
                        Get.toNamed(Routes.PAYMENT_SCREEN, arguments: {
                          'house': house,
                          'totalOrNot': false,
                        })?.then((onValue) {
                          controller.userPage.value = 1;
                          controller.userDetails.clear();
                          controller.reportPage.value = 1;
                          controller.reportsDetails.clear();
                          controller.getUserDetails();
                          controller.getReportsDetails();
                        });
                      },
                    )
                  : CommonTextWidget(
                      text: int.parse(house.due ?? '0') == 0
                          ? AppStrings.fullyPaid
                          : AppStrings.advancePaid,
                      color: int.parse(house.due ?? '0') == 0
                          ? AppColors.themeColor
                          : AppColors.blue,
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
                        final updatedUser = await Get.toNamed(
                                Routes.REGISTRATION,
                                arguments: house)
                            ?.then((onValue) {
                          if (onValue != null && onValue == true) {
                            controller.userPage.value = 1;
                            controller.userDetails.clear();
                            controller.getUserDetails();
                          }
                        });
                        if (updatedUser != null) {
                          //controller.updateReportItem(updatedUser);
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
                            messageColor: AppColors.darkRed, onYesTap: () {
                          Get.close(0);
                          controller.deleteUser(house.id!.toInt());
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
            color: WidgetStateProperty.all(
              int.parse(house.due ?? '0') > 2000
                  ? AppColors.darkRed.withOpacity(0.2)
                  : int.parse(house.due ?? '0') < 0
                      ? AppColors.blue.withOpacity(0.2)
                      : AppColors.white.withOpacity(0.2),
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
            AppColors.themeColor.withOpacity(0.2),
          ),
          cells: [
            const DataCell(SizedBox.shrink()),
            const DataCell(SizedBox.shrink()),
            DataCell(CommonTextWidget(
              text: houses[0].totalDue == '0'
                  ? AppStrings.noDues
                  : AppStrings.totalDue,
              fontSize: AppMeasures.normalTextSize,
              color: AppColors.themeColor,
            )),
            DataCell(houses[0].totalDue == '0'
                ? const SizedBox.shrink()
                : CommonTextWidget(
                    text: houses[0].totalDue ?? '0',
                    fontSize: AppMeasures.mediumTextSize,
                    color: AppColors.themeColor,
                  )),
            DataCell(houses[0].totalDue == "0"
                ? const SizedBox.shrink()
                : CommonClickableTextWidget(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.themeColor),
                    textColor: AppColors.themeColor,
                    title: AppStrings.collectTotal,
                    onTap: () {
                      Get.toNamed(Routes.PAYMENT_SCREEN, arguments: {
                        'house': houses[0],
                        'totalOrNot': true,
                      })?.then((onValue) {
                        controller.userPage.value = 1;
                        controller.userDetails.clear();
                        controller.reportPage.value = 1;
                        controller.reportsDetails.clear();
                        controller.getUserDetails();
                        controller.getReportsDetails();
                      });
                    },
                  )),
            const DataCell(SizedBox.shrink()),
          ],
        ),
      ],
    );
  }
}
