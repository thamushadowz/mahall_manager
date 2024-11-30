import 'package:flutter/material.dart';

import '../../infrastructure/theme/colors/app_colors.dart';
import '../../infrastructure/theme/measures/app_measures.dart';
import '../../infrastructure/theme/strings/app_strings.dart';
import 'common_text_widget.dart';

class CommonDownloadItemWidget extends StatelessWidget {
  const CommonDownloadItemWidget({
    super.key,
    required this.name,
    required this.onDownloadTap,
    required this.onItemTap,
  });

  final String name;
  final Function() onDownloadTap;
  final Function() onItemTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onItemTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: AppColors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            CommonTextWidget(
              text: name,
              fontSize: AppMeasures.mediumTextSize,
              fontWeight: AppMeasures.mediumWeight,
            ),
            const Spacer(),
            GestureDetector(
              onTap: onDownloadTap,
              child: Material(
                borderRadius: BorderRadius.circular(40),
                color: AppColors.white,
                elevation: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CommonTextWidget(
                        text: AppStrings.download,
                        color: AppColors.blue,
                        fontSize: AppMeasures.smallTextSize,
                      ),
                      const SizedBox(width: 10),
                      Icon(
                        Icons.download_rounded,
                        color: AppColors.blue,
                        size: 20,
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
