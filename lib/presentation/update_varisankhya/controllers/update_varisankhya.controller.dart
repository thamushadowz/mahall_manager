import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

import '../../../domain/core/interfaces/utility_services.dart';
import '../../../domain/listing/listing_repository.dart';
import '../../../domain/listing/listing_service.dart';
import '../../../domain/listing/models/common_response.dart';
import '../../../infrastructure/dal/services/storage_service.dart';
import '../../../infrastructure/theme/strings/app_strings.dart';

class UpdateVarisankhyaController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final StorageService storageService = StorageService();
  ListingService listingService = Get.find<ListingRepository>();

  final amountController = TextEditingController();
  final amountFocusNode = FocusNode();

  final RxBool isLoading = false.obs;

  updateVarisankhya() async {
    isLoading.value = true;
    var isConnectedToInternet = await isInternetAvailable();
    if (isConnectedToInternet) {
      try {
        CommonResponse response = await listingService.updateVarisankhya(
            storageService.getToken() ?? '',
            {'amount': amountController.text.trim()});
        if (response.status == true) {
          Get.back();
          showToast(
              title: response.message.toString(),
              type: ToastificationType.success);
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

  @override
  void onClose() {
    super.onClose();
    amountController.dispose();
    amountFocusNode.dispose();
  }
}
