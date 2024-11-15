import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

import '../../../domain/core/interfaces/common_alert.dart';
import '../../../domain/core/interfaces/utility_services.dart';
import '../../../domain/listing/listing_repository.dart';
import '../../../domain/listing/listing_service.dart';
import '../../../domain/listing/models/common_response.dart';
import '../../../domain/listing/models/mahall_registration_input_model.dart';
import '../../../infrastructure/dal/services/storage_service.dart';
import '../../../infrastructure/theme/strings/app_strings.dart';

class CommitteeRegistrationController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  ListingService listingService = Get.find<ListingRepository>();

  final StorageService _storageService = StorageService();
  final RxBool isEditMode = false.obs;
  final RxBool isLoading = false.obs;
  final RxString adminCode = ''.obs; //superAdmin=0,admin=1,user=2,
  @override
  void onInit() {
    adminCode.value = _storageService.getUserType() ?? '';
    print('adminCode::: $adminCode');
    if (adminCode.value == '0') {
      isEditMode.value = true;
    } else {
      isEditMode.value = false;
    }
    super.onInit();
  }

  final mahallNameFocusNode = FocusNode();
  final mahallCodeFocusNode = FocusNode();
  final mahallAddressFocusNode = FocusNode();
  final mahallPinFocusNode = FocusNode();

  final presidentFNameFocusNode = FocusNode();
  final secretaryFNameFocusNode = FocusNode();
  final treasurerFNameFocusNode = FocusNode();

  final presidentLNameFocusNode = FocusNode();
  final secretaryLNameFocusNode = FocusNode();
  final treasurerLNameFocusNode = FocusNode();

  final presidentMobileFocusNode = FocusNode();
  final secretaryMobileFocusNode = FocusNode();
  final treasurerMobileFocusNode = FocusNode();

  final presidentPasswordFocusNode = FocusNode();
  final secretaryPasswordFocusNode = FocusNode();
  final treasurerPasswordFocusNode = FocusNode();

  final mahallNameController = TextEditingController();
  final mahallCodeController = TextEditingController();
  final mahallAddressController = TextEditingController();
  final mahallPinController = TextEditingController();

  final presidentFNameController = TextEditingController();
  final secretaryFNameController = TextEditingController();
  final treasurerFNameController = TextEditingController();

  final presidentLNameController = TextEditingController();
  final secretaryLNameController = TextEditingController();
  final treasurerLNameController = TextEditingController();

  final presidentMobileController = TextEditingController();
  final secretaryMobileController = TextEditingController();
  final treasurerMobileController = TextEditingController();

  final presidentPasswordController = TextEditingController();
  final secretaryPasswordController = TextEditingController();
  final treasurerPasswordController = TextEditingController();

  performCommitteeRegistration() async {
    isLoading.value = true;
    var isConnectedToInternet = await isInternetAvailable();
    if (isConnectedToInternet) {
      try {
        CommonResponse response = await listingService.mahallRegistration(
            _storageService.getToken() ?? '',
            MahallRegistrationInputModel(
                name: mahallNameController.text.trim(),
                code: mahallCodeController.text.trim(),
                address: mahallAddressController.text.trim(),
                pincode: int.parse(mahallPinController.text.trim()),
                admins: [
                  Admins(
                      role: 0,
                      firstName: presidentFNameController.text.trim(),
                      lastName: presidentLNameController.text.trim(),
                      phone: int.parse(presidentMobileController.text.trim())),
                  Admins(
                      role: 1,
                      firstName: secretaryFNameController.text.trim(),
                      lastName: secretaryLNameController.text.trim(),
                      phone: int.parse(secretaryMobileController.text.trim())),
                  Admins(
                      role: 2,
                      firstName: treasurerFNameController.text.trim(),
                      lastName: treasurerLNameController.text.trim(),
                      phone: int.parse(treasurerMobileController.text.trim())),
                ]));
        if (response.status == true) {
          showToast(
              title: response.message.toString(),
              type: ToastificationType.success);
          if (adminCode.value == '0') {
            clearAll();
          }
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

  clearAll() {
    mahallNameController.clear();
    mahallCodeController.clear();
    mahallAddressController.clear();
    mahallPinController.clear();
    clearPresidentDetails();
    clearSecretaryDetails();
    clearTreasurerDetails();
  }

  clearPresidentDetails() {
    presidentFNameController.clear();
    presidentLNameController.clear();
    presidentMobileController.clear();
  }

  clearSecretaryDetails() {
    secretaryFNameController.clear();
    secretaryLNameController.clear();
    secretaryMobileController.clear();
  }

  clearTreasurerDetails() {
    treasurerFNameController.clear();
    treasurerLNameController.clear();
    treasurerMobileController.clear();
  }

  @override
  void onClose() {
    disposeAll();
    super.onClose();
  }

  disposeAll() {
    mahallNameFocusNode.dispose();
    mahallAddressFocusNode.dispose();
    mahallPinFocusNode.dispose();
    presidentFNameFocusNode.dispose();
    secretaryFNameFocusNode.dispose();
    treasurerFNameFocusNode.dispose();
    presidentLNameFocusNode.dispose();
    secretaryLNameFocusNode.dispose();
    treasurerLNameFocusNode.dispose();
    presidentMobileFocusNode.dispose();
    secretaryMobileFocusNode.dispose();
    treasurerMobileFocusNode.dispose();
    presidentPasswordFocusNode.dispose();
    secretaryPasswordFocusNode.dispose();
    treasurerPasswordFocusNode.dispose();
    mahallNameController.dispose();
    mahallAddressController.dispose();
    mahallPinController.dispose();
    presidentFNameController.dispose();
    secretaryFNameController.dispose();
    treasurerFNameController.dispose();
    presidentLNameController.dispose();
    secretaryLNameController.dispose();
    treasurerLNameController.dispose();
    presidentMobileController.dispose();
    secretaryMobileController.dispose();
    treasurerMobileController.dispose();
    presidentPasswordController.dispose();
    secretaryPasswordController.dispose();
    treasurerPasswordController.dispose();
  }

  performEdit() {}
}
