import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:mahall_manager/infrastructure/theme/colors/app_colors.dart';
import 'package:mahall_manager/infrastructure/theme/measures/app_measures.dart';
import 'package:mahall_manager/infrastructure/theme/strings/app_strings.dart';
import 'package:mahall_manager/presentation/common_widgets/common_clickable_text_widget.dart';
import 'package:mahall_manager/presentation/common_widgets/common_text_widget.dart';

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
      body: Column(
        children: [
          _detailsWidget(
              heading: 'President',
              name: 'Mr. Abdullah P K',
              number: '+91 9897969594',
              imageString: 'assets/images/president.png'),
          _detailsWidget(
              heading: 'Secretary',
              name: 'Mr. Salman Faris',
              number: '+91 9876543210',
              imageString: 'assets/images/secretary.png'),
          _detailsWidget(
              heading: 'Treasurer',
              name: 'Mr. Abdul Azees',
              number: '+91 9496317389',
              imageString: 'assets/images/treasurer.png'),
        ],
      ),
    );
  }

  Container _detailsWidget({
    required String heading,
    required String name,
    required String number,
    required String imageString,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage('assets/images/islamic_pattern.jpg'),
            fit: BoxFit.fill,
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.blueGrey)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CommonTextWidget(text: heading),
          Divider(
            thickness: 1.5,
            height: 30,
            color: AppColors.grey.withOpacity(0.5),
          ),
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
