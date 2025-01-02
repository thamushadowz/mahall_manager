import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mahall_manager/domain/listing/models/committee_details_model.dart';
import 'package:mahall_manager/domain/listing/models/common_response.dart';
import 'package:toastification/toastification.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../domain/core/interfaces/utility_services.dart';
import '../../../domain/listing/listing_repository.dart';
import '../../../domain/listing/listing_service.dart';
import '../../../infrastructure/dal/services/storage_service.dart';
import '../../../infrastructure/theme/strings/app_strings.dart';

class CommitteeDetailsController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final StorageService storageService = StorageService();
  ListingService listingService = Get.find<ListingRepository>();

  RxBool isLoading = false.obs;
  RxBool isDataLoading = false.obs;
  var committeeList = <CommitteeDetailsData>[].obs;
  String userType = '';

  final designationController = TextEditingController();
  final nameController = TextEditingController();
  final mobileController = TextEditingController();

  final designationFocusNode = FocusNode();
  final nameFocusNode = FocusNode();
  final mobileFocusNode = FocusNode();

  @override
  onInit() {
    super.onInit();
    userType = storageService.getUserType() ?? '';
    getCommitteeDetails();
  }

  getCommitteeDetails() async {
    committeeList.clear();
    isDataLoading.value = true;
    var isConnectedToInternet = await isInternetAvailable();
    if (isConnectedToInternet) {
      try {
        CommitteeDetailsModel response = await listingService
            .getCommitteeDetails(storageService.getToken() ?? '');
        if (response.status == true) {
          committeeList.addAll(response.data ?? []);
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
        isDataLoading.value = false;
      }
    } else {
      showToast(
          title: AppStrings.noInternetConnection,
          type: ToastificationType.error);
      isDataLoading.value = false;
    }
  }

  addCommitteeDetails() async {
    isLoading.value = true;
    var isConnectedToInternet = await isInternetAvailable();
    if (isConnectedToInternet) {
      try {
        CommonResponse response = await listingService
            .addCommitteeDetails(storageService.getToken() ?? '', {
          'designation': designationController.text.trim(),
          'name': nameController.text.trim(),
          'phone': mobileController.text.trim()
        });
        if (response.status == true) {
          showToast(
              title: response.message.toString(),
              type: ToastificationType.success);
          getCommitteeDetails();
          designationController.clear();
          nameController.clear();
          mobileController.clear();
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

  updateCommitteeDetails(int id) async {
    isLoading.value = true;
    var isConnectedToInternet = await isInternetAvailable();
    if (isConnectedToInternet) {
      try {
        CommonResponse response = await listingService
            .updateCommitteeDetails(storageService.getToken() ?? '', {
          'id': id.toString(),
          'designation': designationController.text.trim(),
          'name': nameController.text.trim(),
          'phone': mobileController.text.trim()
        });
        if (response.status == true) {
          showToast(
              title: response.message.toString(),
              type: ToastificationType.success);
          getCommitteeDetails();
          designationController.clear();
          nameController.clear();
          mobileController.clear();
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

  deleteCommitteeDetails(int id) async {
    isDataLoading.value = true;
    var isConnectedToInternet = await isInternetAvailable();
    if (isConnectedToInternet) {
      try {
        CommonResponse response = await listingService.deleteCommitteeDetails(
            storageService.getToken() ?? '', {'id': id.toString()});
        if (response.status == true) {
          showToast(
              title: response.message.toString(),
              type: ToastificationType.success);
          getCommitteeDetails();
          designationController.clear();
          nameController.clear();
          mobileController.clear();
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
        isDataLoading.value = false;
      }
    } else {
      showToast(
          title: AppStrings.noInternetConnection,
          type: ToastificationType.error);
      isDataLoading.value = false;
    }
  }

  Future<void> launchDialer(String number) async {
    final Uri url = Uri(scheme: 'tel', path: number);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  launchWhatsApp(String phoneNumber) async {
    final Uri whatsappUri = Uri.parse("whatsapp://send?phone=$phoneNumber");
    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri);
    } else {}
  }
}
