import 'package:flutter/material.dart';

import '../../../infrastructure/theme/colors/app_colors.dart';
import '../../../infrastructure/theme/measures/app_measures.dart';
import '../../../infrastructure/theme/strings/app_strings.dart';
import '../../common_widgets/common_clickable_text_widget.dart';
import '../../common_widgets/common_text_widget.dart';

class FilterAndClearFilterWidget extends StatelessWidget {
  const FilterAndClearFilterWidget({
    super.key,
    required this.isFilterSubmitted,
    required this.onClearFilterTap,
    required this.onFilterTap,
  });

  final bool isFilterSubmitted;
  final Function() onClearFilterTap;
  final Function() onFilterTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        isFilterSubmitted
            ? CommonClickableTextWidget(
                title: AppStrings.clearFilters,
                onTap: onClearFilterTap,
                border: Border.all(color: AppColors.darkRed),
                fontSize: AppMeasures.mediumTextSize,
                padding: const EdgeInsets.all(7),
                borderRadius: BorderRadius.circular(10),
                textColor: AppColors.darkRed,
                fontWeight: AppMeasures.mediumWeight,
              )
            : const SizedBox(),
        const SizedBox(width: 20),
        InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: onFilterTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CommonTextWidget(
                  text: AppStrings.filters,
                  fontSize: AppMeasures.mediumTextSize,
                  fontWeight: AppMeasures.smallWeight,
                ),
                const SizedBox(width: 6),
                const Icon(
                  Icons.filter_alt,
                  size: 20,
                  color: Colors.blueGrey,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 20),
      ],
    );
  }
}
