import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mahall_manager/domain/listing/models/GetDeceasedListModel.dart';
import 'package:toastification/toastification.dart';

import '../../../domain/core/interfaces/common_alert.dart';
import '../../../domain/core/interfaces/utility_services.dart';
import '../../../domain/listing/listing_repository.dart';
import '../../../domain/listing/listing_service.dart';
import '../../../infrastructure/dal/services/storage_service.dart';
import '../../../infrastructure/theme/strings/app_strings.dart';

class DeathListController extends GetxController {
  final StorageService storageService = StorageService();
  ListingService listingService = Get.find<ListingRepository>();

  RxList<DeceasedData> deathList = RxList([]);

  final deathSearchController = TextEditingController();
  RxBool isLoading = false.obs;

  @override
  onInit() {
    super.onInit();
    getDeceasedList();
  }

  getDeceasedList() async {
    isLoading.value = true;
    var isConnectedToInternet = await isInternetAvailable();
    if (isConnectedToInternet) {
      try {
        GetDeceasedListModel response = await listingService
            .getDeceasedList(storageService.getToken() ?? '');
        if (response.status == true) {
          deathList.addAll(response.data!);
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
