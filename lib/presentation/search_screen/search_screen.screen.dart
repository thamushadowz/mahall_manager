import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mahall_manager/infrastructure/theme/colors/app_colors.dart';
import 'package:mahall_manager/infrastructure/theme/measures/app_measures.dart';
import 'package:mahall_manager/presentation/common_widgets/common_empty_result_widget.dart';
import 'package:mahall_manager/presentation/common_widgets/common_text_widget.dart';

import '../../infrastructure/theme/strings/app_strings.dart';
import '../common_widgets/common_appbar_widget.dart';
import '../common_widgets/common_text_form_field.dart';
import 'controllers/search_screen.controller.dart';

class SearchScreenScreen extends GetView<SearchScreenController> {
  const SearchScreenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CommonAppbarWidget(
        title: AppStrings.search,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              _buildSearchField(),
              const SizedBox(height: 15),
              Expanded(
                child: Obx(() {
                  return controller.filteredList.isEmpty
                      ? const CommonEmptyResultWidget()
                      : _buildResultList();
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Search input field
  Widget _buildSearchField() {
    return CommonTextFormField(
      hint: AppStrings.search,
      textController: controller.searchController,
      onFieldSubmitted: (value) => controller.filterList(value!),
      suffixIcon: Icons.search,
      onSuffixTap: () {
        controller.filterList(controller.searchController.text);
      },
    );
  }

  /// List of results
  Widget _buildResultList() {
    return ListView.separated(
      itemCount: controller.filteredList.length,
      itemBuilder: (context, index) {
        return _buildListItem(index);
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          thickness: 1,
          color: AppColors.lightGrey.withOpacity(0.5),
        );
      },
    );
  }

  /// Individual list item
  GestureDetector _buildListItem(int index) {
    return GestureDetector(
      onTap: () {
        Get.back(result: controller.filteredList[index]);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        decoration: BoxDecoration(
          color: AppColors.lightGrey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(
              Icons.star_border_rounded,
              size: 24,
              color: AppColors.themeColor,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: CommonTextWidget(
                text: controller.filteredList[index].name,
                fontSize: AppMeasures.mediumTextSize,
                fontWeight: AppMeasures.mediumWeight,
                color: AppColors.blueGrey,
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.grey),
          ],
        ),
      ),
    );
  }
}
