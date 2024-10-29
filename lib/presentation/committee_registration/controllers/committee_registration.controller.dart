import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mahall_manager/domain/core/interfaces/utilities.dart';

class CommitteeRegistrationController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final RxBool isEditMode = false.obs;
  final RxInt adminCode = 1.obs;
  @override
  void onInit() {
    if (adminCode.value == 0) {
      isEditMode.value = true;
    } else {
      isEditMode.value = false;
    }
    super.onInit();
  }

  final mahallNameFocusNode = FocusNode();
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

  performCommitteeRegistration() {
    Utilities.mahallName.value = mahallNameController.text;
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
