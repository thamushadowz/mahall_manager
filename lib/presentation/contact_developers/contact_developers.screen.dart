import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mahall_manager/presentation/common_widgets/common_appbar_widget.dart';

import '../../infrastructure/theme/colors/app_colors.dart';
import '../../infrastructure/theme/measures/app_measures.dart';
import '../../infrastructure/theme/strings/app_strings.dart';
import '../common_widgets/common_clickable_text_widget.dart';
import '../common_widgets/common_text_widget.dart';
import 'controllers/contact_developers.controller.dart';

class ContactDevelopersScreen extends GetView<ContactDevelopersController> {
  const ContactDevelopersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbarWidget(title: AppStrings.contactDevelopers),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/images/pattern_background.jpg'),
          fit: BoxFit.cover,
          opacity: 0.7,
        )),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 20.0, right: 20.0, top: 40.0, bottom: 20.0),
              child: CommonTextWidget(
                text: AppStrings.weAreAllerTempus,
                fontSize: AppMeasures.textSize25,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              child: CommonTextWidget(
                text: AppStrings.howMayWeAssistYou,
                fontSize: AppMeasures.bigTextSize,
                textAlign: TextAlign.center,
              ),
            ),
            _detailsWidget(
                name: 'Mr. Ajmal K V',
                number: '+91 9995560424',
                imageString: 'assets/images/secretary.png'),
            _detailsWidget(
                name: 'Mr. Thameem Ali',
                number: '+91 9400477889',
                imageString: 'assets/images/secretary.png'),
            const SizedBox(height: 50),
            Image.asset(
              'assets/images/thank_you.png',
              width: 150,
              height: 150,
            ),
          ],
        ),
      ),
    );
  }

  Container _detailsWidget({
    required String name,
    required String number,
    required String imageString,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage('assets/images/islamic_pattern.jpg'),
            fit: BoxFit.fill,
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.blueGrey)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imageString,
                width: 60,
                height: 60,
              ),
              const SizedBox(width: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CommonTextWidget(
                    text: name,
                    fontWeight: AppMeasures.mediumWeight,
                    color: AppColors.themeColor,
                  ),
                  const SizedBox(height: 10),
                  CommonClickableTextWidget(
                    title: number,
                    fontWeight: AppMeasures.mediumWeight,
                    textColor: AppColors.blue,
                    onTap: () {
                      _generateBottomSheet(number);
                    },
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  _generateBottomSheet(String number) {
    Get.bottomSheet(
        backgroundColor: AppColors.white,
        SizedBox(
          height: 120,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _generateContactButton(
                  title: AppStrings.call,
                  onTap: () {
                    controller.launchDialer(number);
                  },
                  icon: 'assets/images/call_icon.png'),
              const SizedBox(width: 40),
              _generateContactButton(
                  title: AppStrings.whatsapp,
                  onTap: () {
                    controller.launchWhatsApp(number);
                  },
                  icon: 'assets/images/whatsapp_icon.png')
            ],
          ),
        ));
  }

  InkWell _generateContactButton({
    required String title,
    required Function() onTap,
    required String icon,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: AppColors.grey.withOpacity(0.5),
                border: Border.all(color: AppColors.blueGrey),
                borderRadius: BorderRadius.circular(30)),
            child: Image.asset(
              icon,
              height: 30,
              width: 30,
            ),
          ),
          const SizedBox(height: 10),
          CommonTextWidget(
            text: title,
            color: AppColors.black,
          )
        ],
      ),
    );
  }
}
