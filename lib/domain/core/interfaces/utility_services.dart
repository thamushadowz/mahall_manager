import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:toastification/toastification.dart';

import '../../../infrastructure/theme/colors/app_colors.dart';
import '../../../infrastructure/theme/measures/app_measures.dart';
import '../../../presentation/common_widgets/common_text_widget.dart';

void showToast(
    {String? message,
    required String title,
    required ToastificationType type}) {
  Toastification().show(
      title: CommonTextWidget(
        text: title,
        fontSize: AppMeasures.mediumTextSize,
        color: AppColors.white,
      ),
      style: ToastificationStyle.fillColored,
      icon: Icon(type == ToastificationType.success
          ? Icons.check_circle_outline
          : Icons.error_outline),
      type: type,
      autoCloseDuration: const Duration(seconds: 4),
      showProgressBar: false);
}

String getCurrentDate() {
  final DateTime now = DateTime.now();
  String formattedDate = DateFormat('dd/MM/yyyy').format(now);
  return formattedDate;
}

Future<String?> downloadPdfToExternal(String url, String fileName) async {
  try {
    // Request storage permissions
    await requestStoragePermission();
    print("permission status : ${await requestStoragePermission()}");

    // Get external directory (Downloads)
    final directory = Directory('/storage/emulated/0/Download');

    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }

    final filePath = '${directory.path}/$fileName';

    // Download the file
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);
      print("File saved to $filePath");
      showToast(
          title: '$fileName saved to $filePath',
          type: ToastificationType.success);
      return filePath;
    } else {
      print("Failed to download PDF. Status code: ${response.statusCode}");
      showToast(
          title: 'Failed to download PDF', type: ToastificationType.error);
      return null;
    }
  } catch (e) {
    print("Error: $e");
    return null;
  }
}

Future<bool> requestStoragePermission() async {
  // Check for Android version (Android 11 and above)
  if (Platform.isAndroid) {
    if (Platform.version.contains("10") || Platform.version.contains("11")) {
      // Check for Android 10 and above
      if (await Permission.manageExternalStorage.isGranted) {
        return true; // Permission is already granted
      }

      // Request broad storage access (Android 10 and above)
      final status = await Permission.manageExternalStorage.request();
      if (status.isGranted) {
        return true;
      } else {
        // If permission is permanently denied, open app settings
        if (status.isPermanentlyDenied) {
          openAppSettings();
        }
        return false;
      }
    } else {
      // For Android versions below 10 (Android 9 and below), request READ/WRITE permissions
      if (await Permission.storage.isGranted) {
        return true; // Permission is already granted
      }

      final status = await Permission.storage.request();
      if (status.isGranted) {
        return true;
      } else {
        // If permission is permanently denied, open app settings
        if (status.isPermanentlyDenied) {
          openAppSettings();
        }
        return false;
      }
    }
  }
  return false; // Not an Android device
}
