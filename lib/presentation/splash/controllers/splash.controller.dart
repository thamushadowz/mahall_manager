import 'package:get/get.dart';
import 'package:mahall_manager/infrastructure/dal/services/storage_service.dart';
import 'package:mahall_manager/infrastructure/navigation/routes.dart';

class SplashController extends GetxController {
  final StorageService _storageService = StorageService();

  checkLogin() {
    if (_storageService.isLoggedIn()) {
      Get.offAllNamed(Routes.HOME);
    } else {
      Get.offAllNamed(Routes.LOGIN);
    }
  }
}
