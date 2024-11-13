import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mahall_manager/domain/core/interfaces/utilities.dart';
import 'package:mahall_manager/infrastructure/dal/services/notofication_services.dart';
import 'package:mahall_manager/infrastructure/navigation/routes.dart';
import 'package:mahall_manager/infrastructure/theme/strings/app_strings.dart';

import '../../../domain/core/interfaces/snackbar_service.dart';
import '../../../domain/listing/listing_repository.dart';
import '../../../domain/listing/listing_service.dart';
import '../../../domain/listing/models/login_model.dart';
import '../../../infrastructure/dal/services/storage_service.dart';

class LoginController extends GetxController {
  ListingService listingService = Get.find<ListingRepository>();
  NotificationServices notificationServices = NotificationServices();

  final StorageService _storageService = StorageService();
  RxString selectedLanguage = 'English'.obs;
  RxBool showPassword = false.obs;
  RxBool isLoading = false.obs;
  DateTime? lastPressedAt;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final mobileController = TextEditingController();
  final passwordController = TextEditingController();

  final mobileFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  final SnackbarService _snackbarService = Get.put(SnackbarService());

  @override
  void onInit() {
    super.onInit();
    notificationServices.requestNotificationPermission();
    notificationServices.firebaseInit();
    notificationServices.getDeviceToken().then((val) {
      print('Device Token :- \n$val');
    });
    mobileController.text = "9995560424";
    passwordController.text = "admin123";
    String lang = _storageService.getPreferredLanguage() ?? 'en';
    try {
      selectedLanguage.value = Utilities.languages
          .firstWhere((element) => element['code'] == lang)['name']!;
    } catch (e) {
      selectedLanguage.value = 'English';
      _storageService.savePreferredLanguage('en');
    }

    Get.updateLocale(Locale(lang));
  }

  void changeLanguage(String lang) {
    String langCode = Utilities.languages
        .firstWhere((element) => element['name'] == lang)['code']!;

    final storage = GetStorage();
    storage.write(AppStrings.preferredLanguage, langCode);
    Get.updateLocale(Locale(langCode));
  }

  Future<void> performLogin() async {
    isLoading.value = true;
    try {
      LoginModel response = await listingService.loginCheck(
          mobileController.text, passwordController.text);
      if (response.status == true) {
        _snackbarService.showSuccess(response.message.toString(),
            AppLocalizations.of(Get.context!)!.log_in);
        _storageService.saveToken(response.token ?? '');
        _storageService.saveUserType(response.userType.toString());
        Get.offAllNamed(Routes.HOME);
      } else {
        _snackbarService.showError(response.message.toString(),
            AppLocalizations.of(Get.context!)!.log_in);
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong');
    } finally {
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
