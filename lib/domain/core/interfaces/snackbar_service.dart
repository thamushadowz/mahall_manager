import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackbarService {
  void showSuccess(String message, String title) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      icon: const Icon(
        Icons.check_circle_outlined,
        size: 40,
      ),
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
    );
  }

  void showError(String message, String title) {
    Get.snackbar(
      title,
      message,
      icon: const Icon(
        Icons.cancel_outlined,
        size: 40,
      ),
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
    );
  }
}
