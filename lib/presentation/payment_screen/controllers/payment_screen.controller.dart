import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mahall_manager/domain/listing/models/get_house_and_users_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class PaymentScreenController extends GetxController {
  PeopleData house = PeopleData();
  bool totalOrNot = false;
  final textController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey screenshotKey = GlobalKey();
  RxBool paymentSuccess = false.obs;
  RxBool isTakingScreenshot = false.obs;
  String referenceNo = 'KNJ0001';
  final args = Get.arguments as Map;

  @override
  void onInit() {
    house = args['house'];
    totalOrNot = args['totalOrNot'];
    textController.text = totalOrNot ? house.totalDue ?? '' : house.due ?? '';
    super.onInit();
  }

  String fetchFormattedDate() {
    DateTime today = DateTime.now();
    String formattedDate = DateFormat('dd/MM/yyyy').format(today);
    return formattedDate;
  }

  Future<void> takeScreenshotAndShare(String phoneNo, String name) async {
    isTakingScreenshot.value = true;
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
              'Dear $name, we received your payment successfully. Thank you!!');
      isTakingScreenshot.value = false;
    } catch (e) {
      print('Error taking screenshot: $e');
      isTakingScreenshot.value = false;
    }
  }
}
