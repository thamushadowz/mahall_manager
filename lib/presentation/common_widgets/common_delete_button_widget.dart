import 'package:flutter/material.dart';

import '../../infrastructure/theme/colors/app_colors.dart';

class CommonDeleteButtonWidget extends StatelessWidget {
  const CommonDeleteButtonWidget({super.key, required this.onTap});

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        borderRadius: BorderRadius.circular(60),
        radius: 60,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            Icons.delete_outline_rounded,
            size: 25,
            color: AppColors.darkRed,
          ),
        ));
  }
}
