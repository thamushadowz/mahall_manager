import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HouseRegistrationController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxBool isHouseRegistrationSuccess = false.obs;

  final regNoFocusNode = FocusNode();
  final houseNameFocusNode = FocusNode();
  final houseHolderNameFocusNode = FocusNode();

  final regNoController = TextEditingController();
  final houseNameController = TextEditingController();
  final houseHolderNameController = TextEditingController();

  performHouseRegistration() {
    isHouseRegistrationSuccess.value = !isHouseRegistrationSuccess.value;
  }

  @override
  void onClose() {
    disposeAll();
    super.onClose();
  }

  disposeAll() {
    regNoFocusNode.dispose();
    houseNameFocusNode.dispose();
    houseHolderNameFocusNode.dispose();
    regNoController.dispose();
    houseNameController.dispose();
    houseHolderNameController.dispose();
  }

  resetForm() {
    regNoController.clear();
    houseNameController.clear();
    houseHolderNameController.clear();
  }
}
