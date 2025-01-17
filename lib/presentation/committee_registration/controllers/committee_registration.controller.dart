import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mahall_manager/infrastructure/navigation/routes.dart';
import 'package:toastification/toastification.dart';

import '../../../domain/core/interfaces/utility_services.dart';
import '../../../domain/listing/listing_repository.dart';
import '../../../domain/listing/listing_service.dart';
import '../../../domain/listing/models/common_response.dart';
import '../../../domain/listing/models/input_models/mahall_registration_input_model.dart';
import '../../../domain/listing/models/mahall_registration_or_details_model.dart';
import '../../../infrastructure/dal/services/storage_service.dart';
import '../../../infrastructure/theme/strings/app_strings.dart';

class CommitteeRegistrationController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  ListingService listingService = Get.find<ListingRepository>();

  final StorageService _storageService = StorageService();
  final RxBool isEditMode = false.obs;
  final RxBool isLoading = false.obs;
  final RxString adminCode = ''.obs; //superAdmin=0,admin=1,user=2,

  int? mahallId;
  int? presedentId;
  int? secretaryId;
  int? treasurerId;

  @override
  void onInit() {
    adminCode.value = _storageService.getUserType() ?? '';
    if (adminCode.value == '1') {
      getMahallDetails();
    }
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

  final presidentDesignationFocusNode = FocusNode();
  final secretaryDesignationFocusNode = FocusNode();
  final treasurerDesignationFocusNode = FocusNode();

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

  final presidentDesignationController = TextEditingController();
  final secretaryDesignationController = TextEditingController();
  final treasurerDesignationController = TextEditingController();

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
                      designation: presidentDesignationController.text.trim(),
                      firstName: presidentFNameController.text.trim(),
                      lastName: presidentLNameController.text.trim(),
                      phone: int.parse(presidentMobileController.text.trim())),
                  Admins(
                      role: 1,
                      designation: secretaryDesignationController.text.trim(),
                      firstName: secretaryFNameController.text.trim(),
                      lastName: secretaryLNameController.text.trim(),
                      phone: int.parse(secretaryMobileController.text.trim())),
                  Admins(
                      role: 2,
                      designation: treasurerDesignationController.text.trim(),
                      firstName: treasurerFNameController.text.trim(),
                      lastName: treasurerLNameController.text.trim(),
                      phone: int.parse(treasurerMobileController.text.trim())),
                ]));
        if (response.status == true) {
          showToast(
              title: response.message.toString(),
              type: ToastificationType.success);
          _storageService.saveMahallName(mahallNameController.text.trim());
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
    presidentDesignationController.clear();
    presidentFNameController.clear();
    presidentLNameController.clear();
    presidentMobileController.clear();
  }

  clearSecretaryDetails() {
    secretaryDesignationController.clear();
    secretaryFNameController.clear();
    secretaryLNameController.clear();
    secretaryMobileController.clear();
  }

  clearTreasurerDetails() {
    treasurerDesignationController.clear();
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
    presidentDesignationFocusNode.dispose();
    secretaryDesignationFocusNode.dispose();
    treasurerDesignationFocusNode.dispose();
    presidentDesignationController.dispose();
    secretaryDesignationController.dispose();
    treasurerDesignationController.dispose();
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

  getMahallDetails() async {
    isLoading.value = true;
    var isConnectedToInternet = await isInternetAvailable();
    if (isConnectedToInternet) {
      try {
        MahallRegistrationOrDetailsModel response = await listingService
            .getMahallDetails(_storageService.getToken() ?? '');
        if (response.status == true) {
          showDetails(response.masjid!, response.admins!);
          print('resss get admin ::: ${jsonEncode(response.admins)}');
          mahallId = response.masjid!.id!.toInt();
          presedentId = response.admins![0].id;
          secretaryId = response.admins![1].id;
          treasurerId = response.admins![2].id;

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
        print('Exception in get committee $e');
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

  showDetails(Masjid masjid, List<GetAdmins> admins) {
    mahallNameController.text = masjid.name ?? '';
    mahallAddressController.text = masjid.address ?? '';
    mahallPinController.text = masjid.pincode.toString();
    mahallCodeController.text = masjid.code.toString();

    presidentDesignationController.text = admins[0].designation ?? '';
    presidentFNameController.text = admins[0].firstName ?? '';
    presidentLNameController.text = admins[0].lastName ?? '';
    presidentMobileController.text = admins[0].phone ?? '';

    secretaryDesignationController.text = admins[1].designation ?? '';
    secretaryFNameController.text = admins[1].firstName ?? '';
    secretaryLNameController.text = admins[1].lastName ?? '';
    secretaryMobileController.text = admins[1].phone ?? '';

    treasurerDesignationController.text = admins[2].designation ?? '';
    treasurerFNameController.text = admins[2].firstName ?? '';
    treasurerLNameController.text = admins[2].lastName ?? '';
    treasurerMobileController.text = admins[2].phone ?? '';
  }

  performEdit() async {
    isLoading.value = true;
    var isConnectedToInternet = await isInternetAvailable();
    if (isConnectedToInternet) {
      try {
        print('IDs :::: $presedentId, $secretaryId, $treasurerId');
        MahallRegistrationInputModel inputModel = MahallRegistrationInputModel(
            id: mahallId,
            name: mahallNameController.text.trim(),
            code: mahallCodeController.text.trim(),
            address: mahallAddressController.text.trim(),
            pincode: int.parse(mahallPinController.text.trim()),
            admins: [
              Admins(
                  id: presedentId,
                  role: 0,
                  designation: presidentDesignationController.text.trim(),
                  firstName: presidentFNameController.text.trim(),
                  lastName: presidentLNameController.text.trim(),
                  phone: int.parse(presidentMobileController.text.trim())),
              Admins(
                  id: secretaryId,
                  role: 1,
                  designation: secretaryDesignationController.text.trim(),
                  firstName: secretaryFNameController.text.trim(),
                  lastName: secretaryLNameController.text.trim(),
                  phone: int.parse(secretaryMobileController.text.trim())),
              Admins(
                  id: treasurerId,
                  role: 2,
                  designation: treasurerDesignationController.text.trim(),
                  firstName: treasurerFNameController.text.trim(),
                  lastName: treasurerLNameController.text.trim(),
                  phone: int.parse(treasurerMobileController.text.trim())),
            ]);
        print('update committee input : ${inputModel.toJson()}');
        CommonResponse response = await listingService.updateMahallDetails(
            _storageService.getToken() ?? '', inputModel);
        if (response.status == true) {
          showToast(
              title: response.message.toString(),
              type: ToastificationType.success);
          _storageService.saveMahallName(mahallNameController.text.trim());
          if (adminCode.value == '0') {
            clearAll();
          }
          if (adminCode.value == '1') {
            clearAll();
            Get.offAllNamed(Routes.HOME);
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
}
