import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:mahall_manager/domain/core/interfaces/utility_services.dart';
import 'package:toastification/toastification.dart';

import '../../../infrastructure/navigation/routes.dart';

class ResetPasswordController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final RxBool isLoading = false.obs;
  final currentPswdController = TextEditingController();
  final newPswdController = TextEditingController();
  final confirmPswdController = TextEditingController();

  final currentPswdFocusNode = FocusNode();
  final newPswdFocusNode = FocusNode();
  final confirmPswdFocusNode = FocusNode();

  performReset() {
    showToast(
        title: AppLocalizations.of(Get.context!)!.password_reset_success,
        type: ToastificationType.success);
    Get.offAllNamed(Routes.LOGIN);
  }
}
