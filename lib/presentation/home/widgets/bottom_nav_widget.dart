import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../../../infrastructure/theme/colors/app_colors.dart';

class BottomNavWidget extends StatelessWidget {
  const BottomNavWidget({super.key, required this.onTap});

  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      backgroundColor: AppColors.white,
      color: AppColors.themeColor,
      items: [
        Image.asset('assets/images/home.png',
            width: 25, height: 25, color: AppColors.white),
        Image.asset('assets/images/users.png',
            width: 25, height: 25, color: AppColors.white),
        Image.asset('assets/images/promises.png',
            width: 25, height: 25, color: AppColors.white),
        Image.asset('assets/images/report.png',
            width: 25, height: 25, color: AppColors.white),
        Image.asset('assets/images/blood.png',
            width: 25, height: 25, color: AppColors.white),
        Image.asset('assets/images/expat.png',
            width: 25, height: 25, color: AppColors.white),
      ],
      onTap: onTap,
    );
  }
}
