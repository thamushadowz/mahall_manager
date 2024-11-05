import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mahall_manager/infrastructure/theme/colors/app_colors.dart';
import 'package:mahall_manager/infrastructure/theme/measures/app_measures.dart';
import 'package:mahall_manager/presentation/common_widgets/common_clickable_text_widget.dart';
import 'package:mahall_manager/presentation/common_widgets/common_text_form_field.dart';
import 'package:mahall_manager/presentation/common_widgets/common_text_widget.dart';

import '../../../../infrastructure/theme/strings/app_strings.dart';
import '../../controllers/home.controller.dart';

class UsersWidget extends StatelessWidget {
  const UsersWidget({super.key, required this.controller});

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
          textController: controller.userSearchController,
          onFieldSubmitted: (val) {},
        ),
        const SizedBox(height: 20),
        _buildUserList(),
      ],
    );
  }

  Expanded _buildUserList() {
    return Expanded(
      child: Obx(() => controller.filteredUserDetails.isEmpty
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
          : ListView.builder(
              shrinkWrap: true,
              itemCount: controller.filteredUserDetails.length,
              itemBuilder: (context, index) {
                final house = controller.filteredUserDetails[index];
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
                                text:
                                    '${house.houseRegNo} - ${house.houseName}',
                                color: AppColors.blueGrey,
                              ),
                              const Spacer(),
                              Icon(
                                controller.isExpandedList[index]
                                    ? Icons.expand_less
                                    : Icons.expand_more,
                                color: AppColors.blueGrey,
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
                                    headingRowColor: WidgetStateProperty.all(
                                        AppColors.themeColor),
                                    columns: [
                                      DataColumn(
                                        label: CommonTextWidget(
                                          text: "Register No",
                                          fontSize: AppMeasures.mediumTextSize,
                                          color: AppColors.white,
                                        ),
                                      ),
                                      DataColumn(
                                        label: CommonTextWidget(
                                          text: "Name",
                                          fontSize: AppMeasures.mediumTextSize,
                                          color: AppColors.white,
                                        ),
                                      ),
                                      DataColumn(
                                        label: CommonTextWidget(
                                          text: "Phone",
                                          fontSize: AppMeasures.mediumTextSize,
                                          color: AppColors.white,
                                        ),
                                      ),
                                      DataColumn(
                                        label: CommonTextWidget(
                                          text: "Current Due",
                                          fontSize: AppMeasures.mediumTextSize,
                                          color: AppColors.white,
                                        ),
                                      ),
                                      DataColumn(
                                        label: CommonTextWidget(
                                          text: "Collect",
                                          fontSize: AppMeasures.mediumTextSize,
                                          color: AppColors.white,
                                        ),
                                      ),
                                    ],
                                    rows: [
                                      // Generate rows for each person in the list
                                      ...house.people!.map((person) {
                                        return DataRow(
                                          cells: [
                                            DataCell(CommonTextWidget(
                                              text: person.userRegNo ?? '',
                                              fontSize:
                                                  AppMeasures.mediumTextSize,
                                              color: AppColors.black,
                                            )),
                                            DataCell(CommonTextWidget(
                                              text: person.name ?? '',
                                              fontSize:
                                                  AppMeasures.mediumTextSize,
                                              color: AppColors.black,
                                            )),
                                            DataCell(CommonTextWidget(
                                              text: person.phone ?? '',
                                              fontSize:
                                                  AppMeasures.mediumTextSize,
                                              color: AppColors.black,
                                            )),
                                            DataCell(CommonTextWidget(
                                              text: person.due ?? '',
                                              fontSize:
                                                  AppMeasures.mediumTextSize,
                                              color: AppColors.black,
                                            )),
                                            DataCell(int.parse(
                                                        person.due ?? '0') >
                                                    0
                                                ? CommonClickableTextWidget(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    border: Border.all(
                                                        color:
                                                            AppColors.darkRed),
                                                    textColor:
                                                        AppColors.darkRed,
                                                    title:
                                                        AppStrings.collectMoney,
                                                    onTap: () {},
                                                  )
                                                : CommonTextWidget(
                                                    text: 'Fully Paid',
                                                    color: AppColors.themeColor,
                                                  )),
                                          ],
                                          color: WidgetStateProperty.all(
                                              int.parse(person.due ?? '0') >
                                                      1000
                                                  ? AppColors.darkRed
                                                      .withOpacity(0.2)
                                                  : AppColors.white),
                                        );
                                      }),
                                      const DataRow(cells: [
                                        DataCell(
                                          SizedBox.shrink(),
                                        ),
                                        DataCell(
                                          SizedBox.shrink(),
                                        ),
                                        DataCell(
                                          SizedBox.shrink(),
                                        ),
                                        DataCell(
                                          SizedBox.shrink(),
                                        ),
                                        DataCell(
                                          SizedBox.shrink(),
                                        ),
                                      ]),
                                      DataRow(
                                        color: WidgetStateProperty.all(AppColors
                                            .themeColor
                                            .withOpacity(0.2)),
                                        cells: [
                                          const DataCell(SizedBox.shrink()),
                                          const DataCell(SizedBox.shrink()),
                                          DataCell(CommonTextWidget(
                                            text: controller.calculateTotalDue(
                                                        house.people!) ==
                                                    0
                                                ? AppStrings.noDues
                                                : AppStrings.totalDue,
                                            fontSize:
                                                AppMeasures.normalTextSize,
                                            color: AppColors.themeColor,
                                          )),
                                          DataCell(controller.calculateTotalDue(
                                                      house.people!) ==
                                                  0
                                              ? const SizedBox.shrink()
                                              : CommonTextWidget(
                                                  text:
                                                      ' ${controller.calculateTotalDue(house.people!)}',
                                                  fontSize: AppMeasures
                                                      .mediumTextSize,
                                                  color: AppColors.themeColor,
                                                )),
                                          DataCell(controller.calculateTotalDue(
                                                      house.people!) ==
                                                  0
                                              ? const SizedBox.shrink()
                                              : CommonClickableTextWidget(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                      color:
                                                          AppColors.themeColor),
                                                  textColor:
                                                      AppColors.themeColor,
                                                  title:
                                                      AppStrings.collectTotal,
                                                  onTap: () {},
                                                )),
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
            )),
    );
  }
}
