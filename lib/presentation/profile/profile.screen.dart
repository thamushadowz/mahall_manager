import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mahall_manager/infrastructure/theme/measures/app_measures.dart';

import '../../infrastructure/theme/colors/app_colors.dart';
import '../../infrastructure/theme/strings/app_strings.dart';
import '../common_widgets/common_text_widget.dart';
import 'controllers/profile.controller.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [const Color(0xFF00796B), AppColors.themeColor],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildAppBar(),
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
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Row(
      children: [
        IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        const Spacer(),
      ],
    );
  }

  Widget _buildProfileImage() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [AppColors.themeColor, const Color(0xFF1DE9B6)],
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
      text: "Thameem Ali (U01)",
      color: AppColors.white,
      fontSize: AppMeasures.textSize25,
      fontWeight: FontWeight.bold,
    );
  }

  Widget _buildUserAddress() {
    return CommonTextWidget(
      text: "KNY01 • Sinan Manzil, Kayani, Kannur, Kerala",
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
              _buildDetailItem(AppStrings.mobileNo, "+91 9091929394"),
              _buildDivider(),
              _buildDetailItem(AppStrings.gender, "Male"),
              _buildDivider(),
              _buildDetailItem(AppStrings.dob, "20/10/1995"),
              _buildDivider(),
              _buildDetailItem(AppStrings.age, "29"),
              _buildDivider(),
              _buildDetailItem(AppStrings.job, "Doctor"),
              _buildDivider(),
              _buildDetailItem(AppStrings.annualIncome, "10 Lakhs and above"),
              _buildDivider(),
              _buildDetailItem(AppStrings.bloodGroup, "O+ve"),
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
