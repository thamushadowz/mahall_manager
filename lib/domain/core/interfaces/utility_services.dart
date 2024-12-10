import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:toastification/toastification.dart';

import '../../../infrastructure/theme/colors/app_colors.dart';
import '../../../infrastructure/theme/measures/app_measures.dart';
import '../../../infrastructure/theme/strings/app_strings.dart';
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

String formatDateTimeToDateAndTime(String dateTimeString) {
  DateTime dateTime = DateTime.parse(dateTimeString);

  String formattedDate =
      "${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year}";

  int hour = dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour;
  hour = hour == 0 ? 12 : hour;
  String formattedTime =
      "${hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')} ${dateTime.hour >= 12 ? 'PM' : 'AM'}";

  return "$formattedDate $formattedTime";
}

Future<String?> downloadPdfToExternal(String url, String fileName) async {
  try {
    await requestStoragePermission();
    print("permission status : ${await requestStoragePermission()}");

    final directory = Directory('/storage/emulated/0/Download');

    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }

    // Handle duplicate file names
    String uniqueFileName = fileName;
    int fileIndex = 1;
    while (File('${directory.path}/$uniqueFileName').existsSync()) {
      final extension = fileName.split('.').last;
      final baseName = fileName.substring(0, fileName.lastIndexOf('.'));
      uniqueFileName = '$baseName($fileIndex).$extension';
      fileIndex++;
    }
    final filePath = '${directory.path}/$uniqueFileName';

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
  if (Platform.isAndroid) {
    var androidInfo = await DeviceInfoPlugin().androidInfo;
    var release = androidInfo.version.release;
    var sdkInt = androidInfo.version.sdkInt;
    print('android version ::: $release, $sdkInt');
    if (release == "10" || release == "11") {
      if (await Permission.manageExternalStorage.isGranted) {
        return true;
      }

      final status = await Permission.manageExternalStorage.request();
      if (status.isGranted) {
        return true;
      } else {
        if (status.isPermanentlyDenied) {
          openAppSettings();
        }
        return false;
      }
    } else {
      if (await Permission.storage.isGranted) {
        return true;
      }

      final status = await Permission.storage.request();
      if (status.isGranted) {
        return true;
      } else {
        if (status.isPermanentlyDenied) {
          openAppSettings();
        }
        return false;
      }
    }
  }
  return false;
}

Future<bool> requestLocationPermission() async {
  if (Platform.isAndroid) {
    var androidInfo = await DeviceInfoPlugin().androidInfo;
    var release = androidInfo.version.release;
    var sdkInt = androidInfo.version.sdkInt;
    print('android version ::: $release, $sdkInt');

    if (sdkInt >= 30) {
      return await _handleAndroid11AndAbovePermissions();
    } else {
      return await _handleAndroid10AndBelowPermissions();
    }
  } else if (Platform.isIOS) {
    return await _handleIOSPermissions();
  } else {
    return false;
  }
}

Future<bool> _handleAndroid11AndAbovePermissions() async {
  final fineStatus = await Permission.location.request();

  if (fineStatus.isGranted) {
    return true;
  } else if (fineStatus.isDenied) {
    showToast(
        title: AppStrings.locationPermissionReqd,
        type: ToastificationType.error);
    return false;
  } else if (fineStatus.isPermanentlyDenied) {
    showToast(
        title: AppStrings.enableLocationPermission,
        type: ToastificationType.error);
    await openAppSettings();
    return false;
  } else {
    return false;
  }

  /*// Optionally request background location for better Qibla accuracy
  if (await Permission.locationAlways.isDenied) {
    final backgroundStatus = await Permission.locationAlways.request();
    if (!backgroundStatus.isGranted) {
      Get.snackbar(
        'Background Permission Denied',
        'Background location is recommended for better accuracy.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }*/
}

Future<bool> _handleAndroid10AndBelowPermissions() async {
  final status = await Permission.locationWhenInUse.request();

  if (status.isGranted) {
    return true;
  } else if (status.isDenied) {
    showToast(
        title: AppStrings.locationPermissionReqd,
        type: ToastificationType.error);
    return false;
  } else if (status.isPermanentlyDenied) {
    showToast(
        title: AppStrings.enableLocationPermission,
        type: ToastificationType.error);
    await openAppSettings();
    return false;
  } else {
    return false;
  }
}

Future<bool> _handleIOSPermissions() async {
  final status = await Permission.locationWhenInUse.request();

  if (status.isGranted) {
    return true;
  } else if (status.isDenied) {
    showToast(
        title: AppStrings.locationPermissionReqd,
        type: ToastificationType.error);
    return false;
  } else if (status.isPermanentlyDenied) {
    showToast(
        title: AppStrings.enableLocationPermission,
        type: ToastificationType.error);
    await openAppSettings();
    return false;
  } else {
    return false;
  }
}

Future<bool> isInternetAvailable() async {
  var connectivityResult = await Connectivity().checkConnectivity();
  print('Connectivity ::: ${connectivityResult}');
  if (connectivityResult.first == ConnectivityResult.mobile ||
      connectivityResult.first == ConnectivityResult.wifi) {
    return true;
  } else {
    return false;
  }
}
