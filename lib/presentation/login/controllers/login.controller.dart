import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mahall_manager/domain/core/interfaces/utilities.dart';
import 'package:mahall_manager/infrastructure/dal/services/notofication_services.dart';
import 'package:mahall_manager/infrastructure/navigation/routes.dart';
import 'package:mahall_manager/infrastructure/theme/strings/app_strings.dart';
import 'package:toastification/toastification.dart';

import '../../../domain/core/interfaces/utility_services.dart';
import '../../../domain/listing/listing_repository.dart';
import '../../../domain/listing/listing_service.dart';
import '../../../domain/listing/models/GetMasjidListModel.dart';
import '../../../domain/listing/models/login_model.dart';
import '../../../infrastructure/dal/services/storage_service.dart';

class LoginController extends GetxController {
  ListingService listingService = Get.find<ListingRepository>();
  NotificationServices notificationServices = NotificationServices();

  final StorageService _storageService = StorageService();
  RxString selectedLanguage = 'English'.obs;
  RxString mobileNumber = ''.obs;
  RxBool showPassword = false.obs;
  RxBool isLoading = false.obs;
  RxBool isDataLoading = false.obs;
  RxBool isDataFetchSuccessful = false.obs;
  RxBool canPop = false.obs;
  DateTime? lastPressedAt;
  List<MasjidListData> masjidList = [];
  int masjidId = 0;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final mobileController = TextEditingController();
  final masjidListController = TextEditingController();
  final passwordController = TextEditingController();

  final mobileFocusNode = FocusNode();
  final masjidListFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  @override
  void onInit() {
    super.onInit();
    mobileController.addListener(() {
      mobileNumber.value = mobileController.text;
      if (mobileNumber.value.isEmpty) {
        isDataFetchSuccessful.value = false;
      }
    });
    notificationServices.requestNotificationPermission();
    notificationServices.firebaseInit(Get.context!);
    notificationServices.getDeviceToken().then((val) {});

    String lang = _storageService.getPreferredLanguage() ?? 'en';
    try {
      selectedLanguage.value = Utilities.languages
          .firstWhere((element) => element['code'] == lang)['name']!;
    } catch (e) {
      selectedLanguage.value = 'English';
      _storageService.savePreferredLanguage('en');
    }

    //Get.updateLocale(Locale(lang));
  }

  void changeLanguage(String lang) {
    String langCode = Utilities.languages
        .firstWhere((element) => element['name'] == lang)['code']!;

    final storage = GetStorage();
    storage.write(AppStrings.preferredLanguage, langCode);
    Get.updateLocale(Locale(langCode));
  }

  Future<void> getMasjidsList() async {
    isLoading.value = true;
    masjidList.clear();
    var isConnectedToInternet = await isInternetAvailable();
    if (isConnectedToInternet) {
      try {
        GetMasjidListModel response = await listingService
            .getMasjidsList({'phone': mobileController.text.trim()});
        print('response is ::: ${jsonEncode(response)}');
        if (response.status == true) {
          masjidList.addAll(response.data ?? []);
          if (masjidList.length == 1) {
            masjidListController.text =
                '${masjidList[0].code} - ${masjidList[0].name}';
            masjidId = masjidList[0].id!.toInt();
          }
          isDataFetchSuccessful.value = true;
        } else {
          isDataFetchSuccessful.value = false;
          showToast(
              title: response.message ?? '', type: ToastificationType.error);
        }
      } catch (e) {
        isDataFetchSuccessful.value = false;
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

  Future<void> performLogin() async {
    isLoading.value = true;
    var isConnectedToInternet = await isInternetAvailable();
    if (isConnectedToInternet) {
      try {
        LoginModel response = await listingService.loginCheck(
            mobileController.text.trim(),
            masjidId.toString(),
            passwordController.text.trim(),
            await notificationServices.getDeviceToken());
        if (response.status == true) {
          showToast(
              title: response.message.toString(),
              type: ToastificationType.success);

          _storageService.saveToken('Bearer ${response.token}');
          _storageService.saveUserType(response.userType.toString());
          _storageService.saveMahallName(response.mahallName ?? '');
          if (passwordController.text.trim() == 'admin123') {
            Get.offAllNamed(Routes.RESET_PASSWORD);
          } else {
            Get.offAllNamed(Routes.HOME);
          }
        } else {
          showToast(
              title: response.message.toString(),
              type: ToastificationType.error);
        }
      } catch (e) {
        Get.snackbar('Error', 'Something went wrong');
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

  @override
  void onClose() {
    /*mobileFocusNode.dispose();
    passwordFocusNode.dispose();*/
    super.onClose();
  }
}
