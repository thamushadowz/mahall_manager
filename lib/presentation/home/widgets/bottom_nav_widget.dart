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
        Icon(
          Icons.home,
          size: 30,
          color: AppColors.white,
        ),
        Icon(
          Icons.people_alt_rounded,
          size: 30,
          color: AppColors.white,
        ),
        Icon(
          Icons.file_copy_rounded,
          size: 30,
          color: AppColors.white,
        ),
        Icon(
          Icons.water_drop,
          size: 30,
          color: AppColors.white,
        ),
        Icon(
          Icons.map_rounded,
          size: 30,
          color: AppColors.white,
        ),
      ],
      onTap: onTap,
    );
  }
}
