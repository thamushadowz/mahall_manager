import 'dart:async';
import 'dart:ui';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../domain/core/interfaces/utilities.dart';
import '../../../infrastructure/dal/models/home/chart_data_model.dart';
import '../../../infrastructure/theme/strings/app_strings.dart';

class HomeController extends GetxController {
  RxString selectedLanguage = 'English'.obs;
  DateTime? lastPressedAt;

  var income = 0.0.obs;
  var expense = 0.0.obs;

  final double targetIncome = 60.0; // Set your actual income percentage
  final double targetExpense = 40.0; // Set your actual expense percentage
  final double animationSpeed = 1.0; // Adjust speed of animation

  List<ChartDataModel> get chartData => [
        ChartDataModel(category: "Income", amount: income.value),
        ChartDataModel(category: "Expense", amount: expense.value),
      ];

  @override
  void onInit() {
    super.onInit();
    animateChart();
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

  void animateChart() {
    Timer.periodic(const Duration(milliseconds: 20), (timer) {
      if (income.value < targetIncome) {
        income.value += animationSpeed;
      }
      if (expense.value < targetExpense) {
        expense.value += animationSpeed;
      }
      if (income.value >= targetIncome && expense.value >= targetExpense) {
        timer.cancel();
      }
    });
  }
}
