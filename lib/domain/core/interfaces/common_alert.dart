import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mahall_manager/presentation/common_widgets/common_clickable_text_widget.dart';
import 'package:mahall_manager/presentation/common_widgets/common_text_widget.dart';

import '../../../infrastructure/theme/colors/app_colors.dart';
import '../../../infrastructure/theme/measures/app_measures.dart';
import '../../../infrastructure/theme/strings/app_strings.dart';

showCommonDialog(BuildContext context,
    {required String title,
    required String message,
    Color? titleColor,
    Color? messageColor,
    String? noButtonName,
    String? yesButtonName,
    Function()? onNoTap,
    required Function() onYesTap}) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          surfaceTintColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              SizedBox(
                height: 230,
                width: 320,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CommonTextWidget(
                      text: title,
                      fontSize: AppMeasures.bigTextSize,
                      color: titleColor ?? AppColors.black,
                    ),
                    const SizedBox(height: 10),
                    CommonTextWidget(
                      textAlign: TextAlign.center,
                      text: message,
                      fontSize: AppMeasures.mediumTextSize,
                      fontWeight: AppMeasures.mediumWeight,
                      color: messageColor ?? AppColors.grey,
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 60.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CommonClickableTextWidget(
                            borderRadius: BorderRadius.circular(40),
                            border: Border.all(color: AppColors.themeColor),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            title: noButtonName ?? AppStrings.cancel,
                            textColor: AppColors.themeColor,
                            onTap: onNoTap ??
                                () {
                                  Get.close(0);
                                },
                          ),
                          CommonClickableTextWidget(
                              title: yesButtonName ?? AppStrings.submit,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              borderRadius: BorderRadius.circular(40),
                              fillColor: AppColors.themeColor,
                              textColor: AppColors.white,
                              onTap: onYesTap)
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                  top: -20,
                  child: Container(
                    height: 50,
                    width: 50,
                    alignment: Alignment.topCenter,
                    decoration: BoxDecoration(
                        color: AppColors.darkRed, shape: BoxShape.circle),
                    child: IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Get.close(0);
                      },
                    ),
                  )),
            ],
          ),
        );
      });
}
