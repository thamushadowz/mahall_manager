import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mahall_manager/domain/core/interfaces/utilities.dart';
import 'package:mahall_manager/infrastructure/navigation/routes.dart';
import 'package:mahall_manager/infrastructure/theme/strings/app_strings.dart';

import '../../../domain/core/interfaces/snackbar_service.dart';

class LoginController extends GetxController {
  RxString selectedLanguage = 'English'.obs;
  RxBool showPassword = false.obs;
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
    mobileController.text = "9400477889";
    passwordController.text = "admin123";
    final storage = GetStorage();
    String lang = storage.read(AppStrings.preferredLanguage) ?? 'en';

    try {
      selectedLanguage.value = Utilities.languages
          .firstWhere((element) => element['code'] == lang)['name']!;
    } catch (e) {
      selectedLanguage.value = 'English';
      storage.write(AppStrings.preferredLanguage, 'en');
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

  void performLogin() {
    if (mobileController.text == '9400477889' &&
        passwordController.text == 'admin123') {
      _snackbarService.showSuccess(
          AppLocalizations.of(Get.context!)!.login_success,
          AppLocalizations.of(Get.context!)!.log_in);
      Get.offAllNamed(Routes.HOME);
    } else {
      _snackbarService.showError(
          AppLocalizations.of(Get.context!)!.incorrect_mobile_or_password,
          AppLocalizations.of(Get.context!)!.log_in);
    }
  }

  @override
  void onClose() {
    mobileFocusNode.dispose();
    passwordFocusNode.dispose();
    super.onClose();
  }
}
