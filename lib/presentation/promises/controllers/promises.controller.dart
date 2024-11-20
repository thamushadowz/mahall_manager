import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mahall_manager/domain/listing/models/id_name_model.dart';
import 'package:toastification/toastification.dart';

import '../../../domain/core/interfaces/common_alert.dart';
import '../../../domain/core/interfaces/utility_services.dart';
import '../../../domain/listing/listing_repository.dart';
import '../../../domain/listing/listing_service.dart';
import '../../../domain/listing/models/common_response.dart';
import '../../../domain/listing/models/get_house_and_users_model.dart';
import '../../../infrastructure/dal/services/storage_service.dart';
import '../../../infrastructure/theme/strings/app_strings.dart';

class PromisesController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final StorageService storageService = StorageService();
  ListingService listingService = Get.find<ListingRepository>();

  int userId = 0;
  final RxBool isDataLoading = false.obs;
  final RxBool isLoading = false.obs;
  final dateController = TextEditingController();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final amountController = TextEditingController();

  final nameFocusNode = FocusNode();
  final dateFocusNode = FocusNode();
  final descriptionFocusNode = FocusNode();
  final amountFocusNode = FocusNode();

  List<IdNameModel> userDetails = [];

  @override
  void onInit() {
    super.onInit();
    getUserDetails();
  }

  @override
  void onClose() {
    super.onClose();
    dateController.dispose();
    nameController.dispose();
    descriptionController.dispose();
    amountController.dispose();
    nameFocusNode.dispose();
    dateFocusNode.dispose();
    descriptionFocusNode.dispose();
    amountFocusNode.dispose();
  }

  getUserDetails() async {
    isDataLoading.value = true;
    userDetails.clear();
    var isConnectedToInternet = await isInternetAvailable();
    if (isConnectedToInternet) {
      try {
        GetHouseAndUsersModel response = await listingService
            .getHouseAndUsersDetails(storageService.getToken() ?? '');
        if (response.status == true) {
          userDetails.addAll(response.data!.map((person) => IdNameModel(
              id: person.id,
              name: '${person.userRegNo} - ${person.fName} ${person.lName}')));
          isDataLoading.value = false;
        } else {
          isDataLoading.value = false;
        }
      } catch (e) {
        isDataLoading.value = false;
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

  addPromises() async {
    isLoading.value = true;
    var isConnectedToInternet = await isInternetAvailable();
    if (isConnectedToInternet) {
      try {
        CommonResponse response =
            await listingService.addPromises(storageService.getToken() ?? '', {
          "id": userId,
          "date": getCurrentDate(),
          "description": descriptionController.text.trim(),
          "promised_amount": num.parse(amountController.text.trim())
        });
        if (response.status == true) {
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
}
