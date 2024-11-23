import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:mahall_manager/domain/core/interfaces/common_alert.dart';
import 'package:mahall_manager/infrastructure/navigation/routes.dart';
import 'package:mahall_manager/infrastructure/theme/measures/app_measures.dart';
import 'package:mahall_manager/presentation/common_widgets/common_text_widget.dart';
import 'package:mahall_manager/presentation/home/controllers/home.controller.dart';

import '../../../infrastructure/theme/colors/app_colors.dart';
import '../../../infrastructure/theme/strings/app_strings.dart';
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
                    controller.userType == '2'
                        ? const SizedBox()
                        : _buildAdminDrawer(context),
                    const SizedBox(height: 10),
                    //Profile
                    controller.userType == "1"
                        ? const SizedBox.shrink()
                        : CommonClickableTextWidget(
                            image: 'assets/images/profile.png',
                            fontSize: AppMeasures.normalTextSize,
                            fontWeight: AppMeasures.mediumWeight,
                            textColor: AppColors.blueGrey,
                            title: AppStrings.profile,
                            onTap: () {
                              Get.toNamed(Routes.PROFILE);
                            },
                          ),
                    controller.userType == "1"
                        ? const SizedBox.shrink()
                        : const SizedBox(height: 10),
                    //Contact Us
                    controller.userType == "1"
                        ? const SizedBox.shrink()
                        : CommonClickableTextWidget(
                            image: 'assets/images/contact_us.png',
                            fontSize: AppMeasures.normalTextSize,
                            fontWeight: AppMeasures.mediumWeight,
                            textColor: AppColors.blueGrey,
                            title: AppLocalizations.of(context)!.contact_us,
                            onTap: () {
                              Get.toNamed(Routes.CONTACT_US);
                            },
                          ),
                    controller.userType == "1"
                        ? const SizedBox.shrink()
                        : const SizedBox(height: 10),
                    controller.userType == "1"
                        ? const SizedBox.shrink()
                        : Divider(
                            height: 30,
                            thickness: 2,
                            indent: 15,
                            endIndent: 15,
                            color: AppColors.lightGrey,
                          ),
                    const SizedBox(height: 10),
                    //Reset Password
                    CommonClickableTextWidget(
                      image: 'assets/images/reset_password.png',
                      fontSize: AppMeasures.normalTextSize,
                      fontWeight: AppMeasures.mediumWeight,
                      textColor: AppColors.blueGrey,
                      title: AppLocalizations.of(context)!.reset_password,
                      onTap: () {
                        Get.toNamed(Routes.RESET_PASSWORD);
                      },
                    ),
                    const SizedBox(height: 10),
                    //Logout
                    CommonClickableTextWidget(
                      image: 'assets/images/logout.png',
                      fontSize: AppMeasures.normalTextSize,
                      fontWeight: AppMeasures.mediumWeight,
                      textColor: AppColors.blueGrey,
                      title: AppLocalizations.of(context)!.log_out,
                      onTap: () {
                        showCommonDialog(context,
                            message: AppStrings.areYouSureToLogout,
                            yesButtonName: AppStrings.logout,
                            messageColor: AppColors.darkRed, onYesTap: () {
                          Get.close(0);
                          controller.performLogout();
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            /*Padding(
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
            ),*/
            //Delete Account
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: CommonClickableTextWidget(
                image: 'assets/images/delete-account.png',
                fontSize: AppMeasures.normalTextSize,
                fontWeight: AppMeasures.mediumWeight,
                textColor: AppColors.darkRed,
                iconColor: AppColors.darkRed,
                title: AppStrings.deleteAccount,
                onTap: () {
                  Get.toNamed(Routes.DELETE_ACCOUNT);
                },
              ),
            ),
            const SizedBox(height: 20),
            CommonTextWidget(
              text: controller.versionCode.value,
              fontSize: AppMeasures.mediumTextSize,
              fontWeight: AppMeasures.mediumWeight,
              color: AppColors.blueGrey.withOpacity(0.5),
            ),
            const Divider(thickness: 1, endIndent: 10, indent: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text.rich(
                TextSpan(
                  text: AppStrings.copyRight,
                  style: TextStyle(
                    color: AppColors.grey,
                    fontSize: AppMeasures.mediumTextSize,
                    fontWeight: AppMeasures.mediumWeight,
                  ),
                  children: [
                    TextSpan(
                      text: ' ${AppStrings.privacyPolicy}',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: AppMeasures.mediumTextSize,
                        fontWeight: AppMeasures.mediumWeight,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = () {},
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20)
          ],
        ),
      ),
    );
  }

  _buildAdminDrawer(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        //Committee Registration
        CommonClickableTextWidget(
          image: 'assets/images/committee.png',
          fontSize: AppMeasures.normalTextSize,
          fontWeight: AppMeasures.mediumWeight,
          textColor: AppColors.blueGrey,
          title: AppLocalizations.of(context)!.committee_registration,
          onTap: () {
            Get.toNamed(Routes.COMMITTEE_REGISTRATION);
          },
        ),
        const SizedBox(height: 10),
        //Place Registration
        CommonClickableTextWidget(
          image: 'assets/images/place.png',
          fontSize: AppMeasures.normalTextSize,
          fontWeight: AppMeasures.mediumWeight,
          textColor: AppColors.blueGrey,
          title: AppStrings.placeRegistration,
          onTap: () {
            Get.toNamed(Routes.PLACE_REGISTRATION);
          },
        ),
        const SizedBox(height: 10),
        //House Registration
        CommonClickableTextWidget(
          image: 'assets/images/home.png',
          fontSize: AppMeasures.normalTextSize,
          fontWeight: AppMeasures.mediumWeight,
          textColor: AppColors.blueGrey,
          title: AppLocalizations.of(context)!.house_registration,
          onTap: () {
            Get.toNamed(Routes.HOUSE_REGISTRATION);
          },
        ),
        const SizedBox(height: 10),
        //User Registration
        CommonClickableTextWidget(
          image: 'assets/images/user.png',
          fontSize: AppMeasures.normalTextSize,
          fontWeight: AppMeasures.mediumWeight,
          textColor: AppColors.blueGrey,
          title: AppLocalizations.of(context)!.user_registration,
          onTap: () {
            Get.toNamed(Routes.REGISTRATION);
          },
        ),
        const SizedBox(height: 10),
        //Marriage Registration
        CommonClickableTextWidget(
          image: 'assets/images/marriage.png',
          fontSize: AppMeasures.normalTextSize,
          fontWeight: AppMeasures.mediumWeight,
          textColor: AppColors.blueGrey,
          title: AppStrings.marriageRegistration,
          onTap: () {
            Get.toNamed(Routes.MARRIAGE_REGISTRATION);
          },
        ),
        const SizedBox(height: 10),
        //Death Registration
        CommonClickableTextWidget(
          image: 'assets/images/deceased.png',
          fontSize: AppMeasures.normalTextSize,
          fontWeight: AppMeasures.mediumWeight,
          textColor: AppColors.blueGrey,
          title: AppStrings.deathRegistration,
          onTap: () {
            Get.toNamed(Routes.DEATH_REGISTRATION);
          },
        ),
        const SizedBox(height: 10),
        //Add Promises
        CommonClickableTextWidget(
          image: 'assets/images/promises.png',
          fontSize: AppMeasures.normalTextSize,
          fontWeight: AppMeasures.mediumWeight,
          textColor: AppColors.blueGrey,
          title: AppStrings.addPromises,
          onTap: () {
            Get.toNamed(Routes.PROMISES)?.then((onValue) {
              controller.getPromisesDetails();
            });
          },
        ),
        const SizedBox(height: 10),
        //Add Income
        CommonClickableTextWidget(
          image: 'assets/images/income.png',
          fontSize: AppMeasures.normalTextSize,
          fontWeight: AppMeasures.mediumWeight,
          textColor: AppColors.blueGrey,
          title: AppStrings.addIncome,
          onTap: () {
            Get.toNamed(Routes.ADD_INCOME)?.then((onValue) {
              controller.getReportsDetails();
            });
          },
        ),
        const SizedBox(height: 10),
        //Add Expense
        CommonClickableTextWidget(
          image: 'assets/images/expense.png',
          fontSize: AppMeasures.normalTextSize,
          fontWeight: AppMeasures.mediumWeight,
          textColor: AppColors.blueGrey,
          title: AppStrings.addExpenses,
          onTap: () {
            Get.toNamed(Routes.ADD_EXPENSES)?.then((onValue) {
              controller.getReportsDetails();
            });
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
      ],
    );
  }
}
