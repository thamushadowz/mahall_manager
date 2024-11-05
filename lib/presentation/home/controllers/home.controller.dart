import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:mahall_manager/domain/listing/models/get_house_and_users_model.dart';
import 'package:mahall_manager/domain/listing/models/get_reports_model.dart';
import 'package:mahall_manager/infrastructure/dal/services/storage_service.dart';

import '../../../domain/core/interfaces/utilities.dart';
import '../../../infrastructure/dal/models/home/chart_data_model.dart';
import '../../../infrastructure/theme/strings/app_strings.dart';

enum IncomeExpenseType { income, expense }

enum AdminType { president, secretary, treasurer }

class HomeController extends GetxController {
  final StorageService storageService = StorageService();
  final userSearchController = TextEditingController();
  final reportSearchController = TextEditingController();
  RxString selectedLanguage = 'English'.obs;
  DateTime? lastPressedAt;
  RxInt selectedNavIndex = 0.obs;
  RxBool isFiltering = false.obs;
  RxString fromDate = AppStrings.selectFromDate.obs;
  RxString toDate = AppStrings.selectToDate.obs;
  RxBool isIncomeChecked = false.obs;
  RxBool isExpenseChecked = false.obs;
  Rxn<IncomeExpenseType> selectedIncomeExpType = Rxn<IncomeExpenseType>();
  Rxn<AdminType> selectedAdminType = Rxn<AdminType>();
  RxBool isPresidentChecked = false.obs;
  RxBool isSecretaryChecked = false.obs;
  RxBool isTreasurerChecked = false.obs;
  RxBool isReportFilterSubmitted = false.obs;

  var income = 165093.0.obs;
  var expense = 79576.0.obs;

  final double incomePercent = 0.0;
  final double expensePercent = 0.0;
  var selectedSectionIndex = (-1).obs;

  final RxList<bool> isExpandedList = RxList([]);

  var filteredUserDetails = <HouseData>[].obs;
  var filteredReportsDetails = <ReportsData>[].obs;
  var searchQuery = ''.obs;

  List<HouseData> userDetails = [
    HouseData(houseName: 'White House', houseRegNo: 'KNY01', people: [
      People(
          userRegNo: "U01",
          name: 'Abdullah',
          phone: '+919293949596',
          due: '4500'),
      People(
          userRegNo: "U01",
          name: 'Muhammed',
          phone: '+91789012345',
          due: '500'),
      People(
          userRegNo: "U01", name: 'Kasim', phone: '+911213141516', due: '3000'),
      People(
          userRegNo: "U01", name: 'Shafeer', phone: '+916756453426', due: '0'),
      People(userRegNo: "U01", name: 'Azees', phone: '+914598523601', due: '0'),
      People(
          userRegNo: "U01", name: 'Navas', phone: '+918952012576', due: '1600'),
    ]),
    HouseData(houseName: 'Safa Mahal', houseRegNo: 'KNY02', people: [
      People(
          userRegNo: "U01",
          name: 'Abdullah',
          phone: '+919293949596',
          due: '8000'),
      People(
          userRegNo: "U01", name: 'Kasim', phone: '+911213141516', due: '3000'),
      People(
          userRegNo: "U01", name: 'Azees', phone: '+914598523601', due: '2000'),
      People(
          userRegNo: "U01", name: 'Navas', phone: '+918952012576', due: '3600'),
    ]),
    HouseData(houseName: 'Darussalam', houseRegNo: 'KNY03', people: [
      People(
          userRegNo: "U01", name: 'Kasim', phone: '+911213141516', due: '3000'),
      People(
          userRegNo: "U01", name: 'Azees', phone: '+914598523601', due: '2000'),
      People(
          userRegNo: "U01", name: 'Navas', phone: '+918952012576', due: '3600'),
    ]),
    HouseData(houseName: 'Sinan Manzil', houseRegNo: 'KNY04', people: [
      People(
          userRegNo: "U01",
          name: 'Abdullah',
          phone: '+919293949596',
          due: '1000'),
    ]),
    HouseData(houseName: 'Fathimas', houseRegNo: 'KNY05', people: [
      People(
          userRegNo: "U01",
          name: 'Abdullah',
          phone: '+919293949596',
          due: '8000'),
      People(
          userRegNo: "U01", name: 'Navas', phone: '+918952012576', due: '3600'),
    ]),
    HouseData(houseName: 'Puthiyapura', houseRegNo: 'MKY01', people: [
      People(
          userRegNo: "U01",
          name: 'Abdullah',
          phone: '+919293949596',
          due: '8000'),
      People(
          userRegNo: "U01", name: 'Kasim', phone: '+911213141516', due: '3000'),
      People(
          userRegNo: "U01", name: 'Azees', phone: '+914598523601', due: '2000'),
      People(
          userRegNo: "U01", name: 'Navas', phone: '+918952012576', due: '3600'),
    ]),
    HouseData(houseName: 'Cherikkal House', houseRegNo: 'MKY02', people: [
      People(
          userRegNo: "U01",
          name: 'Abdullah',
          phone: '+919293949596',
          due: '8000'),
      People(
          userRegNo: "U01", name: 'Kasim', phone: '+911213141516', due: '3000'),
      People(
          userRegNo: "U01", name: 'Kasim', phone: '+911213141516', due: '2000'),
      People(
          userRegNo: "U01", name: 'Kasim', phone: '+911213141516', due: '6000'),
      People(
          userRegNo: "U01", name: 'Kasim', phone: '+911213141516', due: '7500'),
      People(userRegNo: "U01", name: 'Azees', phone: '+914598523601', due: '0'),
      People(
          userRegNo: "U01", name: 'Navas', phone: '+918952012576', due: '3600'),
    ]),
    HouseData(houseName: 'Safa Mahal', houseRegNo: 'MKY03', people: [
      People(
          userRegNo: "U01",
          name: 'Abdullah',
          phone: '+919293949596',
          due: '8000'),
      People(
          userRegNo: "U01", name: 'Kasim', phone: '+911213141516', due: '3000'),
      People(
          userRegNo: "U01", name: 'Azees', phone: '+914598523601', due: '2000'),
      People(
          userRegNo: "U01", name: 'Navas', phone: '+918952012576', due: '3600'),
    ]),
    HouseData(houseName: 'Nasha Mahal', houseRegNo: 'PRY01', people: [
      People(
          userRegNo: "U01",
          name: 'Abdullah',
          phone: '+919293949596',
          due: '8000'),
      People(
          userRegNo: "U01", name: 'Kasim', phone: '+911213141516', due: '3000'),
      People(
          userRegNo: "U01", name: 'Azees', phone: '+914598523601', due: '5000'),
      People(
          userRegNo: "U01", name: 'Navas', phone: '+918952012576', due: '3600'),
    ]),
    HouseData(houseName: 'Abrar', houseRegNo: 'PRY02', people: [
      People(
          userRegNo: "U01",
          name: 'Abdullah',
          phone: '+919293949596',
          due: '8000'),
      People(
          userRegNo: "U01", name: 'Kasim', phone: '+911213141516', due: '3000'),
      People(
          userRegNo: "U01", name: 'Azees', phone: '+914598523601', due: '2000'),
      People(
          userRegNo: "U01", name: 'Navas', phone: '+918952012576', due: '3600'),
    ]),
    HouseData(houseName: 'Safa Mahal', houseRegNo: 'KLD01', people: [
      People(
          userRegNo: "U01",
          name: 'Abdullah',
          phone: '+919293949596',
          due: '8000'),
      People(
          userRegNo: "U01", name: 'Kasim', phone: '+911213141516', due: '3000'),
      People(
          userRegNo: "U01", name: 'Azees', phone: '+914598523601', due: '2000'),
      People(
          userRegNo: "U01", name: 'Navas', phone: '+918952012576', due: '3600'),
    ]),
    HouseData(houseName: 'Safa Mahal', houseRegNo: 'KLD02', people: [
      People(
          userRegNo: "U01", name: 'Abdullah', phone: '+919293949596', due: '0'),
      People(userRegNo: "U01", name: 'Kasim', phone: '+911213141516', due: '0'),
      People(userRegNo: "U01", name: 'Azees', phone: '+914598523601', due: '0'),
      People(userRegNo: "U01", name: 'Navas', phone: '+918952012576', due: '0'),
    ])
  ];
  List<ReportsData> reportsDetails = [
    ReportsData(
        description: "Honey Auction",
        date: "01/11/2024",
        amount: 3000,
        incomeOrExpense: 0,
        addedBy: "President"),
    ReportsData(
        description: "Banana Auction",
        date: "04/11/2024",
        amount: 1000,
        incomeOrExpense: 0,
        addedBy: "Treasurer"),
    ReportsData(
        description: "Electricity Bill",
        date: "11/11/2024",
        amount: 14500,
        incomeOrExpense: 1,
        addedBy: "Secretary"),
    ReportsData(
        description: "Ustad Salary",
        date: "10/11/2024",
        amount: 21000,
        incomeOrExpense: 1,
        addedBy: "Treasurer"),
    ReportsData(
        description: "Friday Bucket",
        date: "14/11/2024",
        amount: 1500,
        incomeOrExpense: 0,
        addedBy: "President"),
    ReportsData(
        description: "Maulid vaka",
        date: "01/10/2024",
        amount: 245000,
        incomeOrExpense: 0,
        addedBy: "President"),
    ReportsData(
        description: "Moulid nercha food",
        date: "01/10/2024",
        amount: 198000,
        incomeOrExpense: 1,
        addedBy: "President"),
    ReportsData(
        description: "Badreengal aand nercha vaka",
        date: "25/10/2024",
        amount: 150000,
        incomeOrExpense: 0,
        addedBy: "Treasurer"),
    ReportsData(
        description: "Badreengal aand nercha food",
        date: "01/11/2024",
        amount: 97000,
        incomeOrExpense: 1,
        addedBy: "Treasurer"),
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
    filteredUserDetails.assignAll(userDetails);
    filteredReportsDetails.assignAll(reportsDetails);
    userSearchController.addListener(() {
      searchUser(userSearchController.text);
    });
    reportSearchController.addListener(() {
      searchReports(reportSearchController.text);
    });
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

  void applyFilters() {
    String searchText = reportSearchController.text.trim().toLowerCase();

    filteredReportsDetails.value = reportsDetails.where((report) {
      // Date Range Filter
      bool isWithinDateRange = true;
      if (fromDate.value != AppStrings.selectFromDate ||
          toDate.value != AppStrings.selectToDate) {
        DateTime from = DateFormat('dd/MM/yyyy').parse(fromDate.value);
        DateTime to = DateFormat('dd/MM/yyyy').parse(
            toDate.value == AppStrings.selectToDate
                ? fromDate.value
                : toDate.value);
        print('fromDate : $from andd toDate : $to');
        DateTime reportDate = DateFormat('dd/MM/yyyy').parse(report.date ?? '');

        isWithinDateRange =
            (reportDate.isAtSameMomentAs(from) || reportDate.isAfter(from)) &&
                (reportDate.isAtSameMomentAs(to) || reportDate.isBefore(to));
      }

      // Type Filter (Income/Expense)
      bool isTypeMatched =
          (isIncomeChecked.value && report.incomeOrExpense == 0) ||
              (isExpenseChecked.value && report.incomeOrExpense == 1) ||
              (!isIncomeChecked.value && !isExpenseChecked.value);

      // Role Filter (addedBy)
      bool isRoleMatched =
          (isPresidentChecked.value && report.addedBy == 'President') ||
              (isSecretaryChecked.value && report.addedBy == 'Secretary') ||
              (isTreasurerChecked.value && report.addedBy == 'Treasurer') ||
              (!isPresidentChecked.value &&
                  !isSecretaryChecked.value &&
                  !isTreasurerChecked.value);

      // Search Filter
      bool isSearchMatched = searchText.isEmpty ||
          (report.description?.toLowerCase().contains(searchText) ?? false) ||
          (report.addedBy?.toLowerCase().contains(searchText) ?? false) ||
          (report.amount.toString().contains(searchText));

      return isWithinDateRange &&
          isTypeMatched &&
          isRoleMatched &&
          isSearchMatched;
    }).toList();
  }

  clearFilters() {
    filteredReportsDetails.assignAll(reportsDetails);
    isReportFilterSubmitted.value = false;
    fromDate.value = AppStrings.selectFromDate;
    toDate.value = AppStrings.selectToDate;
    isIncomeChecked.value = false;
    isExpenseChecked.value = false;
    isPresidentChecked.value = false;
    isSecretaryChecked.value = false;
    isTreasurerChecked.value = false;
  }

  bool checkFilters() {
    bool isDateSelected = fromDate.value != AppStrings.selectFromDate ||
        toDate.value != AppStrings.selectToDate;

    bool isCheckboxChecked = isIncomeChecked.value ||
        isExpenseChecked.value ||
        isPresidentChecked.value ||
        isSecretaryChecked.value ||
        isTreasurerChecked.value;

    return isDateSelected || isCheckboxChecked;
  }

  void toggleIncomeCheckbox() {
    isIncomeChecked.value = !isIncomeChecked.value;
    if (isIncomeChecked.value) {
      isExpenseChecked.value = false;
    } else {
      selectedIncomeExpType.value = null;
    }
    selectedIncomeExpType.value =
        isIncomeChecked.value ? IncomeExpenseType.income : null;
  }

  void toggleExpenseCheckbox() {
    isExpenseChecked.value = !isExpenseChecked.value;
    if (isExpenseChecked.value) {
      isIncomeChecked.value = false;
    } else {
      selectedIncomeExpType.value = null;
    }
    selectedIncomeExpType.value =
        isExpenseChecked.value ? IncomeExpenseType.expense : null;
  }

  void togglePresidentCheckbox() {
    isPresidentChecked.value = !isPresidentChecked.value;
    if (isPresidentChecked.value) {
    } else {
      selectedAdminType.value = null;
    }
    selectedAdminType.value =
        isPresidentChecked.value ? AdminType.president : null;
  }

  void toggleSecretaryCheckbox() {
    isSecretaryChecked.value = !isSecretaryChecked.value;
    if (isSecretaryChecked.value) {
    } else {
      selectedAdminType.value = null;
    }
    selectedAdminType.value =
        isSecretaryChecked.value ? AdminType.secretary : null;
  }

  void toggleTreasurerCheckbox() {
    isTreasurerChecked.value = !isTreasurerChecked.value;
    if (isTreasurerChecked.value) {
    } else {
      selectedAdminType.value = null;
    }
    selectedAdminType.value =
        isTreasurerChecked.value ? AdminType.treasurer : null;
  }

  searchUser(String query) {
    searchQuery.value = query.toLowerCase();
    if (searchQuery.isEmpty) {
      filteredUserDetails.value = userDetails;
    } else {
      filteredUserDetails.value = userDetails.where((house) {
        return house.houseName!
                .toLowerCase()
                .contains(searchQuery.value.toLowerCase()) ||
            house.people!.any((person) => person.name!
                .toLowerCase()
                .contains(searchQuery.value.toLowerCase()));
      }).toList();
    }
  }

  searchReports(String query) {
    searchQuery.value = query.toLowerCase();
    if (searchQuery.isEmpty) {
      filteredReportsDetails.value = reportsDetails;
    } else {
      filteredReportsDetails.value = reportsDetails.where((reports) {
        return reports.description!
                .toLowerCase()
                .contains(searchQuery.value.toLowerCase()) ||
            reports.addedBy!
                .toLowerCase()
                .contains(searchQuery.value.toLowerCase());
      }).toList();
    }
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

  int calculateTotalDue(List<People> people) {
    return people.fold(0, (sum, person) {
      int due = int.tryParse(person.due ?? '0') ?? 0;
      return sum + due;
    });
  }
}
