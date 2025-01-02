import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mahall_manager/infrastructure/navigation/routes.dart';
import 'package:mahall_manager/presentation/common_widgets/common_empty_result_widget.dart';
import 'package:mahall_manager/presentation/common_widgets/common_text_field_shimmer_widget.dart';

import '../../infrastructure/theme/colors/app_colors.dart';
import '../../infrastructure/theme/strings/app_strings.dart';
import '../common_widgets/common_appbar_widget.dart';
import '../common_widgets/common_download_item_widget.dart';
import '../common_widgets/common_text_form_field.dart';
import 'controllers/reports_list.controller.dart';

class ReportsListScreen extends GetView<ReportsListController> {
  const ReportsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: CommonAppbarWidget(
          title: AppStrings.listOfReports,
        ),
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/dark_background.png'),
                  fit: BoxFit.cover)),
          child: Obx(
              () => !controller.isLoading.value && controller.pdfList.isEmpty
                  ? const CommonEmptyResultWidget()
                  : Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: CommonTextFormField(
                            suffixIcon: Icons.search,
                            textController: controller.reportSearchController,
                          ),
                        ),
                        _buildReportsList(),
                      ],
                    )),
        ),
      ),
    );
  }

  _buildReportsList() {
    return Obx(
      () => Expanded(
        child: ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount:
                controller.isLoading.value ? 20 : controller.pdfList.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return controller.isLoading.value
                  ? const Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: CommonTextFieldShimmerWidget(),
                    )
                  : CommonDownloadItemWidget(
                      onItemTap: () {
                        Get.toNamed(
                          Routes.PDF_VIEWER,
                          arguments: {
                            AppStrings.pdfName:
                                '${controller.pdfList[index].fromDate} - ${controller.pdfList[index].toDate}',
                            AppStrings.pdfUrl:
                                controller.pdfList[index].urlLink ?? ''
                          },
                        );
                      },
                      name:
                          '${controller.pdfList[index].fromDate} - ${controller.pdfList[index].toDate}',
                      onDownloadTap: () {
                        controller.savePdf(
                            '${controller.pdfList[index].fromDate} - ${controller.pdfList[index].toDate}.pdf',
                            controller.pdfList[index].urlLink ?? '');
                      });
            }),
      ),
    );
  }
}
