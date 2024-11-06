import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class RegistrationController extends GetxController {
  RxBool isExpat = false.obs;
  RxBool isWillingToDonate = false.obs;
  RxBool isRegistrationSuccess = false.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final RxBool isLoading = false.obs;
  final regNoFocusNode = FocusNode();
  final fNameFocusNode = FocusNode();
  final lNameFocusNode = FocusNode();
  final houseNameFocusNode = FocusNode();
  final placeFocusNode = FocusNode();
  final districtFocusNode = FocusNode();
  final stateFocusNode = FocusNode();
  final mobileNoFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final genderFocusNode = FocusNode();
  final dobFocusNode = FocusNode();
  final ageFocusNode = FocusNode();
  final jobFocusNode = FocusNode();
  final incomeFocusNode = FocusNode();
  final bloodFocusNode = FocusNode();
  final pendingAmountFocusNode = FocusNode();
  final countryFocusNode = FocusNode();

  final regNoController = TextEditingController();
  final fNameController = TextEditingController();
  final lNameController = TextEditingController();
  final houseNameController = TextEditingController();
  final placeController = TextEditingController();
  final districtController = TextEditingController();
  final stateController = TextEditingController();
  final mobileNoController = TextEditingController();
  final passwordController = TextEditingController();
  final genderController = TextEditingController();
  final dobController = TextEditingController();
  final ageController = TextEditingController();
  final jobController = TextEditingController();
  final incomeController = TextEditingController();
  final bloodController = TextEditingController();
  final pendingAmountController = TextEditingController();
  final countryController = TextEditingController();

  int calculateAge(DateTime birthDate) {
    DateTime today = DateTime.now();
    int age = today.year - birthDate.year;
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  performRegistration() {
    isRegistrationSuccess.value = !isRegistrationSuccess.value;
  }

  @override
  void onClose() {
    disposeAll();
    super.onClose();
  }

  void resetForm() {
    regNoController.clear();
    fNameController.clear();
    lNameController.clear();
    houseNameController.clear();
    placeController.clear();
    districtController.clear();
    stateController.clear();
    mobileNoController.clear();
    passwordController.clear();
    genderController.clear();
    dobController.clear();
    ageController.clear();
    jobController.clear();
    incomeController.clear();
    bloodController.clear();
    pendingAmountController.clear();
    countryController.clear();
  }

  void disposeAll() {
    regNoController.dispose();
    fNameController.dispose();
    lNameController.dispose();
    houseNameController.dispose();
    placeController.dispose();
    districtController.dispose();
    stateController.dispose();
    mobileNoController.dispose();
    passwordController.dispose();
    genderController.dispose();
    dobController.dispose();
    ageController.dispose();
    jobController.dispose();
    incomeController.dispose();
    bloodController.dispose();
    pendingAmountController.dispose();
    countryController.dispose();

    regNoFocusNode.dispose();
    fNameFocusNode.dispose();
    lNameFocusNode.dispose();
    houseNameFocusNode.dispose();
    placeFocusNode.dispose();
    districtFocusNode.dispose();
    stateFocusNode.dispose();
    mobileNoFocusNode.dispose();
    passwordFocusNode.dispose();
    genderFocusNode.dispose();
    dobFocusNode.dispose();
    ageFocusNode.dispose();
    jobFocusNode.dispose();
    incomeFocusNode.dispose();
    bloodFocusNode.dispose();
    pendingAmountFocusNode.dispose();
    countryFocusNode.dispose();
  }
}
