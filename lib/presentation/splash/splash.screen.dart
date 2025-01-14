import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mahall_manager/presentation/splash/controllers/splash.controller.dart';

import '../../infrastructure/theme/colors/app_colors.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      controller.moveToScreen();
    });

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Image.asset(
          'assets/logo/Mahall_manager_trans_logo.png',
          width: 210,
          height: 210,
        ),
      ),
    );
  }
}
