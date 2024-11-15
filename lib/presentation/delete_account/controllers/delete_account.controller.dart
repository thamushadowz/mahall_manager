import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class DeleteAccountController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  RxBool showPassword = false.obs;
  RxBool isLoading = false.obs;

  final mobileController = TextEditingController();
  final passwordController = TextEditingController();

  final mobileFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
}
