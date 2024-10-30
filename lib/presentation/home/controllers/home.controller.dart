import 'dart:ui';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../domain/core/interfaces/utilities.dart';
import '../../../infrastructure/dal/models/home/chart_data_model.dart';
import '../../../infrastructure/theme/strings/app_strings.dart';

class HomeController extends GetxController {
  RxString selectedLanguage = 'English'.obs;
  DateTime? lastPressedAt;
  RxInt selectedNavIndex = 0.obs;

  var income = 165093.0.obs;
  var expense = 79576.0.obs;

  final double incomePercent = 0.0;
  final double expensePercent = 0.0;
  var selectedSectionIndex = (-1).obs;

  List<ChartDataModel> get chartData => [
        ChartDataModel(category: "Income", amount: income.value),
        ChartDataModel(category: "Expense", amount: expense.value),
      ];

  @override
  void onInit() {
    super.onInit();
    final storage = GetStorage();
    String lang = storage.read(AppStrings.preferredLanguage) ?? 'en';

    try {
      selectedLanguage.value = Utilities.languages
          .firstWhere((element) => element['code'] == lang)['name']!;
    } catch (e) {
      selectedLanguage.value = 'English';
      storage.write(AppStrings.preferredLanguage, 'en');
    }

    Get.updateLocale(Locale(lang));
  }

  void changeLanguage(String lang) {
    String langCode = Utilities.languages
        .firstWhere((element) => element['name'] == lang)['code']!;

    final storage = GetStorage();
    storage.write(AppStrings.preferredLanguage, langCode);
    Get.updateLocale(Locale(langCode));
  }
}
