import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mahall_manager/presentation/common_widgets/common_empty_result_widget.dart';
import 'package:mahall_manager/presentation/common_widgets/common_text_field_shimmer_widget.dart';

import '../../infrastructure/theme/colors/app_colors.dart';
import '../../infrastructure/theme/measures/app_measures.dart';
import '../../infrastructure/theme/strings/app_strings.dart';
import '../common_widgets/common_appbar_widget.dart';
import '../common_widgets/common_text_form_field.dart';
import '../common_widgets/common_text_widget.dart';
import 'controllers/death_list.controller.dart';

class DeathListScreen extends GetView<DeathListController> {
  const DeathListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: CommonAppbarWidget(
          title: AppStrings.listOfDeceased,
        ),
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/dark_background.png'),
                  fit: BoxFit.cover)),
          child: Obx(
              () => !controller.isLoading.value && controller.deathList.isEmpty
                  ? const CommonEmptyResultWidget()
                  : Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: CommonTextFormField(
                            suffixIcon: Icons.search,
                            textController: controller.deathSearchController,
                          ),
                        ),
                        _buildDeceasedList(),
                      ],
                    )),
        ),
      ),
    );
  }

  _buildDeceasedList() {
    return Obx(
      () => Expanded(
        child: ListView.separated(
            separatorBuilder: (context, index) {
              return const Divider();
            },
            padding: const EdgeInsets.all(10),
            itemCount: controller.isLoading.value
                ? 20
                : controller.filteredDeathList.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return controller.isLoading.value
                  ? const Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: CommonTextFieldShimmerWidget(),
                    )
                  : _buildItemView(index);
            }),
      ),
    );
  }

  _buildItemView(int index) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.white.withOpacity(0.8)),
      child: CommonTextWidget(
        text:
            '${controller.filteredDeathList[index].personName} : ${controller.filteredDeathList[index].houseRegNo} - ${controller.filteredDeathList[index].houseName}',
        fontSize: AppMeasures.mediumTextSize,
        fontWeight: AppMeasures.mediumWeight,
      ),
    );
  }
}
