import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

import '../../../domain/core/interfaces/common_alert.dart';
import '../../../domain/core/interfaces/utility_services.dart';
import '../../../domain/listing/listing_repository.dart';
import '../../../domain/listing/listing_service.dart';
import '../../../domain/listing/models/house_registration_model.dart';
import '../../../infrastructure/dal/services/storage_service.dart';
import '../../../infrastructure/theme/strings/app_strings.dart';

class MarriageRegistrationController extends GetxController {
  final GlobalKey<FormState> detailsKey = GlobalKey<FormState>();

  ListingService listingService = Get.find<ListingRepository>();
  final StorageService _storageService = StorageService();

  RxBool isExpanded = false.obs;
  RxBool isGroomDetailsExpanded = false.obs;
  RxBool isBrideDetailsExpanded = false.obs;
  RxBool isWitnessDetailsExpanded = false.obs;
  RxBool isGroomOurMahall = false.obs;
  RxBool isBrideOurMahall = false.obs;
  RxBool isDataLoading = false.obs;
  RxBool isHouseDataSuccessful = false.obs;

  int groomHouseId = 0;
  int brideHouseId = 0;

  RxList<HouseData> houseData = RxList([]);

  final mahallNameController = TextEditingController();
  final committeeNameController = TextEditingController();
  final mahallAddressController = TextEditingController();
  final regNoController = TextEditingController();
  final groomNameController = TextEditingController();
  final groomFatherNameController = TextEditingController();
  final groomMotherNameController = TextEditingController();
  final groomAddressController = TextEditingController();
  final groomPhoneController = TextEditingController();
  final brideNameController = TextEditingController();
  final brideFatherNameController = TextEditingController();
  final brideMotherNameController = TextEditingController();
  final brideAddressController = TextEditingController();
  final bridePhoneController = TextEditingController();
  final witness1NameController = TextEditingController();
  final witness1PhoneController = TextEditingController();
  final witness2NameController = TextEditingController();
  final witness2PhoneController = TextEditingController();

  final mahallNameFocusNode = FocusNode();
  final committeeNameFocusNode = FocusNode();
  final mahallAddressFocusNode = FocusNode();
  final regNoFocusNode = FocusNode();
  final groomNameFocusNode = FocusNode();
  final groomFatherNameFocusNode = FocusNode();
  final groomMotherNameFocusNode = FocusNode();
  final groomAddressFocusNode = FocusNode();
  final groomPhoneFocusNode = FocusNode();
  final brideNameFocusNode = FocusNode();
  final brideFatherNameFocusNode = FocusNode();
  final brideMotherNameFocusNode = FocusNode();
  final brideAddressFocusNode = FocusNode();
  final bridePhoneFocusNode = FocusNode();
  final witness1NameFocusNode = FocusNode();
  final witness1PhoneFocusNode = FocusNode();
  final witness2NameFocusNode = FocusNode();
  final witness2PhoneFocusNode = FocusNode();

  @override
  onInit() {
    super.onInit();
    getHouseDetailsList();
  }

  getHouseDetailsList() async {
    isDataLoading.value = true;
    var isConnectedToInternet = await isInternetAvailable();
    if (isConnectedToInternet) {
      try {
        HouseRegistrationModel response = await listingService
            .getHouseDetails(_storageService.getToken() ?? '');
        print('token is : ${_storageService.getToken()}');
        if (response.status == true) {
          houseData.addAll(response.data!);
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
}
