import 'package:flutter/cupertino.dart';
import 'package:shimmer/shimmer.dart';

import '../../infrastructure/theme/colors/app_colors.dart';
import 'common_text_form_field.dart';

class CommonTextFieldShimmerWidget extends StatelessWidget {
  const CommonTextFieldShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: AppColors.lightGrey.withOpacity(0.5),
        highlightColor: AppColors.white.withOpacity(0.3),
        child: CommonTextFormField(
          textController: TextEditingController(),
        ));
  }
}
