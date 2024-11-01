import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mahall_manager/infrastructure/theme/colors/app_colors.dart';
import 'package:mahall_manager/infrastructure/theme/measures/app_measures.dart';
import 'package:mahall_manager/presentation/common_widgets/common_clickable_text_widget.dart';
import 'package:mahall_manager/presentation/common_widgets/common_text_form_field.dart';
import 'package:mahall_manager/presentation/common_widgets/common_text_widget.dart';

import '../../controllers/home.controller.dart';

class UsersWidget extends StatelessWidget {
  const UsersWidget({super.key, required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommonTextFormField(
          inputFormatters: [],
          suffixIcon: Icons.search,
          textController: TextEditingController(),
          onFieldSubmitted: (val) {},
        ),
        const SizedBox(height: 20),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: controller.userDetails.length,
            itemBuilder: (context, index) {
              final house = controller.userDetails[index];
              return Obx(() => GestureDetector(
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
                                    rows: house.people!.map((person) {
                                      return DataRow(
                                        cells: [
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
                                          DataCell(
                                              int.parse(person.due ?? '') > 0
                                                  ? CommonClickableTextWidget(
                                                      textColor:
                                                          AppColors.darkRed,
                                                      title: 'Collect money',
                                                      onTap: () {},
                                                    )
                                                  : const SizedBox()),
                                        ],
                                        color: WidgetStateProperty.all(
                                            int.parse(person.due ?? '') > 1000
                                                ? AppColors.darkRed
                                                    .withOpacity(0.3)
                                                : AppColors.white),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ));
            },
          ),
        ),
      ],
    );
  }
}
