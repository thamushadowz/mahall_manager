import 'package:get/get.dart';
import 'package:internet_file/internet_file.dart';
import 'package:pdfx/pdfx.dart';

import '../../../infrastructure/theme/strings/app_strings.dart';

class PdfViewerController extends GetxController {
  late PdfController pdfController;
  String filePath = '';
  String fileName = '';
  var isLoading = true.obs;
  final args = Get.arguments as Map;

  @override
  void onInit() {
    filePath = args[AppStrings.pdfUrl];
    fileName = '${args[AppStrings.pdfName]}.pdf';
    print('File Name : $fileName\nFile Path : $filePath');
    /*filePath =
        'https://github.com/ScerIO/packages.flutter/raw/fd0c92ac83ee355255acb306251b1adfeb2f2fd6/packages/native_pdf_renderer/example/assets/sample.pdf';*/
    InternetFile.get(filePath).then((data) {
      pdfController = PdfController(
        document: PdfDocument.openData(data),
      );
      isLoading(false);
    }).catchError((error) {
      isLoading(false);
    });
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    pdfController.dispose();
  }
}
