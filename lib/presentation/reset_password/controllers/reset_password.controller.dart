import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:mahall_manager/domain/core/interfaces/snackbar_service.dart';

import '../../../infrastructure/navigation/routes.dart';

class ResetPasswordController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final SnackbarService _snackbarService = Get.put(SnackbarService());

  final currentPswdController = TextEditingController();
  final newPswdController = TextEditingController();
  final confirmPswdController = TextEditingController();

  final currentPswdFocusNode = FocusNode();
  final newPswdFocusNode = FocusNode();
  final confirmPswdFocusNode = FocusNode();

  performReset() {
    _snackbarService.showSuccess(
        AppLocalizations.of(Get.context!)!.password_reset_success,
        AppLocalizations.of(Get.context!)!.reset_password);
    Get.offAllNamed(Routes.LOGIN);
  }
}
