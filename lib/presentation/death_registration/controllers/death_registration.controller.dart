import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

import '../../../domain/core/interfaces/utility_services.dart';
import '../../../domain/listing/listing_repository.dart';
import '../../../domain/listing/listing_service.dart';
import '../../../domain/listing/models/common_response.dart';
import '../../../domain/listing/models/house_registration_model.dart';
import '../../../infrastructure/dal/services/storage_service.dart';
import '../../../infrastructure/theme/strings/app_strings.dart';

class DeathRegistrationController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final StorageService storageService = StorageService();
  ListingService listingService = Get.find<ListingRepository>();

  final deceasedNameController = TextEditingController();
  final houseDetailsController = TextEditingController();

  final deceasedNameFocusNode = FocusNode();
  final houseDetailsFocusNode = FocusNode();
  RxBool isLoading = false.obs;
  RxBool isDataLoading = false.obs;
  RxBool isHouseDataSuccessful = false.obs;
  List<HouseData> houseDetails = [];
  int houseId = 0;

  @override
  onInit() {
    super.onInit();
    getHouseDetailsList();
  }

  getHouseDetailsList() async {
    isDataLoading.value = true;
    houseDetails.clear();
    var isConnectedToInternet = await isInternetAvailable();
    if (isConnectedToInternet) {
      try {
        HouseRegistrationModel response = await listingService
            .getHouseDetails(storageService.getToken() ?? '');
        if (response.status == true) {
          houseDetails.addAll(response.data!);
          isHouseDataSuccessful.value = true;
        } else {
          isHouseDataSuccessful.value = false;
        }
      } catch (e) {
        showToast(
            title: AppStrings.somethingWentWrong,
            type: ToastificationType.error);
      } finally {
        isDataLoading.value = false;
      }
    } else {
      showToast(
          title: AppStrings.noInternetConnection,
          type: ToastificationType.error);
      isDataLoading.value = false;
    }
  }

  registerDeath() async {
    isLoading.value = true;
    var isConnectedToInternet = await isInternetAvailable();
    if (isConnectedToInternet) {
      try {
        CommonResponse response = await listingService.registerDeath(
            storageService.getToken() ?? '',
            {'house_id': houseId, 'name': deceasedNameController.text.trim()});
        if (response.status == true) {
          showToast(
              title: response.message.toString(),
              type: ToastificationType.success);
          Get.back();
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
