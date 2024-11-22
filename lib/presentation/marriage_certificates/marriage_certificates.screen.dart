import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mahall_manager/infrastructure/theme/colors/app_colors.dart';
import 'package:mahall_manager/infrastructure/theme/measures/app_measures.dart';
import 'package:mahall_manager/presentation/common_widgets/common_appbar_widget.dart';
import 'package:mahall_manager/presentation/common_widgets/common_text_widget.dart';

import '../../infrastructure/theme/strings/app_strings.dart';
import '../common_widgets/common_text_form_field.dart';
import 'controllers/marriage_certificates.controller.dart';

class MarriageCertificatesScreen
    extends GetView<MarriageCertificatesController> {
  const MarriageCertificatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: CommonAppbarWidget(
          title: AppStrings.marriageCertificates,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CommonTextFormField(
                suffixIcon: Icons.search,
                textController: controller.certificateSearchController,
              ),
            ),
            _buildCertificateList(),
          ],
        ),
      ),
    );
  }

  _buildCertificateList() {
    return Expanded(
      child: ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: 20,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return _buildItemView(index);
          }),
    );
  }

  _buildItemView(int index) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.blueGrey),
        ),
        child: Row(
          children: [
            CommonTextWidget(
              text: 'Certificate ${index + 1}',
              fontSize: AppMeasures.mediumTextSize,
              fontWeight: AppMeasures.mediumWeight,
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.themeColor,
              size: 20,
            )
          ],
        ),
      ),
    );
  }
}
