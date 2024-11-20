import 'package:get/get.dart';
import 'package:toastification/toastification.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../domain/core/interfaces/common_alert.dart';
import '../../../domain/core/interfaces/utility_services.dart';
import '../../../domain/listing/listing_repository.dart';
import '../../../domain/listing/listing_service.dart';
import '../../../domain/listing/models/mahall_registration_or_details_model.dart';
import '../../../infrastructure/dal/services/storage_service.dart';
import '../../../infrastructure/theme/strings/app_strings.dart';

class ContactUsController extends GetxController {
  ListingService listingService = Get.find<ListingRepository>();
  final StorageService _storageService = StorageService();

  RxBool isLoading = false.obs;
  RxString presidentName = ''.obs;
  RxString presidentMobileNo = ''.obs;

  RxString secretaryName = ''.obs;
  RxString secretaryMobileNo = ''.obs;

  RxString treasurerName = ''.obs;
  RxString treasurerMobileNo = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getMahallDetails();
  }

  Future<void> launchDialer(String number) async {
    final Uri url = Uri(scheme: 'tel', path: number);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  launchWhatsApp(String phoneNumber) async {
    final Uri whatsappUri = Uri.parse("whatsapp://send?phone=$phoneNumber");
    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri);
    } else {}
  }

  getMahallDetails() async {
    isLoading.value = true;
    var isConnectedToInternet = await isInternetAvailable();
    if (isConnectedToInternet) {
      try {
        MahallRegistrationOrDetailsModel response = await listingService
            .getMahallDetails(_storageService.getToken() ?? '');
        print('token is : ${_storageService.getToken()}');
        if (response.status == true) {
          showDetails(response.admins!);
        } else {
          if (response.message != null) {
            showToast(
                title: response.message.toString(),
                type: ToastificationType.error);
          } else {
            showToast(
                title: AppStrings.somethingWentWrong,
                type: ToastificationType.error);
          }
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

  showDetails(List<GetAdmins> admins) {
    presidentName.value = 'Mr. ${admins[0].firstName} ${admins[0].lastName}';
    presidentMobileNo.value = '+91 ${admins[0].phone}';

    secretaryName.value = 'Mr. ${admins[1].firstName} ${admins[1].lastName}';
    secretaryMobileNo.value = '+91 ${admins[1].phone}';

    treasurerName.value = 'Mr. ${admins[2].firstName} ${admins[2].lastName}';
    treasurerMobileNo.value = '+91 ${admins[2].phone}';
  }
}
