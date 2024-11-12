import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../infrastructure/theme/colors/app_colors.dart';
import '../../infrastructure/theme/measures/app_measures.dart';
import '../../infrastructure/theme/strings/app_strings.dart';
import '../common_widgets/common_appbar_widget.dart';
import '../common_widgets/common_text_widget.dart';
import 'controllers/profile.controller.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      appBar: CommonAppbarWidget(title: AppStrings.profile),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildImageWidget(),
            const Divider(
              height: 50,
              indent: 50,
              endIndent: 50,
            ),
            _buildContentWidget(),
          ],
        ),
      ),
    );
  }

  _buildImageWidget() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.themeColor,
          width: 1.0,
        ),
      ),
      child: CircleAvatar(
        radius: 50,
        backgroundColor: AppColors.white,
        child: Image.asset(
          'assets/logo/Mahall_manager_trans_logo.png',
        ),
      ),
    );
  }

  _buildContentWidget() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildContentRow(title: AppStrings.registerNo, content: 'U01'),
            _buildDivider(),
            _buildContentRow(title: AppStrings.name, content: 'Thameem Ali'),
            _buildDivider(),
            _buildContentRow(title: AppStrings.houseNo, content: 'KNY01'),
            _buildDivider(),
            _buildContentRow(
                title: AppStrings.address,
                content: 'Sinan Manzil, Kayani,\nKannur, Kerala'),
            _buildDivider(),
            _buildContentRow(
                title: AppStrings.mobileNo, content: '+919091929394'),
            _buildDivider(),
            _buildContentRow(title: AppStrings.gender, content: 'Male'),
            _buildDivider(),
            _buildContentRow(title: AppStrings.dob, content: '20/10/1995'),
            _buildDivider(),
            _buildContentRow(title: AppStrings.age, content: '29'),
            _buildDivider(),
            _buildContentRow(title: AppStrings.job, content: 'Doctor'),
            _buildDivider(),
            _buildContentRow(
                title: AppStrings.annualIncome, content: '10 Lakhs and above'),
            _buildDivider(),
            _buildContentRow(title: AppStrings.bloodGroup, content: 'O+ve'),
          ],
        ),
      ),
    );
  }

  Divider _buildDivider() => const Divider(
        height: 25,
        thickness: 0.3,
      );

  Row _buildContentRow({required String title, required String content}) {
    return Row(
      children: [
        CommonTextWidget(
          text: title,
          color: AppColors.white,
          fontWeight: AppMeasures.mediumWeight,
          fontSize: AppMeasures.normalTextSize,
        ),
        const Spacer(),
        CommonTextWidget(
          text: content,
          color: AppColors.white,
          fontWeight: AppMeasures.mediumWeight,
          fontSize: AppMeasures.mediumTextSize,
          textAlign: TextAlign.end,
        ),
      ],
    );
  }
}
