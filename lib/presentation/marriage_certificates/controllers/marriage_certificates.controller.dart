import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

import '../../../domain/core/interfaces/common_alert.dart';
import '../../../domain/core/interfaces/utility_services.dart';
import '../../../domain/listing/listing_repository.dart';
import '../../../domain/listing/listing_service.dart';
import '../../../domain/listing/models/MarriageRegistrationModel.dart';
import '../../../infrastructure/dal/services/storage_service.dart';
import '../../../infrastructure/theme/strings/app_strings.dart';

class MarriageCertificatesController extends GetxController {
  final StorageService storageService = StorageService();
  ListingService listingService = Get.find<ListingRepository>();

  final certificateSearchController = TextEditingController();
  RxBool isLoading = false.obs;

  RxList<MarriageData> marriageCertificatesList = RxList([]);

  @override
  void onInit() {
    super.onInit();
    getMarriageCertificatesList();
  }

  void savePdf(String url, String name) async {
    const pdfUrl =
        'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf';
    const fileName = 'sample.pdf';

    String? path = await downloadPdfToExternal(pdfUrl, fileName);
    if (path != null) {
      print("PDF saved at: $path");
    } else {
      print("Failed to save PDF.");
    }
  }

  getMarriageCertificatesList() async {
    isLoading.value = true;
    var isConnectedToInternet = await isInternetAvailable();
    if (isConnectedToInternet) {
      try {
        MarriageRegistrationModel response = await listingService
            .getMarriageCertificateList(storageService.getToken() ?? '');
        if (response.status == true) {
          marriageCertificatesList.addAll(response.data!);
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

  String generateName(int index) {
    return '${marriageCertificatesList[index].marriageRegNo} : ${marriageCertificatesList[index].groomName} - ${marriageCertificatesList[index].brideName}';
  }
}
