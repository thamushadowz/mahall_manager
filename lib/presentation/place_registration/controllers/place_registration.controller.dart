import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

import '../../../domain/core/interfaces/utility_services.dart';
import '../../../domain/listing/listing_repository.dart';
import '../../../domain/listing/listing_service.dart';
import '../../../domain/listing/models/common_response.dart';
import '../../../infrastructure/dal/services/storage_service.dart';
import '../../../infrastructure/theme/strings/app_strings.dart';

class PlaceRegistrationController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final StorageService _storageService = StorageService();
  ListingService listingService = Get.find<ListingRepository>();

  RxBool isPlaceRegistrationSuccess = false.obs;
  RxInt selectedState = 0.obs;

  final RxBool isLoading = false.obs;
  final placeCodeFocusNode = FocusNode();
  final placeNameFocusNode = FocusNode();
  final stateFocusNode = FocusNode();
  final districtFocusNode = FocusNode();

  final placeCodeController = TextEditingController();
  final placeNameController = TextEditingController();
  final stateController = TextEditingController();
  final districtController = TextEditingController();

  resetForm() {
    placeCodeController.clear();
    placeNameController.clear();
    stateController.clear();
    districtController.clear();
  }

  performPlaceRegistration() async {
    isLoading.value = true;
    var isConnectedToInternet = await isInternetAvailable();
    if (isConnectedToInternet) {
      try {
        CommonResponse response = await listingService
            .placeRegistration(_storageService.getToken() ?? '', {
          'code': placeCodeController.text.trim(),
          'name': placeNameController.text.trim(),
          'state': stateController.text.trim(),
          'district': districtController.text.trim()
        });
        if (response.status == true) {
          showToast(
              title: response.message.toString(),
              type: ToastificationType.success);
          resetForm();
          isPlaceRegistrationSuccess.value = true;
        } else {
          if (response.message != null) {
            showToast(
                title: response.message.toString(),
                type: ToastificationType.error);
          } else {
            showToast(
                title: AppStrings.somethingWentWrong,
                type: ToastificationType.error);
          }
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
    disposeAll();
    super.onClose();
  }

  disposeAll() {
    placeCodeFocusNode.dispose();
    placeNameFocusNode.dispose();
    stateFocusNode.dispose();
    districtFocusNode.dispose();
    placeCodeController.dispose();
    placeNameController.dispose();
    stateController.dispose();
    districtController.dispose();
  }
}
