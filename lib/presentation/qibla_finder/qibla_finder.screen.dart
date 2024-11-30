import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:get/get.dart';
import 'package:mahall_manager/presentation/common_widgets/common_button_widget.dart';
import 'package:mahall_manager/presentation/common_widgets/common_text_widget.dart';

import '../../domain/core/interfaces/utility_services.dart';
import '../../infrastructure/theme/colors/app_colors.dart';
import '../../infrastructure/theme/strings/app_strings.dart';
import 'controllers/qibla_finder.controller.dart';

class QiblaFinderScreen extends GetView<QiblaFinderController> {
  const QiblaFinderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => !controller.isPermissionGranted.value
          ? _buildPermissionWidget(context)
          : _buildQiblaWidget()),
    );
  }

  Container _buildQiblaWidget() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/qibla_background.png'),
              fit: BoxFit.cover)),
      child: StreamBuilder<QiblahDirection?>(
        stream: FlutterQiblah.qiblahStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          }

          final qiblahDirection = snapshot.data!;
          controller.animation = Tween(
            begin: controller.begin,
            end: (qiblahDirection.qiblah * (pi / 180) * -1),
          ).animate(controller.animationController!);
          controller.begin = (qiblahDirection.qiblah * (pi / 180) * -1);
          controller.animationController!.forward(from: 0);

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 80),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Material(
                    borderRadius: BorderRadius.circular(50),
                    color: AppColors.white.withOpacity(0.8),
                    elevation: 2,
                    child: IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(
                          Icons.arrow_back_rounded,
                          color: AppColors.black,
                        )),
                  ),
                ),
              ),
              Column(
                children: [
                  Image.asset(
                    'assets/images/kaaba.png',
                    width: 100,
                    height: 100,
                  ),
                  const SizedBox(height: 100),
                  Container(
                    width: 300,
                    height: 300,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image:
                            AssetImage('assets/images/qibla_back_mandala.png'),
                        fit: BoxFit.contain,
                        opacity: 0.5,
                      ),
                    ),
                    child: Center(
                      child: AnimatedBuilder(
                        animation: controller.animation!,
                        builder: (context, child) => Transform.rotate(
                          angle: controller.animation!.value,
                          child: SizedBox(
                            width: 100,
                            height: 100,
                            child: Image.asset(
                              'assets/images/compass_arrow.png',
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Container _buildPermissionWidget(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/qibla_finder_background2.png'),
              fit: BoxFit.cover)),
      padding: const EdgeInsets.all(20.0),
      child: Stack(
        children: [
          Positioned(
            left: 10,
            top: 30,
            child: Material(
              borderRadius: BorderRadius.circular(50),
              color: AppColors.white.withOpacity(0.8),
              elevation: 2,
              child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Icons.arrow_back_rounded,
                    color: AppColors.black,
                  )),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 3,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Column(
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 80,
                    color: AppColors.darkRed,
                  ),
                  const SizedBox(height: 20),
                  CommonTextWidget(
                      text: AppStrings.failedToFetchLocation,
                      textAlign: TextAlign.center,
                      color: AppColors.white,
                      fontSize: 18),
                  const SizedBox(height: 20),
                  CommonButtonWidget(
                      onTap: () async {
                        controller.isPermissionGranted.value =
                            await requestLocationPermission();
                      },
                      label: AppStrings.retry,
                      width: 100,
                      color: AppColors.darkRed,
                      isLoading: false.obs),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
