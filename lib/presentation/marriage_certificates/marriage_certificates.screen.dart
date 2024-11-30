import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mahall_manager/presentation/common_widgets/common_appbar_widget.dart';
import 'package:mahall_manager/presentation/common_widgets/common_download_item_widget.dart';
import 'package:mahall_manager/presentation/common_widgets/common_text_field_shimmer_widget.dart';

import '../../infrastructure/navigation/routes.dart';
import '../../infrastructure/theme/strings/app_strings.dart';
import '../common_widgets/common_empty_result_widget.dart';
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
        appBar: CommonAppbarWidget(
          title: AppStrings.marriageCertificates,
        ),
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/dark_background.png'),
                  fit: BoxFit.cover)),
          child: Obx(
            () => !controller.isLoading.value &&
                    controller.marriageCertificatesList.isEmpty
                ? const CommonEmptyResultWidget()
                : Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CommonTextFormField(
                          suffixIcon: Icons.search,
                          textController:
                              controller.certificateSearchController,
                        ),
                      ),
                      _buildCertificateList(),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  _buildCertificateList() {
    return Obx(
      () => Expanded(
        child: ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: controller.isLoading.value
                ? 20
                : controller.marriageCertificatesList.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return controller.isLoading.value
                  ? const Padding(
                      padding: EdgeInsets.all(10),
                      child: CommonTextFieldShimmerWidget(),
                    )
                  : CommonDownloadItemWidget(
                      onItemTap: () {
                        Get.toNamed(
                          Routes.PDF_VIEWER,
                          arguments: {
                            AppStrings.pdfName: controller.generateName(index),
                            AppStrings
                                    .pdfUrl: /*controller
                                    .marriageCertificatesList[index]
                                    .certificateUrl ?? ''*/
                                'https://github.com/ScerIO/packages.flutter/raw/fd0c92ac83ee355255acb306251b1adfeb2f2fd6/packages/native_pdf_renderer/example/assets/sample.pdf'
                          },
                        );
                      },
                      name: controller.generateName(index),
                      onDownloadTap: () {
                        controller.savePdf(
                            controller.marriageCertificatesList[index]
                                    .certificateUrl ??
                                '',
                            controller.generateName(index));
                      });
            }),
      ),
    );
  }
}
