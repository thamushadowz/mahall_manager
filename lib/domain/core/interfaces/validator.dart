import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import '../../../infrastructure/theme/strings/app_strings.dart';

class Validators {
  static String? validateMobileNumber(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(Get.context!)!.mobile_reqd;
    }
    if (value.length != 10 || !RegExp(r'^[0-9]+$').hasMatch(value)) {
      return AppLocalizations.of(Get.context!)!.enter_valid_mobile_no;
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(Get.context!)!.password_reqd;
    }
    if (value.length < 8) {
      return AppLocalizations.of(Get.context!)!.password_must_long;
    }
    return null;
  }

  static String? validateNewPassword(String? value, String? oldPassword) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(Get.context!)!.password_reqd;
    }
    if (value.length < 8) {
      return AppLocalizations.of(Get.context!)!.password_must_long;
    }
    if (value == oldPassword) {
      return AppLocalizations.of(Get.context!)!.password_must_different;
    }
    return null;
  }

  static String? validateConfirmPassword(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(Get.context!)!.password_reqd;
    }
    if (value != password) {
      return AppLocalizations.of(Get.context!)!.password_mismatch;
    }
    return null;
  }

  static String? validateRegNo(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(Get.context!)!.reg_no_reqd;
    }
    return null;
  }

  static String? validateFName(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(Get.context!)!.fname_reqd;
    }
    return null;
  }

  static String? validateLName(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(Get.context!)!.lname_reqd;
    }
    return null;
  }

  static String? validateHouseName(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(Get.context!)!.house_name_reqd;
    }
    return null;
  }

  static String? validatePlaceName(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(Get.context!)!.place_reqd;
    }
    return null;
  }

  static String? validateGender(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(Get.context!)!.gender_reqd;
    }
    return null;
  }

  static String? validateAge(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(Get.context!)!.age_reqd;
    }
    if (int.parse(value) < 1 || int.parse(value) > 130) {
      return AppLocalizations.of(Get.context!)!.age_invalid;
    }
    return null;
  }

  static String? validateJob(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(Get.context!)!.job_reqd;
    }
    return null;
  }

  static String? validateIncome(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(Get.context!)!.income_reqd;
    }
    return null;
  }

  static String? validateBlood(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(Get.context!)!.blood_reqd;
    }
    return null;
  }

  static String? validateDistrict(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(Get.context!)!.district_reqd;
    }
    return null;
  }

  static String? validateState(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(Get.context!)!.state_reqd;
    }
    return null;
  }

  static String? validateCountry(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(Get.context!)!.country_reqd;
    }
    return null;
  }

  static String? validateHouseholderName(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(Get.context!)!.house_holder_name_reqd;
    }
    return null;
  }

  static String? validateMahallName(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(Get.context!)!.mahall_name_reqd;
    }
    return null;
  }

  static String? validateMahallAddress(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(Get.context!)!.mahall_address_reqd;
    }
    return null;
  }

  static String? validateMahallPin(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(Get.context!)!.pin_code_reqd;
    }
    return null;
  }

  ///Localization needed for texts

  static String? validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.dateReqd;
    }
    return null;
  }

  static String? validateDescription(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.descriptionReqd;
    }
    return null;
  }

  static String? validateAmount(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.amountReqd;
    }
    return null;
  }
}
