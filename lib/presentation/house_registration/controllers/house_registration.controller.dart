import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

import '../../../domain/core/interfaces/utility_services.dart';
import '../../../domain/listing/listing_repository.dart';
import '../../../domain/listing/listing_service.dart';
import '../../../domain/listing/models/common_response.dart';
import '../../../domain/listing/models/get_place_model.dart';
import '../../../infrastructure/dal/services/storage_service.dart';
import '../../../infrastructure/theme/strings/app_strings.dart';

class HouseRegistrationController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final StorageService _storageService = StorageService();
  ListingService listingService = Get.find<ListingRepository>();

  RxBool isHouseRegistrationSuccess = false.obs;
  final RxBool isPlaceDataSuccessful = false.obs;
  final RxBool isLoading = false.obs;
  final RxBool isDataLoading = false.obs;

  RxList<PlaceData> placeData = RxList([]);
  String mainHeading = AppStrings.houseRegistration;

  int placeId = 0;

  final regNoFocusNode = FocusNode();
  final houseNameFocusNode = FocusNode();
  final placeNameFocusNode = FocusNode();

  final regNoController = TextEditingController();
  final houseNameController = TextEditingController();
  final placeNameController = TextEditingController();

  String houseNameKey = '';
  num houseId = 0;
  bool isEditScreen = false;
  final args = Get.arguments;

  @override
  void onInit() {
    super.onInit();
    if (args != null) {
      houseNameKey = args['key_name'];
      isEditScreen = args['is_from_edit'];
      seperateKeyToIdAndName();
    } else {
      getPlaceDetailsList();
    }
  }

  seperateKeyToIdAndName() {
    regNoController.text = houseNameKey.split(' - ').first.toString().trim();
    houseNameController.text = houseNameKey
        .split(' - ')
        .last
        .toString()
        .trim()
        .split(' : ')
        .first
        .toString()
        .trim();
    houseId = int.parse(houseNameKey.split(' : ').last.toString().trim());
  }

  @override
  void onClose() {
    disposeAll();
    super.onClose();
  }

  disposeAll() {
    regNoFocusNode.dispose();
    houseNameFocusNode.dispose();
    regNoController.dispose();
    houseNameController.dispose();
  }

  resetForm() {
    regNoController.clear();
    houseNameController.clear();
  }

  performHouseRegistration() async {
    isLoading.value = true;
    var isConnectedToInternet = await isInternetAvailable();
    if (isConnectedToInternet) {
      try {
        CommonResponse response = await listingService
            .houseRegistration(_storageService.getToken() ?? '', {
          'reg_number': regNoController.text.trim(),
          'name': houseNameController.text.trim(),
          'place_id': placeId
        });
        if (response.status == true) {
          showToast(
              title: response.message.toString(),
              type: ToastificationType.success);
          resetForm();
          isHouseRegistrationSuccess.value = true;
        } else {
          isHouseRegistrationSuccess.value = false;
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
        isHouseRegistrationSuccess.value = false;
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

  getPlaceDetailsList() async {
    isDataLoading.value = true;
    var isConnectedToInternet = await isInternetAvailable();
    if (isConnectedToInternet) {
      try {
        GetPlaceModel response = await listingService
            .getPlaceDetails(_storageService.getToken() ?? '');
        if (response.status == true) {
          placeData.addAll(response.data!);
          isPlaceDataSuccessful.value = true;
        } else {
          isPlaceDataSuccessful.value = false;
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

  updateHouseName() async {
    isLoading.value = true;
    var isConnectedToInternet = await isInternetAvailable();
    if (isConnectedToInternet) {
      try {
        CommonResponse response =
            await listingService.updateHouse(_storageService.getToken() ?? '', {
          'id': houseId,
          'name': houseNameController.text.trim(),
        });
        if (response.status == true) {
          showToast(
              title: response.message.toString(),
              type: ToastificationType.success);
          Get.back(result: true);
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
        isHouseRegistrationSuccess.value = false;
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
