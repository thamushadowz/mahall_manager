import 'dart:ui';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mahall_manager/domain/listing/models/get_house_and_users_model.dart';
import 'package:mahall_manager/infrastructure/dal/services/storage_service.dart';

import '../../../domain/core/interfaces/utilities.dart';
import '../../../infrastructure/dal/models/home/chart_data_model.dart';
import '../../../infrastructure/theme/strings/app_strings.dart';

class HomeController extends GetxController {
  final StorageService storageService = StorageService();
  RxString selectedLanguage = 'English'.obs;
  DateTime? lastPressedAt;
  RxInt selectedNavIndex = 0.obs;

  var income = 165093.0.obs;
  var expense = 79576.0.obs;

  final double incomePercent = 0.0;
  final double expensePercent = 0.0;
  var selectedSectionIndex = (-1).obs;

  final RxList<bool> isExpandedList = RxList([]);

  List<HouseData> userDetails = [
    HouseData(houseName: 'White House', houseRegNo: 'KNY01', people: [
      People(name: 'Abdullah', phone: '+919293949596', due: '4500'),
      People(name: 'Muhammed', phone: '+91789012345', due: '500'),
      People(name: 'Kasim', phone: '+911213141516', due: '3000'),
      People(name: 'Shafeer', phone: '+916756453426', due: '0'),
      People(name: 'Azees', phone: '+914598523601', due: '0'),
      People(name: 'Navas', phone: '+918952012576', due: '1600'),
    ]),
    HouseData(houseName: 'Safa Mahal', houseRegNo: 'KNY02', people: [
      People(name: 'Abdullah', phone: '+919293949596', due: '8000'),
      People(name: 'Kasim', phone: '+911213141516', due: '3000'),
      People(name: 'Azees', phone: '+914598523601', due: '2000'),
      People(name: 'Navas', phone: '+918952012576', due: '3600'),
    ])
  ];
  /*var userDetails = [
    [
      {"name": "Person 1", "phone": "1234567890", "due": "₹1000"},
      {"name": "Person 2", "phone": "1234567891", "due": "₹2000"},
    ],
    [
      {"name": "Person A", "phone": "9876543210", "due": "₹500"},
    ],
  ];*/

  List<ChartDataModel> get chartData => [
        ChartDataModel(category: "Income", amount: income.value),
        ChartDataModel(category: "Expense", amount: expense.value),
      ];

  @override
  void onInit() {
    super.onInit();
    if (isExpandedList.isEmpty) {
      isExpandedList.value = RxList.filled(userDetails.length, false);
    }
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

  void toggleExpansion(int index) {
    isExpandedList[index] = !isExpandedList[index];
  }
}
