import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:mahall_manager/infrastructure/theme/colors/app_colors.dart';
import 'package:mahall_manager/infrastructure/theme/measures/app_measures.dart';
import 'package:mahall_manager/infrastructure/theme/strings/app_strings.dart';
import 'package:mahall_manager/presentation/common_widgets/common_clickable_text_widget.dart';
import 'package:mahall_manager/presentation/common_widgets/common_text_widget.dart';
import 'package:shimmer/shimmer.dart';

import '../common_widgets/common_appbar_widget.dart';
import 'controllers/contact_us.controller.dart';

class ContactUsScreen extends GetView<ContactUsController> {
  ContactUsScreen({super.key}) {
    Get.put(ContactUsController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          CommonAppbarWidget(title: AppLocalizations.of(context)!.contact_us),
      body: SizedBox.expand(
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/dark_background.png'),
                  fit: BoxFit.cover)),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

              return SingleChildScrollView(
                padding: EdgeInsets.only(
                  top: keyboardHeight == 0 ? constraints.maxHeight * 0.2 : 20,
                  bottom: 20,
                ),
                child: Column(
                  mainAxisAlignment: keyboardHeight == 0
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.start,
                  children: [
                    _buildContactUsWidget(),
                    const SizedBox(height: 20),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Obx _buildContactUsWidget() {
    return Obx(
      () => Column(
        children: [
          _detailsWidget(
              heading: 'President',
              name: controller.presidentName.value,
              number: controller.presidentMobileNo.value,
              imageString: 'assets/images/president.png'),
          _detailsWidget(
              heading: 'Secretary',
              name: controller.secretaryName.value,
              number: controller.secretaryMobileNo.value,
              imageString: 'assets/images/secretary.png'),
          _detailsWidget(
              heading: 'Treasurer',
              name: controller.treasurerName.value,
              number: controller.treasurerMobileNo.value,
              imageString: 'assets/images/treasurer.png'),
        ],
      ),
    );
  }

  /// Contact Details Card
  Widget _detailsWidget({
    required String heading,
    required String name,
    required String number,
    required String imageString,
  }) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        image: const DecorationImage(
            image: AssetImage('assets/images/islamic_pattern.jpg'),
            fit: BoxFit.cover,
            opacity: 0.7),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.blueGrey.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
            color: AppColors.grey.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CommonTextWidget(
            text: heading,
            fontSize: AppMeasures.bigTextSize,
            fontWeight: FontWeight.w600,
            color: AppColors.blueGrey,
          ),
          Divider(
            thickness: 1.2,
            height: 20,
            indent: 60,
            color: AppColors.black.withOpacity(0.3),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildProfileImage(imageString),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildNameOrShimmer(name),
                  const SizedBox(height: 8),
                  _buildContactNumber(number),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  /// Profile Image with Shimmer
  Widget _buildProfileImage(String imageString) {
    return Obx(() {
      return controller.isLoading.value
          ? _buildIconShimmerWidget()
          : Image.asset(
              imageString,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            );
    });
  }

  /// Name Text or Shimmer
  Widget _buildNameOrShimmer(String name) {
    return Obx(() {
      return controller.isLoading.value
          ? _buildHeadingShimmerWidget()
          : CommonTextWidget(
              text: name,
              fontWeight: FontWeight.w500,
              fontSize: AppMeasures.mediumTextSize,
              color: AppColors.themeColor,
            );
    });
  }

  /// Contact Number with Clickable Action
  Widget _buildContactNumber(String number) {
    return Obx(() {
      return controller.isLoading.value
          ? _buildHeadingShimmerWidget()
          : CommonClickableTextWidget(
              title: number,
              fontWeight: FontWeight.w500,
              textColor: AppColors.blue,
              onTap: () {
                _generateBottomSheet(number);
              },
            );
    });
  }

  /// Shimmer for Heading
  Widget _buildHeadingShimmerWidget() {
    return Shimmer.fromColors(
      baseColor: AppColors.lightGrey,
      highlightColor: AppColors.white,
      child: CommonTextWidget(
        text: 'Loading...',
        fontWeight: FontWeight.w500,
        color: AppColors.lightGrey,
      ),
    );
  }

  /// Shimmer for Icon
  Widget _buildIconShimmerWidget() {
    return Shimmer.fromColors(
      baseColor: AppColors.lightGrey.withOpacity(0.5),
      highlightColor: AppColors.white.withOpacity(0.3),
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: AppColors.lightGrey.withOpacity(0.3),
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  /// Bottom Sheet for Actions
  void _generateBottomSheet(String number) {
    Get.bottomSheet(
      backgroundColor: AppColors.white.withOpacity(0.8),
      SizedBox(
        height: 140,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _generateContactButton(
              title: AppStrings.call,
              onTap: () {
                controller.launchDialer(number);
              },
              icon: 'assets/images/call_icon.png',
            ),
            _generateContactButton(
              title: AppStrings.whatsapp,
              onTap: () {
                controller.launchWhatsApp(number);
              },
              icon: 'assets/images/whatsapp_icon.png',
            ),
          ],
        ),
      ),
    );
  }

  /// Action Button Widget
  Widget _generateContactButton({
    required String title,
    required Function() onTap,
    required String icon,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(50),
          onTap: onTap,
          radius: 40,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.lightGrey.withOpacity(0.3),
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: AppColors.blueGrey),
            ),
            child: Image.asset(
              icon,
              height: 40,
              width: 40,
            ),
          ),
        ),
        const SizedBox(height: 8),
        CommonTextWidget(
          text: title,
          fontSize: AppMeasures.smallTextSize,
          fontWeight: FontWeight.w500,
          color: AppColors.black,
        ),
      ],
    );
  }
}
