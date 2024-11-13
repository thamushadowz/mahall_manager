import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:mahall_manager/presentation/home/controllers/home.controller.dart';

import '../../../infrastructure/theme/colors/app_colors.dart';

class BottomNavWidget extends StatelessWidget {
  const BottomNavWidget(
      {super.key, required this.onTap, required this.controller});

  final Function(int) onTap;
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      backgroundColor: AppColors.white,
      color: AppColors.themeColor,
      items: controller.bottomNavIcons,
      onTap: onTap,
    );
  }
}
