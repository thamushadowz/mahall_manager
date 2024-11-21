import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mahall_manager/domain/listing/models/get_house_and_users_model.dart';
import 'package:mahall_manager/domain/listing/models/get_promises_model.dart';
import 'package:mahall_manager/domain/listing/models/get_reports_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:toastification/toastification.dart';

import '../../../domain/core/interfaces/common_alert.dart';
import '../../../domain/core/interfaces/utility_services.dart';
import '../../../domain/listing/listing_repository.dart';
import '../../../domain/listing/listing_service.dart';
import '../../../domain/listing/models/payment_success_model.dart';
import '../../../infrastructure/dal/services/storage_service.dart';
import '../../../infrastructure/theme/strings/app_strings.dart';

class PaymentScreenController extends GetxController {
  final StorageService storageService = StorageService();
  ListingService listingService = Get.find<ListingRepository>();

  PeopleData house = PeopleData();
  PromisesData promises = PromisesData();
  ReportsData report = ReportsData();
  bool totalOrNot = false;
  final textController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey screenshotKey = GlobalKey();
  RxBool paymentSuccess = false.obs;
  RxBool isTakingScreenshot = false.obs;
  String referenceNo = 'KNJ0001';
  String currentDue = '';
  final args = Get.arguments as Map;
  RxBool isLoading = false.obs;
  int paymentFor = 0;

  @override
  void onInit() {
    if (args['house'] != null && args['totalOrNot'] != null) {
      house = args['house'];
      totalOrNot = args['totalOrNot'];
      paymentFor = totalOrNot ? 1 : 0; // 0 - user money, 1- house total
      textController.text = totalOrNot ? house.totalDue ?? '' : house.due ?? '';
    } else if (args['promises'] != null) {
      promises = args['promises'];
      paymentFor = 2; // 2 - promised money
    } else if (args['report'] != null) {
      paymentSuccess.value = true;
      report = args['report'];
      currentDue = report.currentDue.toString();
    }

    super.onInit();
  }

  collectPayment(dynamic params) async {
    isLoading.value = true;
    var isConnectedToInternet = await isInternetAvailable();
    if (isConnectedToInternet) {
      try {
        PaymentSuccessModel response = await listingService.payment(
            storageService.getToken() ?? '', params);
        if (response.status == true) {
          referenceNo = response.data!.referenceNo ?? '';
          currentDue = response.data!.currentDue.toString();
          paymentSuccess.value = true;
        } else {
          showToast(
              title: response.message.toString(),
              type: ToastificationType.error);
        }
      } catch (e) {
        showToast(
            title: AppStrings.somethingWentWrong,
            type: ToastificationType.error);
      } finally {
        isLoading.value = false;
      }
    } else {
      showToast(
          title: AppStrings.noInternetConnection,
          type: ToastificationType.error);
      isLoading.value = false;
    }
  }

  Future<void> takeScreenshotAndShare(String phoneNo, String name) async {
    isTakingScreenshot.value = true;
    await Future.delayed(const Duration(milliseconds: 200));
    try {
      RenderRepaintBoundary boundary = screenshotKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      final directory = (await getTemporaryDirectory()).path;
      String filePath = '$directory/screenshot.png';
      File imgFile = File(filePath);
      await imgFile.writeAsBytes(pngBytes);

      XFile xFile = XFile(filePath);

      await Share.shareXFiles([xFile],
          text:
              'Dear *$name*, we received your payment successfully. Thank you!!\n*-${storageService.getMahallName()}*');
      isTakingScreenshot.value = false;
    } catch (e) {
      print('Error taking screenshot: $e');
      isTakingScreenshot.value = false;
    }
  }
}
