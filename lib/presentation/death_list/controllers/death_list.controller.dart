import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mahall_manager/domain/listing/models/GetDeceasedListModel.dart';
import 'package:toastification/toastification.dart';

import '../../../domain/core/interfaces/utility_services.dart';
import '../../../domain/listing/listing_repository.dart';
import '../../../domain/listing/listing_service.dart';
import '../../../infrastructure/dal/services/storage_service.dart';
import '../../../infrastructure/theme/strings/app_strings.dart';

class DeathListController extends GetxController {
  final StorageService storageService = StorageService();
  ListingService listingService = Get.find<ListingRepository>();

  RxList<DeceasedData> deathList = RxList([]);
  RxList<DeceasedData> filteredDeathList = RxList([]);

  final deathSearchController = TextEditingController();
  RxBool isLoading = false.obs;
  RxString searchQuery = ''.obs;

  @override
  onInit() {
    super.onInit();
    getDeceasedList();

    deathSearchController.addListener(() {
      searchUser(deathSearchController.text);
    });
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
          filteredDeathList.assignAll(deathList);
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

  searchUser(String query) {
    searchQuery.value = query.toLowerCase();
    if (searchQuery.isEmpty) {
      filteredDeathList.value = deathList;
    } else {
      filteredDeathList.value = deathList.where((dead) {
        return dead.houseRegNo!
                .toLowerCase()
                .contains(searchQuery.value.toLowerCase()) ||
            dead.houseName!
                .toLowerCase()
                .contains(searchQuery.value.toLowerCase()) ||
            dead.personName!
                .toLowerCase()
                .contains(searchQuery.value.toLowerCase());
      }).toList();
    }
  }
}
