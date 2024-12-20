import 'package:flutter/material.dart';

import '../../infrastructure/theme/colors/app_colors.dart';
import 'common_text_widget.dart';

class CommonAppbarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const CommonAppbarWidget({super.key, required this.title, this.actions});

  final String title;

  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: actions,
      iconTheme: IconThemeData(color: AppColors.white),
      backgroundColor: AppColors.themeColor,
      title: CommonTextWidget(
        text: title,
        color: AppColors.white,
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
