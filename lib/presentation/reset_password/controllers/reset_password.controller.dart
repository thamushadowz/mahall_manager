import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mahall_manager/domain/core/interfaces/utility_services.dart';
import 'package:toastification/toastification.dart';

import '../../../domain/listing/listing_repository.dart';
import '../../../domain/listing/listing_service.dart';
import '../../../domain/listing/models/common_response.dart';
import '../../../infrastructure/dal/services/storage_service.dart';
import '../../../infrastructure/navigation/routes.dart';
import '../../../infrastructure/theme/strings/app_strings.dart';

class ResetPasswordController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final StorageService storageService = StorageService();
  ListingService listingService = Get.find<ListingRepository>();

  final RxBool isLoading = false.obs;
  final currentPswdController = TextEditingController();
  final newPswdController = TextEditingController();
  final confirmPswdController = TextEditingController();

  final currentPswdFocusNode = FocusNode();
  final newPswdFocusNode = FocusNode();
  final confirmPswdFocusNode = FocusNode();

  performReset() async {
    isLoading.value = true;
    var isConnectedToInternet = await isInternetAvailable();
    if (isConnectedToInternet) {
      try {
        CommonResponse response = await listingService
            .resetPassword(storageService.getToken() ?? '', {
          "current_password": currentPswdController.text.trim(),
          "new_password": newPswdController.text.trim(),
          "confirm_password": confirmPswdController.text.trim()
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
