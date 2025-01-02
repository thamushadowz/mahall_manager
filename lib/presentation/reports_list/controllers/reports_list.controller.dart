import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

import '../../../domain/core/interfaces/utility_services.dart';
import '../../../domain/listing/listing_repository.dart';
import '../../../domain/listing/listing_service.dart';
import '../../../domain/listing/models/GetReportPdfModel.dart';
import '../../../infrastructure/dal/services/storage_service.dart';
import '../../../infrastructure/theme/strings/app_strings.dart';

class ReportsListController extends GetxController {
  final StorageService storageService = StorageService();
  ListingService listingService = Get.find<ListingRepository>();

  final reportSearchController = TextEditingController();
  RxBool isLoading = false.obs;
  RxList<ReportPdfData> pdfList = RxList([]);

  @override
  onInit() {
    super.onInit();
    generateReportsPdfList();
  }

  generateReportsPdfList() async {
    isLoading.value = true;
    var isConnectedToInternet = await isInternetAvailable();
    if (isConnectedToInternet) {
      try {
        GetReportPdfModel response = await listingService
            .getReportsPdfList(storageService.getToken() ?? '');
        if (response.status == true) {
          pdfList.addAll(response.data!);
        } else {
          showToast(
              title: response.message.toString(),
              type: ToastificationType.error);
        }
      } catch (e) {
        showToast(
            title: AppStrings.somethingWentWrong,
            type: ToastificationType.error);
      } finally {
        isLoading.value = false;
      }
    } else {
      showToast(
          title: AppStrings.noInternetConnection,
          type: ToastificationType.error);
      isLoading.value = false;
    }
  }

  void savePdf(String fileName, String pdfUrl) async {
    const pdfUrl =
        'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf';
    const fileName = 'sample.pdf';

    String? path = await downloadPdfToExternal(pdfUrl, fileName);
    if (path != null) {
    } else {}
  }
}
