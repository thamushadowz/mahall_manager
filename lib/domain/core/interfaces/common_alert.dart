import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mahall_manager/presentation/common_widgets/common_clickable_text_widget.dart';
import 'package:mahall_manager/presentation/common_widgets/common_text_widget.dart';

import '../../../infrastructure/navigation/routes.dart';
import '../../../infrastructure/theme/colors/app_colors.dart';
import '../../../infrastructure/theme/measures/app_measures.dart';
import '../../../infrastructure/theme/strings/app_strings.dart';

showCommonDialog(BuildContext context,
    {required String message,
    Color? messageColor,
    String? noButtonName,
    String? yesButtonName,
    bool? barrierDismissible,
    bool? updatesAvailable,
    int? licenseKey = 0,
    int? userType = 0,
    Function()? onNoTap,
    Function()? onYesTap}) {
  return showDialog(
      barrierDismissible: barrierDismissible ?? true,
      context: context,
      builder: (BuildContext context) {
        print('license Key ::: $licenseKey');
        return Dialog(
          surfaceTintColor: AppColors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                padding: const EdgeInsets.all(20.0),
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.5,
                  maxWidth: MediaQuery.of(context).size.width * 0.9,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10),
                      licenseKey == 2
                          ? Lottie.asset('assets/animations/oops.json',
                              width: 80, height: 80)
                          : const SizedBox.shrink(),
                      updatesAvailable == true
                          ? Lottie.asset('assets/animations/update.json',
                              width: 100, height: 100)
                          : const SizedBox.shrink(),
                      const SizedBox(height: 20),
                      userType == 2
                          ? CommonTextWidget(
                              textAlign: TextAlign.center,
                              text: AppStrings.licenseExpired,
                              fontWeight: AppMeasures.mediumWeight,
                              fontSize: 15,
                              color: AppColors.black,
                            )
                          : licenseKey == 0
                              ? CommonTextWidget(
                                  textAlign: TextAlign.center,
                                  text: message,
                                  fontWeight: AppMeasures.mediumWeight,
                                  fontSize: 18,
                                  color: AppColors.black,
                                )
                              : Text.rich(
                                  TextSpan(
                                    text: licenseKey == 1
                                        ? AppStrings.licenseWillExpireIn
                                        : AppStrings.licenseExpired,
                                    style: TextStyle(
                                      fontWeight: AppMeasures.mediumWeight,
                                      fontSize: 16,
                                      color: AppColors.black,
                                    ),
                                    children: [
                                      licenseKey == 2
                                          ? TextSpan(
                                              text: AppStrings.pleaseContact,
                                              style: TextStyle(
                                                fontWeight:
                                                    AppMeasures.mediumWeight,
                                                fontSize: 16,
                                                color: AppColors.black,
                                              ),
                                            )
                                          : const TextSpan(),
                                      TextSpan(
                                        text: licenseKey == 1
                                            ? message
                                            : AppStrings.developers,
                                        style: TextStyle(
                                          fontWeight: AppMeasures.mediumWeight,
                                          fontSize: 16,
                                          color: licenseKey == 1
                                              ? AppColors.darkRed
                                              : AppColors.blue,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            if (licenseKey == 2) {
                                              Get.toNamed(
                                                  Routes.CONTACT_DEVELOPERS);
                                            }
                                          },
                                      ),
                                      TextSpan(
                                        text: licenseKey == 1
                                            ? AppStrings.pleaseRenew
                                            : AppStrings.toUseService,
                                        style: TextStyle(
                                          fontWeight: AppMeasures.mediumWeight,
                                          fontSize: 16,
                                          color: AppColors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                      const SizedBox(height: 20),
                      licenseKey == 1 || updatesAvailable == true
                          ? CommonClickableTextWidget(
                              borderRadius: BorderRadius.circular(40),
                              border: Border.all(color: AppColors.themeColor),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              title: updatesAvailable == true
                                  ? AppStrings.update
                                  : AppStrings.close,
                              textColor: AppColors.themeColor,
                              onTap: updatesAvailable == true
                                  ? onNoTap!
                                  : () {
                                      Get.close(0);
                                    },
                            )
                          : licenseKey == 2
                              ? const SizedBox.shrink()
                              : Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 60.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CommonClickableTextWidget(
                                        borderRadius: BorderRadius.circular(40),
                                        border: Border.all(
                                            color: AppColors.themeColor),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 10),
                                        title:
                                            noButtonName ?? AppStrings.cancel,
                                        textColor: AppColors.themeColor,
                                        onTap: onNoTap ??
                                            () {
                                              Get.close(0);
                                            },
                                      ),
                                      CommonClickableTextWidget(
                                          title: yesButtonName ??
                                              AppStrings.submit,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 10),
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          fillColor: AppColors.themeColor,
                                          textColor: AppColors.white,
                                          onTap: onYesTap ?? () {})
                                    ],
                                  ),
                                )
                    ],
                  ),
                ),
              );
            },
          ),
        );
      });
}

Future<bool> isInternetAvailable() async {
  var connectivityResult = await Connectivity().checkConnectivity();
  print('Connectivity ::: ${connectivityResult}');
  if (connectivityResult.first == ConnectivityResult.mobile ||
      connectivityResult.first == ConnectivityResult.wifi) {
    return true;
  } else {
    return false;
  }
}
