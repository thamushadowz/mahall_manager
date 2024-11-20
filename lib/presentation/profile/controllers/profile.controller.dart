import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

import '../../../domain/core/interfaces/common_alert.dart';
import '../../../domain/core/interfaces/utility_services.dart';
import '../../../domain/listing/listing_repository.dart';
import '../../../domain/listing/listing_service.dart';
import '../../../domain/listing/models/get_house_and_users_model.dart';
import '../../../infrastructure/dal/services/storage_service.dart';
import '../../../infrastructure/theme/strings/app_strings.dart';

class ProfileController extends GetxController {
  final StorageService storageService = StorageService();
  ListingService listingService = Get.find<ListingRepository>();
  RxBool isLoading = false.obs;
  List<PeopleData> userDetails = [];

  @override
  onInit() {
    super.onInit();
    getUserDetails();
  }

  getUserDetails() async {
    isLoading.value = true;
    userDetails.clear();
    var isConnectedToInternet = await isInternetAvailable();
    if (isConnectedToInternet) {
      try {
        GetHouseAndUsersModel response = await listingService
            .getUserProfile(storageService.getToken() ?? '');
        if (response.status == true) {
          userDetails.addAll(response.data!);
        } else {}
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
