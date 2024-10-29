import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:mahall_manager/domain/core/interfaces/utilities.dart';
import 'package:mahall_manager/infrastructure/navigation/routes.dart';
import 'package:mahall_manager/infrastructure/theme/measures/app_measures.dart';
import 'package:mahall_manager/presentation/common_widgets/common_language_selection_widget.dart';
import 'package:mahall_manager/presentation/common_widgets/common_text_widget.dart';
import 'package:mahall_manager/presentation/home/controllers/home.controller.dart';

import '../../../infrastructure/theme/colors/app_colors.dart';
import '../../common_widgets/common_clickable_text_widget.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key, required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: AppColors.white,
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          children: [
            CircleAvatar(
              backgroundColor: AppColors.white,
              radius: 80,
              child: Image.asset(
                'assets/logo/Mahall_manager_trans_logo.png',
              ),
            ),
            Obx(
              () => CommonTextWidget(
                text: Utilities.mahallName.value,
                color: AppColors.themeColor,
                fontSize: AppMeasures.bigTextSize,
              ),
            ),
            Divider(
              height: 30,
              thickness: 2,
              indent: 15,
              endIndent: 15,
              color: AppColors.lightGrey,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    CommonClickableTextWidget(
                      icon: Icons.group_add,
                      fontSize: AppMeasures.normalTextSize,
                      fontWeight: AppMeasures.mediumWeight,
                      textColor: AppColors.blueGrey,
                      title:
                          AppLocalizations.of(context)!.committee_registration,
                      onTap: () {
                        Get.toNamed(Routes.COMMITTEE_REGISTRATION);
                      },
                    ),
                    const SizedBox(height: 10),
                    CommonClickableTextWidget(
                      icon: Icons.house_rounded,
                      fontSize: AppMeasures.normalTextSize,
                      fontWeight: AppMeasures.mediumWeight,
                      textColor: AppColors.blueGrey,
                      title: AppLocalizations.of(context)!.house_registration,
                      onTap: () {
                        Get.toNamed(Routes.HOUSE_REGISTRATION);
                      },
                    ),
                    const SizedBox(height: 10),
                    CommonClickableTextWidget(
                      icon: Icons.person,
                      fontSize: AppMeasures.normalTextSize,
                      fontWeight: AppMeasures.mediumWeight,
                      textColor: AppColors.blueGrey,
                      title: AppLocalizations.of(context)!.user_registration,
                      onTap: () {
                        Get.toNamed(Routes.REGISTRATION);
                      },
                    ),
                    const SizedBox(height: 10),
                    Divider(
                      height: 30,
                      thickness: 2,
                      indent: 15,
                      endIndent: 15,
                      color: AppColors.lightGrey,
                    ),
                    const SizedBox(height: 10),
                    CommonClickableTextWidget(
                      icon: Icons.contact_phone_rounded,
                      fontSize: AppMeasures.normalTextSize,
                      fontWeight: AppMeasures.mediumWeight,
                      textColor: AppColors.blueGrey,
                      title: AppLocalizations.of(context)!.contact_us,
                      onTap: () {
                        Get.toNamed(Routes.CONTACT_US);
                      },
                    ),
                    const SizedBox(height: 10),
                    Divider(
                      height: 30,
                      thickness: 2,
                      indent: 15,
                      endIndent: 15,
                      color: AppColors.lightGrey,
                    ),
                    const SizedBox(height: 10),
                    CommonClickableTextWidget(
                      icon: Icons.password_rounded,
                      fontSize: AppMeasures.normalTextSize,
                      fontWeight: AppMeasures.mediumWeight,
                      textColor: AppColors.blueGrey,
                      title: AppLocalizations.of(context)!.reset_password,
                      onTap: () {
                        Get.toNamed(Routes.RESET_PASSWORD);
                      },
                    ),
                    const SizedBox(height: 10),
                    CommonClickableTextWidget(
                      icon: Icons.logout_rounded,
                      fontSize: AppMeasures.normalTextSize,
                      fontWeight: AppMeasures.mediumWeight,
                      textColor: AppColors.blueGrey,
                      title: AppLocalizations.of(context)!.log_out,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CommonLanguageSelectionWidget(
                selectedLanguage: controller.selectedLanguage.value,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    controller.selectedLanguage.value = newValue;
                    controller.changeLanguage(newValue);
                  }
                },
              ),
            ),
            const Divider(
              thickness: 1,
              endIndent: 10,
              indent: 10,
            ),
            Text(
              '© 2024 AllerTempus Innovative.\n All rights reserved.',
              style: TextStyle(
                  color: AppColors.grey, fontSize: AppMeasures.mediumTextSize),
            ),
            const SizedBox(height: 20)
          ],
        ),
      ),
    );
  }
}
