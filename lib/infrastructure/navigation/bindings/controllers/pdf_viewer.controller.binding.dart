import 'package:get/get.dart';

import '../../../../presentation/pdf_viewer/controllers/pdf_viewer.controller.dart';

class PdfViewerControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PdfViewerController>(
      () => PdfViewerController(),
    );
  }
}
