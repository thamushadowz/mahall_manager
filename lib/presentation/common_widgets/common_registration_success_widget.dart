import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:mahall_manager/infrastructure/navigation/routes.dart';
import 'package:mahall_manager/infrastructure/theme/colors/app_colors.dart';
import 'package:mahall_manager/infrastructure/theme/measures/app_measures.dart';
import 'package:mahall_manager/presentation/common_widgets/common_button_widget.dart';
import 'package:mahall_manager/presentation/common_widgets/common_text_widget.dart';

class CommonRegistrationSuccessWidget extends StatelessWidget {
  const CommonRegistrationSuccessWidget({
    super.key,
    required this.onRegAnotherTap,
    required this.regAnotherTitle,
    required this.regSuccessMsg,
  });

  final Function() onRegAnotherTap;
  final String regAnotherTitle;
  final String regSuccessMsg;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.verified,
                size: 100,
                color: AppColors.themeColor,
              ),
              CommonTextWidget(
                  text: AppLocalizations.of(context)!.thank_you,
                  fontSize: AppMeasures.textSize25,
                  fontWeight: AppMeasures.bigWeight,
                  color: AppColors.themeColor),
              CommonTextWidget(
                  text: regSuccessMsg,
                  fontSize: AppMeasures.bigTextSize,
                  fontWeight: AppMeasures.normalWeight,
                  color: AppColors.themeColor),
              Image.asset(
                'assets/images/people_celebrating.png',
                width: 200,
                height: 200,
              ),
              CommonButtonWidget(
                isLoading: false.obs,
                border: Border.all(color: AppColors.themeColor),
                onTap: onRegAnotherTap,
                label: regAnotherTitle,
                color: AppColors.white,
                textColor: AppColors.themeColor,
              ),
              const SizedBox(height: 10),
              CommonTextWidget(
                text: AppLocalizations.of(context)!.or,
              ),
              const SizedBox(height: 10),
              CommonButtonWidget(
                isLoading: false.obs,
                onTap: () {
                  Get.offAllNamed(Routes.HOME);
                },
                label: AppLocalizations.of(context)!.go_home,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
