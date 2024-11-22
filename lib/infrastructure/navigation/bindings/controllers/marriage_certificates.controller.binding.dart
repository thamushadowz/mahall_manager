import 'package:get/get.dart';

import '../../../../presentation/marriage_certificates/controllers/marriage_certificates.controller.dart';

class MarriageCertificatesControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MarriageCertificatesController>(
      () => MarriageCertificatesController(),
    );
  }
}
