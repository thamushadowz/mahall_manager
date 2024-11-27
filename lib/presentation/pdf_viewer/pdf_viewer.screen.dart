import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mahall_manager/infrastructure/theme/strings/app_strings.dart';
import 'package:mahall_manager/presentation/common_widgets/common_appbar_widget.dart';
import 'package:pdfx/pdfx.dart';

import '../../infrastructure/theme/colors/app_colors.dart';
import 'controllers/pdf_viewer.controller.dart';

class PdfViewerScreen extends GetView<PdfViewerController> {
  const PdfViewerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CommonAppbarWidget(title: AppStrings.viewPdf),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/dark_background.png'),
                fit: BoxFit.cover)),
        padding: const EdgeInsets.all(20),
        child: Obx(
          () => controller.isLoading.value
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.themeColor,
                  ),
                )
              : PdfView(
                  controller: controller.pdfController,
                  scrollDirection: Axis.horizontal,
                  pageSnapping: true,
                ),
        ),
      ),
    );
  }
}
