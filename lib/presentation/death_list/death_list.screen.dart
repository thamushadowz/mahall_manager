import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        body: Column(
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
        ),
      ),
    );
  }

  _buildDeceasedList() {
    return Expanded(
      child: ListView.separated(
          separatorBuilder: (context, index) {
            return const Divider();
          },
          padding: const EdgeInsets.all(10),
          itemCount: 20,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return _buildItemView(index);
          }),
    );
  }

  _buildItemView(int index) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.lightGrey.withOpacity(0.2)),
      child: CommonTextWidget(
        text: 'Name ${index + 1}',
        fontSize: AppMeasures.mediumTextSize,
        fontWeight: AppMeasures.mediumWeight,
      ),
    );
  }
}
