import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mahall_manager/infrastructure/theme/colors/app_colors.dart';
import 'package:mahall_manager/infrastructure/theme/measures/app_measures.dart';
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
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CommonTextFormField(
                hint: AppStrings.search,
                textController: controller.searchController,
                onFieldSubmitted: (value) {},
                suffixIcon: Icons.search,
                onSuffixTap: () {},
              ),
              const SizedBox(height: 15),
              Expanded(
                child: Obx(() {
                  if (controller.filteredList.isEmpty) {
                    return SingleChildScrollView(
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
                    );
                  }

                  return ListView.separated(
                    itemCount: controller.filteredList.length,
                    itemBuilder: (context, index) {
                      return _generateListItem(index);
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider();
                    },
                  );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector _generateListItem(int index) {
    return GestureDetector(
      onTap: () {
        Get.back(result: controller.filteredList[index]);
      },
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: CommonTextWidget(
          text: controller.filteredList[index].name,
        ),
      ),
    );
  }
}
