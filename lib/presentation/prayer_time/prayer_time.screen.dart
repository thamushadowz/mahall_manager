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
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/dark_background.png'),
                fit: BoxFit.cover)),
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
        child: Stack(
          children: [
            Positioned(
              left: 10,
              top: 10,
              child: Material(
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
            ),
            Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      highlightColor: AppColors.white.withOpacity(0.4),
                      onPressed: () {
                        controller.isSettingsClicked.value =
                            !controller.isSettingsClicked.value;
                      },
                      icon: Icon(Icons.settings, color: AppColors.white),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Obx(
                    () => controller.isSettingsClicked.value
                        ? Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              children: [
                                // Prayer Methods Dropdown
                                Obx(() => DropdownButton<String>(
                                      isExpanded: true,
                                      underline: const SizedBox.shrink(),
                                      value: controller
                                              .selectedMethod.value.isNotEmpty
                                          ? controller.selectedMethod.value
                                          : null,
                                      hint: CommonTextWidget(
                                        text:
                                            AppStrings.selectCalculationMethod,
                                        fontSize: AppMeasures.mediumTextSize,
                                        fontWeight: AppMeasures.mediumWeight,
                                      ),
                                      items: controller.prayerMethods.keys.map(
                                        (method) {
                                          return DropdownMenuItem<String>(
                                            value: method,
                                            child: CommonTextWidget(
                                              text: method,
                                              fontSize:
                                                  AppMeasures.mediumTextSize,
                                              fontWeight:
                                                  AppMeasures.mediumWeight,
                                            ),
                                          );
                                        },
                                      ).toList(),
                                      onChanged: (value) {
                                        controller.setSelectedMethod(value!);
                                      },
                                    )),
                                const SizedBox(height: 10),
                                // Madhab Dropdown
                                Obx(() => DropdownButton<String>(
                                      isExpanded: true,
                                      underline: const SizedBox.shrink(),
                                      value: controller
                                              .selectedMadhab.value.isNotEmpty
                                          ? controller.selectedMadhab.value
                                          : null,
                                      hint: CommonTextWidget(
                                        text: AppStrings.selectMadhab,
                                        fontSize: AppMeasures.mediumTextSize,
                                        fontWeight: AppMeasures.mediumWeight,
                                      ),
                                      items: controller.madhabs.keys.map(
                                        (madhab) {
                                          return DropdownMenuItem<String>(
                                            value: madhab,
                                            child: CommonTextWidget(
                                              text: madhab,
                                              fontSize:
                                                  AppMeasures.mediumTextSize,
                                              fontWeight:
                                                  AppMeasures.mediumWeight,
                                            ),
                                          );
                                        },
                                      ).toList(),
                                      onChanged: (value) {
                                        controller.setSelectedMadhab(value!);
                                      },
                                    )),
                                const SizedBox(height: 20),
                                CommonButtonWidget(
                                  onTap: () {
                                    controller.params =
                                        controller.methodKey.getParameters();
                                    controller.params.madhab =
                                        controller.madhabKey;
                                    controller.prayerTimes.value =
                                        PrayerTimes.today(
                                            controller.myCoordinates,
                                            controller.params);
                                    controller.printTimings();
                                    controller.isSettingsClicked.value = false;
                                  },
                                  label: AppStrings.submit,
                                  isLoading: false.obs,
                                ),
                              ],
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                  const SizedBox(height: 20),
                  _buildPrayerWidget(
                      text: 'Subh : ',
                      timing: DateFormat.jm()
                          .format(controller.prayerTimes.value!.fajr)),
                  _buildPrayerWidget(
                      text: 'Sunrise : ',
                      timing: DateFormat.jm()
                          .format(controller.prayerTimes.value!.sunrise)),
                  _buildPrayerWidget(
                      text: 'Luhr : ',
                      timing: DateFormat.jm()
                          .format(controller.prayerTimes.value!.dhuhr)),
                  _buildPrayerWidget(
                      text: 'Asr : ',
                      timing: DateFormat.jm()
                          .format(controller.prayerTimes.value!.asr)),
                  _buildPrayerWidget(
                      text: 'Magrib : ',
                      timing: DateFormat.jm()
                          .format(controller.prayerTimes.value!.maghrib)),
                  _buildPrayerWidget(
                      text: 'Isha : ',
                      timing: DateFormat.jm()
                          .format(controller.prayerTimes.value!.isha)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _buildPrayerWidget({required String text, required String timing}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      height: 60,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Colors.grey.shade900),
      child: Row(
        children: [
          CommonTextWidget(
            text: text,
            color: AppColors.white,
          ),
          const Spacer(),
          CommonTextWidget(
            text: timing,
            color: AppColors.white,
          ),
        ],
      ),
    );
  }
}
