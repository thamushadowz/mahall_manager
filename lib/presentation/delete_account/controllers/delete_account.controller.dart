import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

import '../../../domain/core/interfaces/utility_services.dart';
import '../../../domain/listing/listing_repository.dart';
import '../../../domain/listing/listing_service.dart';
import '../../../domain/listing/models/common_response.dart';
import '../../../infrastructure/dal/services/storage_service.dart';
import '../../../infrastructure/navigation/routes.dart';
import '../../../infrastructure/theme/strings/app_strings.dart';

class DeleteAccountController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final StorageService storageService = StorageService();
  ListingService listingService = Get.find<ListingRepository>();

  RxBool showPassword = false.obs;
  RxBool isLoading = false.obs;

  final mobileController = TextEditingController();
  final passwordController = TextEditingController();

  final mobileFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  @override
  void onClose() {
    super.onClose();
    mobileController.dispose();
    passwordController.dispose();
    mobileFocusNode.dispose();
    passwordFocusNode.dispose();
  }

  deleteAccount() async {
    isLoading.value = true;
    var isConnectedToInternet = await isInternetAvailable();
    if (isConnectedToInternet) {
      try {
        CommonResponse response = await listingService
            .deleteAccount(storageService.getToken() ?? '', {
          "phone": mobileController.text.trim(),
          "password": passwordController.text.trim()
        });
        if (response.status == true) {
          showToast(
              title: response.message.toString(),
              type: ToastificationType.success);
          storageService.logout();
          Get.offAllNamed(Routes.LOGIN);
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
}
