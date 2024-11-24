import 'package:get/get.dart';
import 'package:internet_file/internet_file.dart';
import 'package:pdfx/pdfx.dart';

class PdfViewerController extends GetxController {
  late PdfController pdfController;
  String filePath = '';
  var isLoading = true.obs;

  @override
  void onInit() {
    if (Get.arguments != null) {
      filePath = Get.arguments;
    }
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
