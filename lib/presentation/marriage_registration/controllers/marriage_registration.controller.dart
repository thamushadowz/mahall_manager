import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mahall_manager/domain/listing/models/input_models/MarriageRegistrationInputModel.dart';
import 'package:toastification/toastification.dart';

import '../../../domain/core/interfaces/common_alert.dart';
import '../../../domain/core/interfaces/utility_services.dart';
import '../../../domain/listing/listing_repository.dart';
import '../../../domain/listing/listing_service.dart';
import '../../../domain/listing/models/MarriageRegistrationModel.dart';
import '../../../domain/listing/models/house_registration_model.dart';
import '../../../domain/listing/models/mahall_registration_or_details_model.dart';
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
  RxBool isLoading = false.obs;
  RxBool isHouseDataSuccessful = false.obs;
  RxBool isRegistrationSuccess = true.obs;

  int groomHouseId = 0;
  int brideHouseId = 0;

  RxList<HouseData> houseData = RxList([]);
  List<MarriageData> marriageDetails = [];

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
    getMahallDetails();
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

  getMahallDetails() async {
    isDataLoading.value = true;
    var isConnectedToInternet = await isInternetAvailable();
    if (isConnectedToInternet) {
      try {
        MahallRegistrationOrDetailsModel response = await listingService
            .getMahallDetails(_storageService.getToken() ?? '');
        print('token is : ${_storageService.getToken()}');
        if (response.status == true) {
          committeeNameController.text = response.masjid!.name ?? '';
          mahallAddressController.text = response.masjid!.address ?? '';
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
        isDataLoading.value = false;
      }
    } else {
      showToast(
          title: AppStrings.noInternetConnection,
          type: ToastificationType.error);
      isDataLoading.value = false;
    }
  }

  registerMarriage() async {
    final params = MarriageRegistrationInputModel(
      registerNo: regNoController.text.trim(),
      groomName: groomNameController.text.trim(),
      groomFatherName: groomFatherNameController.text.trim(),
      groomMotherName: groomMotherNameController.text.trim(),
      isGroomMahallee: isGroomOurMahall.value,
      groomAddress: groomAddressController.text.trim(),
      groomHouseId: isGroomOurMahall.value ? groomHouseId : null,
      groomPhone: groomPhoneController.text.trim(),
      brideName: brideNameController.text.trim(),
      brideFatherName: brideFatherNameController.text.trim(),
      brideMotherName: brideMotherNameController.text.trim(),
      isBrideMahallee: isBrideOurMahall.value,
      brideAddress: brideAddressController.text.trim(),
      brideHouseId: isBrideOurMahall.value ? brideHouseId : null,
      bridePhone: bridePhoneController.text.trim(),
      witness1Name: witness1NameController.text.trim(),
      witness1Phone: witness1PhoneController.text.trim(),
      witness2Name: witness2NameController.text.trim(),
      witness2Phone: witness2PhoneController.text.trim(),
    );
    isLoading.value = true;
    var isConnectedToInternet = await isInternetAvailable();
    if (isConnectedToInternet) {
      try {
        MarriageRegistrationModel response = await listingService
            .registerMarriage(_storageService.getToken() ?? '', params);
        if (response.status == true) {
          showToast(
              title: response.message.toString(),
              type: ToastificationType.success);
          isRegistrationSuccess.value = true;
          marriageDetails.addAll(response.data!);
        } else {
          showToast(
              title: response.message.toString(),
              type: ToastificationType.error);
          isRegistrationSuccess.value = false;
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

  disposeAll() {
    committeeNameController.dispose();
    mahallAddressController.dispose();
    regNoController.dispose();
    groomNameController.dispose();
    groomFatherNameController.dispose();
    groomMotherNameController.dispose();
    groomAddressController.dispose();
    groomPhoneController.dispose();
    brideNameController.dispose();
    brideFatherNameController.dispose();
    brideMotherNameController.dispose();
    brideAddressController.dispose();
    bridePhoneController.dispose();
    witness1NameController.dispose();
    witness1PhoneController.dispose();
    witness2NameController.dispose();
    witness2PhoneController.dispose();
    committeeNameFocusNode.dispose();
    mahallAddressFocusNode.dispose();
    regNoFocusNode.dispose();
    groomNameFocusNode.dispose();
    groomFatherNameFocusNode.dispose();
    groomMotherNameFocusNode.dispose();
    groomAddressFocusNode.dispose();
    groomPhoneFocusNode.dispose();
    brideNameFocusNode.dispose();
    brideFatherNameFocusNode.dispose();
    brideMotherNameFocusNode.dispose();
    brideAddressFocusNode.dispose();
    bridePhoneFocusNode.dispose();
    witness1NameFocusNode.dispose();
    witness1PhoneFocusNode.dispose();
    witness2NameFocusNode.dispose();
    witness2PhoneFocusNode.dispose();
  }

  @override
  void onClose() {
    super.onClose();
    disposeAll();
  }

  void savePdf() async {
    /*String pdfUrl = marriageDetails.first.certificateUrl.toString();
    String fileName =
        '${marriageDetails.first.groomName} - ${marriageDetails.first.brideName} [${marriageDetails.first.marriageRegNo}]';*/
    String pdfUrl =
        'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf';
    String fileName = 'sample.pdf';

    String? path = await downloadPdfToExternal(pdfUrl, fileName);
    if (path != null) {
      print("PDF saved at: $path");
    } else {
      print("Failed to save PDF.");
    }
  }
}
