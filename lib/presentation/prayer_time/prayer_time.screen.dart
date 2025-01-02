import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../infrastructure/theme/colors/app_colors.dart';
import '../../infrastructure/theme/measures/app_measures.dart';
import '../../infrastructure/theme/strings/app_strings.dart';
import '../common_widgets/common_button_widget.dart';
import '../common_widgets/common_text_widget.dart';
import 'controllers/prayer_time.controller.dart';

class PrayerTimeScreen extends GetView<PrayerTimeController> {
  const PrayerTimeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/dark_background.png'),
                fit: BoxFit.cover)),
        child: Stack(
          children: [
            _buildHeaderWidget(context),
            Positioned(
                top: 320,
                left: 0,
                right: 0,
                bottom: 0,
                child: _buildBodyWidget(context)),
          ],
        ),
      ),
    );
  }

  _buildBodyWidget(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          controller.isLoading.value
              ? SizedBox(
                  height: MediaQuery.of(context).size.height / 2,
                  child: Image.asset(
                    'assets/images/spin_loader.gif',
                    width: 50,
                    height: 50,
                  ),
                )
              : _buildPrayerTimeWidget(context),
        ],
      ),
    );
  }

  _buildPrayerTimeWidget(BuildContext context) {
    return Expanded(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.black.withOpacity(0.7)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _prayerItemWidget(
                  icon: 'assets/images/subh_icon.png',
                  alarmEnabled: controller.isSubhAlarmOn,
                  text: controller.capitalizeFirstLetter(controller
                      .prayerTimes.value!
                      .currentPrayerByDateTime(
                          controller.prayerTimes.value!.fajr)
                      .name),
                  timing: DateFormat.jm()
                      .format(controller.prayerTimes.value!.fajr)),
              _prayerItemWidget(
                  alarmEnabled: false.obs,
                  icon: 'assets/images/sunrise_icon.png',
                  text: controller.capitalizeFirstLetter(controller
                      .prayerTimes.value!
                      .currentPrayerByDateTime(
                          controller.prayerTimes.value!.sunrise)
                      .name),
                  timing: DateFormat.jm()
                      .format(controller.prayerTimes.value!.sunrise)),
              _prayerItemWidget(
                  icon: 'assets/images/luhr_icon.png',
                  alarmEnabled: controller.isLuhrAlarmOn,
                  text: controller.capitalizeFirstLetter(controller
                      .prayerTimes.value!
                      .currentPrayerByDateTime(
                          controller.prayerTimes.value!.dhuhr)
                      .name),
                  timing: DateFormat.jm()
                      .format(controller.prayerTimes.value!.dhuhr)),
              _prayerItemWidget(
                  icon: 'assets/images/asr_icon.png',
                  alarmEnabled: controller.isAsrAlarmOn,
                  text: controller.capitalizeFirstLetter(controller
                      .prayerTimes.value!
                      .currentPrayerByDateTime(
                          controller.prayerTimes.value!.asr)
                      .name),
                  timing: DateFormat.jm()
                      .format(controller.prayerTimes.value!.asr)),
              _prayerItemWidget(
                  icon: 'assets/images/magrib_icon.png',
                  alarmEnabled: controller.isMagribAlarmOn,
                  text: controller.capitalizeFirstLetter(controller
                      .prayerTimes.value!
                      .currentPrayerByDateTime(
                          controller.prayerTimes.value!.maghrib)
                      .name),
                  timing: DateFormat.jm()
                      .format(controller.prayerTimes.value!.maghrib)),
              _prayerItemWidget(
                  icon: 'assets/images/isha_icon.png',
                  alarmEnabled: controller.isIshaAlarmOn,
                  text: controller.capitalizeFirstLetter(controller
                      .prayerTimes.value!
                      .currentPrayerByDateTime(
                          controller.prayerTimes.value!.isha)
                      .name),
                  timing: DateFormat.jm()
                      .format(controller.prayerTimes.value!.isha)),
            ],
          ),
        ),
      ),
    );
  }

  Obx _buildSettingsWidget() {
    return Obx(
      () => controller.isSettingsClicked.value
          ? Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: AppColors.black.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  // Prayer Methods Dropdown
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.grey)),
                    child: Obx(() => DropdownButton<String>(
                          borderRadius: BorderRadius.circular(20),
                          dropdownColor: AppColors.black.withOpacity(0.8),
                          isExpanded: true,
                          underline: const SizedBox.shrink(),
                          value: controller.selectedMethod.value.isNotEmpty
                              ? controller.selectedMethod.value
                              : null,
                          iconEnabledColor: AppColors.white,
                          hint: CommonTextWidget(
                            text: AppStrings.selectCalculationMethod,
                            fontSize: AppMeasures.mediumTextSize,
                            fontWeight: AppMeasures.mediumWeight,
                            color: AppColors.white,
                          ),
                          items: controller.prayerMethods.keys.map(
                            (method) {
                              return DropdownMenuItem<String>(
                                value: method,
                                child: CommonTextWidget(
                                  text: method,
                                  color: AppColors.white,
                                  fontSize: AppMeasures.mediumTextSize,
                                  fontWeight: AppMeasures.mediumWeight,
                                ),
                              );
                            },
                          ).toList(),
                          onChanged: (value) {
                            controller.setSelectedMethod(value!);
                          },
                        )),
                  ),
                  const SizedBox(height: 10),
                  // Madhab Dropdown
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.grey)),
                    child: Obx(() => DropdownButton<String>(
                          borderRadius: BorderRadius.circular(20),
                          dropdownColor: AppColors.black.withOpacity(0.8),
                          isExpanded: true,
                          iconEnabledColor: AppColors.white,
                          underline: const SizedBox.shrink(),
                          value: controller.selectedMadhab.value.isNotEmpty
                              ? controller.selectedMadhab.value
                              : null,
                          hint: CommonTextWidget(
                            text: AppStrings.selectMadhab,
                            fontSize: AppMeasures.mediumTextSize,
                            fontWeight: AppMeasures.mediumWeight,
                            color: AppColors.white,
                          ),
                          items: controller.madhabs.keys.map(
                            (madhab) {
                              return DropdownMenuItem<String>(
                                value: madhab,
                                child: CommonTextWidget(
                                  text: madhab,
                                  color: AppColors.white,
                                  fontSize: AppMeasures.mediumTextSize,
                                  fontWeight: AppMeasures.mediumWeight,
                                ),
                              );
                            },
                          ).toList(),
                          onChanged: (value) {
                            controller.setSelectedMadhab(value!);
                          },
                        )),
                  ),
                  const SizedBox(height: 20),
                  CommonButtonWidget(
                    onTap: () {
                      controller.params = controller.methodKey.getParameters();
                      controller.params.madhab = controller.madhabKey;
                      controller.prayerTimes.value = PrayerTimes.today(
                          controller.myCoordinates, controller.params);
                      controller.isSettingsClicked.value = false;
                    },
                    label: AppStrings.submit,
                    isLoading: false.obs,
                  ),
                ],
              ),
            )
          : const SizedBox.shrink(),
    );
  }

  _buildHeaderWidget(BuildContext context) {
    return Obx(
      () => Container(
        width: double.infinity,
        height: 375,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(controller.decorationGif.value),
                fit: BoxFit.fill)),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                  top: 40,
                  bottom: controller.isSettingsClicked.value
                      ? 10
                      : MediaQuery.of(context).size.height * 0.13),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Material(
                    borderRadius: BorderRadius.circular(50),
                    color: AppColors.white.withOpacity(0.8),
                    elevation: 2,
                    child: IconButton(
                      onPressed: () => Get.back(),
                      icon: Icon(
                        Icons.arrow_back_rounded,
                        color: AppColors.black,
                        size: 20,
                      ),
                    ),
                  ),
                  Material(
                    borderRadius: BorderRadius.circular(50),
                    color: AppColors.white.withOpacity(0.8),
                    elevation: 2,
                    child: IconButton(
                      highlightColor: AppColors.white.withOpacity(0.4),
                      onPressed: () {
                        controller.isSettingsClicked.value =
                            !controller.isSettingsClicked.value;
                      },
                      icon: Icon(Icons.settings, color: AppColors.black),
                    ),
                  ),
                ],
              ),
            ),
            _buildTimerAndCalendarWidget(),
            _buildSettingsWidget(),
          ],
        ),
      ),
    );
  }

  _buildTimerAndCalendarWidget() {
    int hours = controller.timeRemaining.value.inHours;
    int minutes = controller.timeRemaining.value.inMinutes % 60;
    int seconds = controller.timeRemaining.value.inSeconds % 60;
    return Obx(() => controller.isSettingsClicked.value
        ? const SizedBox.shrink()
        : Container(
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            color: AppColors.black.withOpacity(0.4),
            child: Column(
              children: [
                Obx(() => CommonTextWidget(
                      text: controller.hijriDate.value,
                      fontSize: AppMeasures.bigTextSize,
                      color: AppColors.white,
                    )),
                controller.isLoading.value
                    ? const SizedBox.shrink()
                    : Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: CommonTextWidget(
                            textAlign: TextAlign.center,
                            text:
                                "${controller.capitalizeFirstLetter(controller.nextPrayerName.value)} will start in: "
                                "$hours hours, $minutes minutes, $seconds seconds",
                            fontSize: AppMeasures.normalTextSize,
                            color: AppColors.white),
                      ),
              ],
            ),
          ));
  }

  Container _prayerItemWidget({
    required String text,
    required String timing,
    required String icon,
    required RxBool alarmEnabled,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      width: double.infinity,
      height: 60,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey.shade900,
      ),
      child: Row(
        children: [
          Image.asset(
            icon,
            width: 30,
            height: 30,
          ),
          const SizedBox(width: 10),
          CommonTextWidget(
            text: text,
            color: AppColors.white,
            fontSize: AppMeasures.mediumTextSize,
          ),
          const Spacer(),
          CommonTextWidget(
            text: timing,
            color: AppColors.white,
            fontSize: AppMeasures.mediumTextSize,
          ),
          const SizedBox(width: 10),
          /*icon.contains('sunrise_icon')
              ? IconButton(onPressed: () {}, icon: const SizedBox())
              : Obx(() => IconButton(
                    onPressed: () => alarmEnabled.value = !alarmEnabled.value,
                    icon: Icon(
                      alarmEnabled.value
                          ? Icons.notifications
                          : Icons.notifications_off,
                      size: 20,
                      color:
                          alarmEnabled.value ? AppColors.white : AppColors.grey,
                    ),
                  )),*/
        ],
      ),
    );
  }
}
