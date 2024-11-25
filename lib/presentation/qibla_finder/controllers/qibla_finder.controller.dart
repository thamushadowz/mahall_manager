import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/animation.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:get/get.dart';
import 'package:mahall_manager/domain/core/interfaces/qibla/qibla_repository.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../domain/core/interfaces/qibla/qibla_usecase.dart';

class QiblaFinderController extends GetxController
    with GetTickerProviderStateMixin {
  final QiblaUseCase useCase = QiblaUseCase(QiblaRepository());

  var isPermissionGranted = false.obs;
  late Stream<QiblahDirection> qiblaStream;

  late final AnimationController? animationController;

  Animation<double>? animation;
  double begin = 0.0;

  @override
  void onInit() {
    super.onInit();
    requestLocationPermission();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    animation = Tween(begin: 0.0, end: 0.0).animate(animationController!);
    qiblaStream = useCase.getQiblaDirection();
  }

  Future<void> requestLocationPermission() async {
    // Check platform-specific permissions
    if (Platform.isAndroid) {
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      var release = androidInfo.version.release;
      var sdkInt = androidInfo.version.sdkInt;
      print('android version ::: $release, $sdkInt');

      if (sdkInt >= 30) {
        // Android 11 (API 30) and above
        await _handleAndroid11AndAbovePermissions();
      } else {
        // Below Android 11
        await _handleAndroid10AndBelowPermissions();
      }
    } else if (Platform.isIOS) {
      // iOS-specific permission handling
      await _handleIOSPermissions();
    }
  }

  Future<void> _handleAndroid11AndAbovePermissions() async {
    // Request fine location permission
    final fineStatus = await Permission.location.request();

    if (fineStatus.isGranted) {
      isPermissionGranted.value = true;
    } else if (fineStatus.isDenied) {
      Get.snackbar(
        'Permission Denied',
        'Precise location permission is required to use the Qibla Finder.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } else if (fineStatus.isPermanentlyDenied) {
      Get.snackbar(
        'Permission Permanently Denied',
        'Please enable location permission in app settings.',
        snackPosition: SnackPosition.BOTTOM,
      );
      await openAppSettings();
    }

    // Optionally request background location for better Qibla accuracy
    if (await Permission.locationAlways.isDenied) {
      final backgroundStatus = await Permission.locationAlways.request();
      if (!backgroundStatus.isGranted) {
        Get.snackbar(
          'Background Permission Denied',
          'Background location is recommended for better accuracy.',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }
  }

  Future<void> _handleAndroid10AndBelowPermissions() async {
    final status = await Permission.locationWhenInUse.request();

    if (status.isGranted) {
      isPermissionGranted.value = true;
    } else if (status.isDenied) {
      Get.snackbar(
        'Permission Denied',
        'Location permission is required to use the Qibla Finder.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } else if (status.isPermanentlyDenied) {
      Get.snackbar(
        'Permission Permanently Denied',
        'Please enable location permission in app settings.',
        snackPosition: SnackPosition.BOTTOM,
      );
      await openAppSettings();
    }
  }

  Future<void> _handleIOSPermissions() async {
    final status = await Permission.locationWhenInUse.request();

    if (status.isGranted) {
      isPermissionGranted.value = true;
    } else if (status.isDenied) {
      Get.snackbar(
        'Permission Denied',
        'Location permission is required to use the Qibla Finder.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } else if (status.isPermanentlyDenied) {
      Get.snackbar(
        'Permission Permanently Denied',
        'Please enable location permission in app settings.',
        snackPosition: SnackPosition.BOTTOM,
      );
      await openAppSettings();
    }
  }

  @override
  void onClose() {
    animationController
        ?.dispose(); // Dispose of the controller to free resources
    super.onClose();
  }
}
