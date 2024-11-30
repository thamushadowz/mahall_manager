import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mahall_manager/presentation/common_widgets/common_appbar_widget.dart';
import 'package:mahall_manager/presentation/common_widgets/common_empty_result_widget.dart';
import 'package:pdfx/pdfx.dart';

import '../../infrastructure/theme/colors/app_colors.dart';
import '../../infrastructure/theme/strings/app_strings.dart';
import 'controllers/pdf_viewer.controller.dart';

class PdfViewerScreen extends GetView<PdfViewerController> {
  const PdfViewerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CommonAppbarWidget(
          title: controller.filePath.isEmpty
              ? AppStrings.oops
              : controller.fileName),
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
              : controller.filePath.isEmpty
                  ? const CommonEmptyResultWidget()
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
