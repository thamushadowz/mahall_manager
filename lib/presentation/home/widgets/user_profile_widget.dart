import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mahall_manager/presentation/home/controllers/home.controller.dart';

import '../../../infrastructure/theme/colors/app_colors.dart';
import '../../../infrastructure/theme/measures/app_measures.dart';
import '../../../infrastructure/theme/strings/app_strings.dart';
import '../../common_widgets/common_text_widget.dart';

class UserProfileWidget extends StatelessWidget {
  const UserProfileWidget({super.key, required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/dark_background.png'),
                  fit: BoxFit.cover)),
          child: controller.isLoading.value
              ? SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Center(
                      child: CircularProgressIndicator(
                    color: AppColors.white,
                  )))
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      _buildProfileImage(),
                      const SizedBox(height: 20),
                      _buildUserName(),
                      const SizedBox(height: 10),
                      _buildUserAddress(),
                      const SizedBox(height: 20),
                      Expanded(child: _buildDetailsCard()),
                    ],
                  ),
                ),
        ));
  }

  Widget _buildProfileImage() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            AppColors.themeColor,
            const Color(0xFF1DE9B6),
            AppColors.themeColor
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      padding: const EdgeInsets.all(5),
      child: CircleAvatar(
        radius: 60,
        backgroundColor: AppColors.white,
        backgroundImage:
            const AssetImage('assets/logo/Mahall_manager_trans_logo.png'),
      ),
    );
  }

  Widget _buildUserName() {
    return CommonTextWidget(
      text:
          '${controller.userProfile.first.fName} ${controller.userProfile.first.lName} (${controller.userProfile.first.userRegNo})',
      color: AppColors.white,
      fontSize: AppMeasures.textSize25,
      fontWeight: FontWeight.bold,
    );
  }

  Widget _buildUserAddress() {
    return CommonTextWidget(
      text:
          "${controller.userProfile.first.houseRegNo} • ${controller.userProfile.first.houseName}, ${controller.userProfile.first.place}, ${controller.userProfile.first.district}, ${controller.userProfile.first.state}.",
      color: AppColors.white.withOpacity(0.8),
      fontSize: AppMeasures.mediumTextSize,
      fontWeight: AppMeasures.mediumWeight,
      textAlign: TextAlign.center,
    );
  }

  Widget _buildDetailsCard() {
    return Card(
      color: AppColors.white.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailItem(AppStrings.mobileNo,
                  "+91 ${controller.userProfile.first.phone}"),
              _buildDivider(),
              _buildDetailItem(
                  AppStrings.gender, "${controller.userProfile.first.gender}"),
              _buildDivider(),
              _buildDetailItem(
                  AppStrings.dob, "${controller.userProfile.first.dob}"),
              _buildDivider(),
              _buildDetailItem(
                  AppStrings.age, "${controller.userProfile.first.age}"),
              _buildDivider(),
              _buildDetailItem(
                  AppStrings.job, "${controller.userProfile.first.job}"),
              _buildDivider(),
              _buildDetailItem(AppStrings.annualIncome,
                  "${controller.userProfile.first.annualIncome}"),
              _buildDivider(),
              _buildDetailItem(AppStrings.bloodGroup,
                  "${controller.userProfile.first.bloodGroup}"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailItem(String title, String content) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CommonTextWidget(
          text: title,
          color: AppColors.white.withOpacity(0.9),
          fontWeight: AppMeasures.mediumWeight,
          fontSize: AppMeasures.mediumTextSize,
        ),
        CommonTextWidget(
          text: content,
          color: AppColors.white.withOpacity(0.9),
          fontWeight: AppMeasures.mediumWeight,
          fontSize: AppMeasures.mediumTextSize,
        ),
      ],
    );
  }

  Divider _buildDivider() => Divider(
        height: 20,
        thickness: 0.5,
        color: Colors.white.withOpacity(0.3),
      );
}
