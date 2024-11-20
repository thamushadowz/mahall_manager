import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

import '../../../domain/core/interfaces/common_alert.dart';
import '../../../domain/core/interfaces/utility_services.dart';
import '../../../domain/listing/listing_repository.dart';
import '../../../domain/listing/listing_service.dart';
import '../../../domain/listing/models/common_response.dart';
import '../../../domain/listing/models/get_reports_model.dart';
import '../../../infrastructure/dal/services/storage_service.dart';
import '../../../infrastructure/theme/strings/app_strings.dart';

class AddExpensesController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final StorageService storageService = StorageService();
  ListingService listingService = Get.find<ListingRepository>();

  final RxBool isLoading = false.obs;
  final descriptionController = TextEditingController();
  final amountController = TextEditingController();

  final descriptionFocusNode = FocusNode();
  final amountFocusNode = FocusNode();
  ReportsData report = ReportsData();
  String mainHeading = AppStrings.addExpenses;

  @override
  void onInit() {
    if (Get.arguments != null) {
      mainHeading = AppStrings.editExpenses;
      report = Get.arguments;
      descriptionController.text = report.description ?? '';
      amountController.text = report.amount.toString();
    }
    super.onInit();
  }

  addExpense() async {
    isLoading.value = true;
    var isConnectedToInternet = await isInternetAvailable();
    if (isConnectedToInternet) {
      try {
        CommonResponse response = await listingService.addIncomeOrExpense(
            'expense/add', storageService.getToken() ?? '', {
          "date": getCurrentDate(),
          "description": descriptionController.text.trim(),
          "amount": num.parse(amountController.text.trim())
        });
        if (response.status == true) {
          showToast(
              title: response.message.toString(),
              type: ToastificationType.success);
          Get.back();
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

  @override
  void onClose() {
    super.onClose();
    descriptionController.dispose();
    amountController.dispose();
    descriptionFocusNode.dispose();
    amountFocusNode.dispose();
  }
}
