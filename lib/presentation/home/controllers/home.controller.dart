import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:mahall_manager/domain/listing/models/common_response.dart';
import 'package:mahall_manager/domain/listing/models/get_house_and_users_model.dart';
import 'package:mahall_manager/domain/listing/models/get_promises_model.dart';
import 'package:mahall_manager/domain/listing/models/get_reports_model.dart';
import 'package:mahall_manager/infrastructure/dal/services/storage_service.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:toastification/toastification.dart';

import '../../../domain/core/interfaces/common_alert.dart';
import '../../../domain/core/interfaces/utilities.dart';
import '../../../domain/core/interfaces/utility_services.dart';
import '../../../domain/listing/listing_repository.dart';
import '../../../domain/listing/listing_service.dart';
import '../../../domain/listing/models/get_blood_model.dart';
import '../../../domain/listing/models/get_expat_model.dart';
import '../../../infrastructure/dal/models/home/chart_data_model.dart';
import '../../../infrastructure/navigation/routes.dart';
import '../../../infrastructure/theme/colors/app_colors.dart';
import '../../../infrastructure/theme/strings/app_strings.dart';

enum IncomeExpenseType { income, expense }

enum AdminType { president, secretary, treasurer }

enum GenderType { male, female }

enum BloodType { apos, aneg, bpos, bneg, abpos, abneg, opos, oneg }

class HomeController extends GetxController {
  RxString appBarTitle = AppStrings.dashboard.obs;
  final StorageService storageService = StorageService();
  String userType = '';
  String mahallName = '';
  final userSearchController = TextEditingController();
  final promisesSearchController = TextEditingController();
  final reportSearchController = TextEditingController();
  final bloodSearchController = TextEditingController();
  final expatSearchController = TextEditingController();

  ListingService listingService = Get.find<ListingRepository>();

  RxString selectedLanguage = 'English'.obs;
  DateTime? lastPressedAt;
  RxInt selectedNavIndex = 0.obs;
  RxInt licenseExpiry = 0.obs;
  RxString fromDate = AppStrings.selectFromDate.obs;
  RxString toDate = AppStrings.selectToDate.obs;

  RxBool isReportFiltering = false.obs;
  RxBool isBloodFiltering = false.obs;
  RxBool isReportFilterSubmitted = false.obs;
  RxBool isBloodFilterSubmitted = false.obs;
  RxBool isExpatFilterSubmitted = false.obs;
  RxBool isIncomeChecked = false.obs;
  RxBool isExpenseChecked = false.obs;
  RxBool isPresidentChecked = false.obs;
  RxBool isSecretaryChecked = false.obs;
  RxBool isTreasurerChecked = false.obs;
  RxBool isMaleChecked = false.obs;
  RxBool isFemaleChecked = false.obs;
  RxBool isAposChecked = false.obs;
  RxBool isAnegChecked = false.obs;
  RxBool isBposChecked = false.obs;
  RxBool isBnegChecked = false.obs;
  RxBool isABposChecked = false.obs;
  RxBool isABnegChecked = false.obs;
  RxBool isOposChecked = false.obs;
  RxBool isOnegChecked = false.obs;
  RxBool isLoading = false.obs;
  RxBool isLoggingOut = false.obs;

  Rxn<IncomeExpenseType> selectedIncomeExpType = Rxn<IncomeExpenseType>();
  Rxn<AdminType> selectedAdminType = Rxn<AdminType>();
  Rxn<GenderType> selectedGenderType = Rxn<GenderType>();
  Rxn<BloodType> selectedBloodType = Rxn<BloodType>();

  var income = 165093.0.obs;
  var expense = 79576.0.obs;
  RxDouble reportTotal = 0.0.obs;
  RxDouble promisesTotal = 0.0.obs;

  final double incomePercent = 0.0;
  final double expensePercent = 0.0;
  var selectedSectionIndex = (-1).obs;
  final String lastAppVersion = '1.0.0';

  final RxList<bool> isExpandedList = RxList([]);

  var filteredUserDetails = <PeopleData>[].obs;
  var filteredPromisesDetails = <PromisesData>[].obs;
  var filteredReportsDetails = <ReportsData>[].obs;
  var filteredBloodDetails = <BloodData>[].obs;
  var filteredExpatDetails = <ExpatData>[].obs;
  RxString searchQuery = ''.obs;
  RxString versionCode = ''.obs;

  List<String> bottomNavTitles = [];
  List<Widget> bottomNavIcons = [];

  List<PeopleData> userDetails = [];
  List<PromisesData> promisesDetails = [];
  List<ReportsData> reportsDetails = [];
  List<BloodData> bloodDetails = [];
  List<ExpatData> expatDetails = [];

  /*List<PeopleData> userDetails = [
    PeopleData(
        userRegNo: "U01",
        fName: 'Kasim',
        lName: 'Ahmed',
        houseName: 'White House',
        houseRegNo: 'KNY01',
        place: 'Kayani',
        state: 'Kerala',
        district: 'Kannur',
        phone: '+918652148562',
        gender: 'Male',
        dob: '11/05/1980',
        age: '44',
        job: 'Business',
        annualIncome: '9,00,000 to 9,99,999 Lakhs',
        due: '0',
        totalDue: '10500',
        willingToDonateBlood: true,
        bloodGroup: 'O positive (O+)',
        isExpat: true,
        country: 'Saudi Arabia'),
    PeopleData(
      userRegNo: "U02",
      fName: 'Wasim',
      lName: 'Ahmed',
      houseName: 'White House',
      houseRegNo: 'KNY01',
      place: 'Kayani',
      state: 'Kerala',
      district: 'Kannur',
      phone: '+917012652170',
      gender: 'Male',
      dob: '10/03/1984',
      age: '40',
      job: 'Doctor',
      annualIncome: '10 Lakhs and above',
      due: '7500',
      totalDue: '10500',
      willingToDonateBlood: true,
      bloodGroup: 'A positive (A+)',
      isExpat: false,
    ),
    PeopleData(
      userRegNo: "U03",
      fName: 'Nasim',
      lName: 'Ahmed',
      houseName: 'White House',
      houseRegNo: 'KNY01',
      place: 'Kayani',
      state: 'Kerala',
      district: 'Kannur',
      phone: '+918923104578',
      gender: 'Male',
      dob: '01/09/1990',
      age: '34',
      job: 'Engineer',
      annualIncome: '10 Lakhs and above',
      due: '3000',
      totalDue: '10500',
      willingToDonateBlood: false,
      isExpat: true,
      country: 'Japan',
    ),
    PeopleData(
      userRegNo: "U04",
      fName: 'Jasim',
      lName: 'Ahmed',
      houseName: 'White House',
      houseRegNo: 'KNY01',
      place: 'Kayani',
      state: 'Kerala',
      district: 'Kannur',
      phone: '+919091929394',
      gender: 'Male',
      dob: '11/05/1996',
      age: '28',
      job: 'Hotel',
      annualIncome: '7,00,000 to 8,99,999 Lakhs',
      due: '0',
      totalDue: '10500',
      willingToDonateBlood: true,
      bloodGroup: 'AB negative (AB-)',
      isExpat: false,
    ),
    PeopleData(
      userRegNo: "U05",
      fName: 'Muhammed',
      lName: 'Ameer',
      houseName: 'Safiyas',
      houseRegNo: 'KNY02',
      place: 'Kayani',
      state: 'Kerala',
      district: 'Kannur',
      phone: '+915289421358',
      gender: 'Male',
      dob: '11/05/1990',
      age: '34',
      job: 'Daily wage',
      annualIncome: '3,00,000 to 4,99,999 Lakhs',
      due: '8500',
      totalDue: '8500',
      willingToDonateBlood: true,
      bloodGroup: 'AB positive (AB+)',
      isExpat: false,
    ),
    PeopleData(
      userRegNo: "U06",
      fName: 'Muhammed',
      lName: 'Navas',
      houseName: 'Baithunnoor',
      houseRegNo: 'PRY01',
      place: 'Perincheri',
      state: 'Kerala',
      district: 'Kannur',
      phone: '+919955478562',
      gender: 'Male',
      dob: '11/05/1988',
      age: '36',
      job: 'Business',
      annualIncome: '9,00,000 to 9,99,999 Lakhs',
      due: '0',
      totalDue: '0',
      willingToDonateBlood: false,
      isExpat: false,
    ),
    PeopleData(
      userRegNo: "U07",
      fName: 'Muhammed',
      lName: 'Niyas',
      houseName: 'Baithunnoor',
      houseRegNo: 'PRY01',
      place: 'Perincheri',
      state: 'Kerala',
      district: 'Kannur',
      phone: '+915230148976',
      gender: 'Male',
      dob: '11/05/1986',
      age: '38',
      job: 'Business',
      annualIncome: '9,00,000 to 9,99,999 Lakhs',
      due: '0',
      totalDue: '0',
      willingToDonateBlood: true,
      bloodGroup: 'A positive (A+)',
      isExpat: false,
    ),
    PeopleData(
      userRegNo: "U08",
      fName: 'Muhammed',
      lName: 'Nisar',
      houseName: 'Baithunnoor',
      houseRegNo: 'PRY01',
      place: 'Perincheri',
      state: 'Kerala',
      district: 'Kannur',
      phone: '+917089562145',
      gender: 'Male',
      dob: '11/05/1980',
      age: '44',
      job: 'Business',
      annualIncome: '10 Lakhs and above',
      due: '0',
      totalDue: '0',
      willingToDonateBlood: true,
      bloodGroup: 'O negative (O-)',
      isExpat: true,
      country: 'Australia',
    ),
  ];*/
  /*List<PromisesData> promisesDetails = [
    PromisesData(
        userRegNo: 'KNY01',
        fName: 'Navas',
        lName: 'T P',
        description: 'Nabidinam',
        amount: '3000',
        date: '10/06/2024',
        addedBy: 'Treasurer'),
    PromisesData(
        userRegNo: 'KNY02',
        fName: 'Thameem',
        lName: 'Ali',
        description: 'Nabidinam',
        amount: '2000',
        date: '10/07/2024',
        addedBy: 'President'),
    PromisesData(
        userRegNo: 'KNY03',
        fName: 'Musthafa',
        lName: 'N K',
        description: 'Badreengal aand',
        amount: '5000',
        date: '27/03/2024',
        addedBy: 'Treasurer'),
    PromisesData(
        userRegNo: 'KNY01',
        fName: 'Navas',
        lName: 'T P',
        description: 'Badreengal aand',
        amount: '1000',
        date: '27/03/2024',
        addedBy: 'Treasurer'),
    PromisesData(
        userRegNo: 'KNY03',
        fName: 'Musthafa',
        lName: 'N K',
        description: 'Nabidinam',
        amount: '1000',
        date: '10/06/2024',
        addedBy: 'Treasurer'),
    PromisesData(
        userRegNo: 'KNY01',
        fName: 'Navas',
        lName: 'T P',
        description: 'prabhashanam',
        amount: '2000',
        date: '03/09/2024',
        addedBy: 'Secretary'),
    PromisesData(
        userRegNo: 'KNY02',
        fName: 'Thameem',
        lName: 'Ali',
        description: 'prabhashanam',
        amount: '1000',
        date: '02/09/2024',
        addedBy: 'Secretary'),
  ];*/
  /*List<ReportsData> reportsDetails = [
    ReportsData(
        id: '1000',
        description: "Honey Auction",
        date: "01/11/2024",
        amount: '3000',
        isSharable: false,
        incomeOrExpense: '0',
        addedBy: "President"),
    ReportsData(
        id: '1001',
        description: "Banana Auction",
        date: "04/11/2024",
        amount: '1000',
        isSharable: false,
        incomeOrExpense: '0',
        addedBy: "Treasurer"),
    ReportsData(
        id: '1002',
        description: "Electricity Bill",
        date: "11/11/2024",
        isSharable: false,
        amount: '14500',
        incomeOrExpense: '1',
        addedBy: "Secretary"),
    ReportsData(
        id: '1003',
        description: "Ustad Salary",
        date: "10/11/2024",
        amount: '21000',
        isSharable: false,
        incomeOrExpense: '1',
        addedBy: "Treasurer"),
    ReportsData(
        id: '1004',
        description: "Badreengal aand : KNY04 - Musthafa N K",
        date: "14/11/2024",
        amount: '1500',
        isSharable: true,
        currentDue: null,
        incomeOrExpense: '0',
        addedBy: "President"),
    ReportsData(
        id: '1005',
        description: "Maulid vaka",
        date: "01/10/2024",
        amount: '245000',
        isSharable: false,
        incomeOrExpense: '0',
        addedBy: "President"),
    ReportsData(
        id: '1006',
        description: "Moulid nercha food",
        date: "01/10/2024",
        amount: '198000',
        isSharable: false,
        incomeOrExpense: '1',
        addedBy: "President"),
    ReportsData(
        id: '1007',
        description: "Badreengal aand nercha vaka",
        date: "25/10/2024",
        amount: '150000',
        isSharable: false,
        incomeOrExpense: '0',
        addedBy: "Treasurer"),
    ReportsData(
        id: '1008',
        description: "Badreengal aand nercha food",
        date: "01/11/2024",
        amount: '97000',
        isSharable: false,
        incomeOrExpense: '1',
        addedBy: "Treasurer"),
    ReportsData(
        id: '1009',
        description: "Varisanmkhya : KNY01 - Navas T P",
        date: "21/11/2024",
        amount: '2000',
        isSharable: true,
        currentDue: 1000,
        incomeOrExpense: '0',
        addedBy: "Treasurer"),
    ReportsData(
        id: '1010',
        description: "Varisanmkhya : KNY02 - Thameem Ali",
        date: "21/11/2024",
        amount: '3000',
        isSharable: true,
        currentDue: 2000,
        incomeOrExpense: '0',
        addedBy: "Treasurer"),
    ReportsData(
        id: '1011',
        description: "Prabhashanam : KNY03 - Rubais V",
        date: "21/11/2024",
        amount: '2000',
        isSharable: true,
        currentDue: null,
        incomeOrExpense: '0',
        addedBy: "Secretary"),
    ReportsData(
        id: '1003',
        description: "Ustad Salary",
        date: "10/11/2024",
        amount: '21000',
        isSharable: false,
        incomeOrExpense: '1',
        addedBy: "Treasurer"),
    ReportsData(
        id: '1004',
        description: "Friday Bucket",
        date: "14/11/2024",
        amount: '1500',
        isSharable: false,
        incomeOrExpense: '0',
        addedBy: "President"),
    ReportsData(
        id: '1005',
        description: "Maulid vaka",
        date: "01/10/2024",
        amount: '245000',
        isSharable: false,
        incomeOrExpense: '0',
        addedBy: "President"),
    ReportsData(
        id: '1006',
        description: "Moulid nercha food",
        date: "01/10/2024",
        amount: '198000',
        isSharable: false,
        incomeOrExpense: '1',
        addedBy: "President"),
    ReportsData(
        id: '1007',
        description: "Badreengal aand nercha vaka",
        date: "25/10/2024",
        amount: '150000',
        isSharable: false,
        incomeOrExpense: '0',
        addedBy: "Treasurer"),
    ReportsData(
        id: '1008',
        description: "Badreengal aand nercha food",
        date: "01/11/2024",
        amount: '97000',
        isSharable: false,
        incomeOrExpense: '1',
        addedBy: "Treasurer"),
  ];*/ //incomeOrExpense 0 - income, 1 - expense, 2 - others
  /*List<BloodData> bloodDetails = [
    BloodData(
        userRegNo: 'U01',
        bloodGroup: 'A+ve',
        fName: 'Thameem',
        lName: 'Ali',
        mobileNo: '+919400444999',
        gender: "Male",
        houseName: 'Sinan Manzil',
        place: 'Kayani'),
    BloodData(
        userRegNo: 'U02',
        bloodGroup: 'B-ve',
        fName: 'Ayisha',
        lName: 'Beigum',
        mobileNo: '+917865478743',
        gender: "Female",
        houseName: 'Safa Mahal',
        place: 'Perinchery'),
    BloodData(
        userRegNo: 'U03',
        bloodGroup: 'AB-ve',
        fName: 'Hana',
        lName: 'Maryam',
        mobileNo: '+917865478743',
        gender: "Female",
        houseName: 'Hana Mahal',
        place: 'Kayani'),
    BloodData(
        userRegNo: 'U04',
        bloodGroup: 'O+ve',
        fName: 'Arshad',
        lName: 'K M',
        mobileNo: '+917865475376',
        gender: "Male",
        houseName: 'White House',
        place: 'Koolikkadav'),
    BloodData(
        userRegNo: 'U05',
        bloodGroup: 'B-ve',
        fName: 'Ramees',
        lName: 'K',
        mobileNo: '+917895260125',
        gender: "Male",
        houseName: 'Puthiyapura',
        place: 'Koolikkadav'),
    BloodData(
        userRegNo: 'U06',
        bloodGroup: 'AB+ve',
        fName: 'Ramshad',
        lName: 'K',
        mobileNo: '+917865478743',
        gender: "Male",
        houseName: 'Baithunnoor',
        place: 'Perinchery'),
    BloodData(
        userRegNo: 'U07',
        bloodGroup: 'B-ve',
        fName: 'Ayisha',
        lName: 'Beigum',
        mobileNo: '+917865478743',
        gender: "Female",
        houseName: 'Safa Mahal',
        place: 'Perinchery'),
    BloodData(
        userRegNo: 'U08',
        bloodGroup: 'B-ve',
        fName: 'Ayisha',
        lName: 'Beigum',
        mobileNo: '+917865478743',
        gender: "Female",
        houseName: 'Safa Mahal',
        place: 'Perinchery'),
    BloodData(
        userRegNo: 'U09',
        bloodGroup: 'B-ve',
        fName: 'Ayisha',
        lName: 'Beigum',
        mobileNo: '+917865478743',
        gender: "Female",
        houseName: 'Safa Mahal',
        place: 'Perinchery'),
    BloodData(
        userRegNo: 'U10',
        bloodGroup: 'B-ve',
        fName: 'Ayisha',
        lName: 'Beigum',
        mobileNo: '+917865478743',
        gender: "Female",
        houseName: 'Safa Mahal',
        place: 'Perinchery'),
    BloodData(
        userRegNo: 'U11',
        bloodGroup: 'B-ve',
        fName: 'Ayisha',
        lName: 'Beigum',
        mobileNo: '+917865478743',
        gender: "Female",
        houseName: 'Safa Mahal',
        place: 'Perinchery'),
    BloodData(
        userRegNo: 'U12',
        bloodGroup: 'B-ve',
        fName: 'Ayisha',
        lName: 'Beigum',
        mobileNo: '+917865478743',
        gender: "Female",
        houseName: 'Safa Mahal',
        place: 'Perinchery'),
    BloodData(
        userRegNo: 'U13',
        bloodGroup: 'B-ve',
        fName: 'Ayisha',
        lName: 'Beigum',
        mobileNo: '+917865478743',
        gender: "Female",
        houseName: 'Safa Mahal',
        place: 'Perinchery'),
  ];*/
  /*List<ExpatData> expatDetails = [
    ExpatData(
        userRegNo: 'U01',
        country: 'UAE',
        name: 'Abdul Salam',
        mobileNo: '+913384848840',
        houseName: 'Kolikkeel House',
        place: 'Kayani'),
    ExpatData(
        userRegNo: 'U02',
        country: 'Abudabi',
        name: 'Navas V',
        mobileNo: '+913384848840',
        houseName: 'New House',
        place: 'Perinchery'),
    ExpatData(
        userRegNo: 'U03',
        country: 'Saudi Arabia',
        name: 'Thameem Ali',
        mobileNo: '+913384848840',
        houseName: 'New House',
        place: 'Koolikkadav'),
    ExpatData(
        userRegNo: 'U04',
        country: 'Australia',
        name: 'Rubais K',
        mobileNo: '+913384848840',
        houseName: 'White House',
        place: 'Kayani'),
    ExpatData(
        userRegNo: 'U05',
        country: 'USA',
        name: 'Muhammed Sinan',
        mobileNo: '+913384848840',
        houseName: 'Red House',
        place: 'Perinchery'),
    ExpatData(
        userRegNo: 'U06',
        country: 'USA',
        name: 'Nasser P',
        mobileNo: '+913384848840',
        houseName: 'White House',
        place: 'Perinchery'),
    ExpatData(
        userRegNo: 'U07',
        country: 'USA',
        name: 'Haris T',
        mobileNo: '+913384848840',
        houseName: 'Black House',
        place: 'Perinchery'),
    ExpatData(
        userRegNo: 'U08',
        country: 'UK',
        name: 'Wasim Muhsin',
        mobileNo: '+913384848840',
        houseName: 'Pink Mahal',
        place: 'Koolikkadav'),
    ExpatData(
        userRegNo: 'U09',
        country: 'UAE',
        name: 'Jabbar K',
        mobileNo: '+913384848840',
        houseName: 'Baithunnoor',
        place: 'Manakkayi'),
    ExpatData(
        userRegNo: 'U10',
        country: 'UK',
        name: 'Nissar Muhammed',
        mobileNo: '+913384848840',
        houseName: 'Safiyas',
        place: 'Koolikkadav'),
    ExpatData(
        userRegNo: 'U11',
        country: 'Japan',
        name: 'Abdul Basith P M',
        mobileNo: '+913384848840',
        houseName: 'Puthiyapura',
        place: 'Kayani'),
    ExpatData(
        userRegNo: 'U12',
        country: 'Japan',
        name: 'Raheem P K',
        mobileNo: '+913384848840',
        houseName: 'Safiyas',
        place: 'Koolikkadav'),
    ExpatData(
        userRegNo: 'U13',
        country: 'China',
        name: 'Nishad K P',
        mobileNo: '+913384848840',
        houseName: 'Kolikkeel House',
        place: 'Manakkayi'),
    ExpatData(
        userRegNo: 'U14',
        country: 'China',
        name: 'Ramshad K',
        mobileNo: '+913384848840',
        houseName: 'Kolikkeel House',
        place: 'Kayani'),
    ExpatData(
        userRegNo: 'U15',
        country: 'China',
        name: 'Abdul Salam P P',
        mobileNo: '+913384848840',
        houseName: 'Kolikkeel House',
        place: 'Manakkayi'),
  ];*/

  List<ChartDataModel> get chartData => [
        ChartDataModel(category: "Income", amount: income.value),
        ChartDataModel(category: "Expense", amount: expense.value),
      ];

  @override
  Future<void> onInit() async {
    super.onInit();

    getVersionCode();
    userType = storageService.getUserType() ?? '';
    //userType = '2';

    if (userType == '2') {
    } else {
      getUserDetails();
      getPromisesDetails();
      getReportsDetails();
      getBloodGroupDetails();
      getExpatsDetails();
    }

    mahallName = storageService.getMahallName() ?? '';
    _showLicenseExpiryWarning();

    bottomNavIcons = userType == '2'
        ? [
            Image.asset('assets/images/users.png',
                width: 25, height: 25, color: AppColors.white),
            Image.asset('assets/images/blood.png',
                width: 25, height: 25, color: AppColors.white),
            Image.asset('assets/images/expat.png',
                width: 25, height: 25, color: AppColors.white),
          ]
        : [
            Image.asset('assets/images/home.png',
                width: 25, height: 25, color: AppColors.white),
            Image.asset('assets/images/users.png',
                width: 25, height: 25, color: AppColors.white),
            Image.asset('assets/images/promises.png',
                width: 25, height: 25, color: AppColors.white),
            Image.asset('assets/images/report.png',
                width: 25, height: 25, color: AppColors.white),
            Image.asset('assets/images/blood.png',
                width: 25, height: 25, color: AppColors.white),
            Image.asset('assets/images/expat.png',
                width: 25, height: 25, color: AppColors.white),
          ];

    bottomNavTitles = userType == '2'
        ? [AppStrings.users, AppStrings.blood, AppStrings.expat]
        : [
            AppStrings.dashboard,
            AppStrings.users,
            AppStrings.promises,
            AppStrings.reports,
            AppStrings.blood,
            AppStrings.expat
          ];

    userSearchController.addListener(() {
      searchUser(userSearchController.text);
    });
    promisesSearchController.addListener(() {
      searchPromises(promisesSearchController.text);
    });

    reportSearchController.addListener(() {
      searchReports(reportSearchController.text);
    });

    bloodSearchController.addListener(() {
      searchBlood(bloodSearchController.text);
    });
    expatSearchController.addListener(() {
      searchExpat(expatSearchController.text);
    });
    if (isExpandedList.isEmpty) {
      print('userDetails length : ${userDetails.length}');
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

    //Get.updateLocale(Locale(lang));
  }

  getUserDetails() async {
    isLoading.value = true;
    userDetails.clear();
    filteredUserDetails.clear();
    var isConnectedToInternet = await isInternetAvailable();
    if (isConnectedToInternet) {
      try {
        GetHouseAndUsersModel response = await listingService
            .getHouseAndUsersDetails(storageService.getToken() ?? '');
        if (response.status == true) {
          userDetails.addAll(response.data!);
          filteredUserDetails.assignAll(userDetails);
          if (isExpandedList.isEmpty) {
            isExpandedList.value = RxList.filled(userDetails.length, false);
          }
        } else {}
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

  getPromisesDetails() async {
    isLoading.value = true;
    promisesDetails.clear();
    filteredPromisesDetails.clear();
    var isConnectedToInternet = await isInternetAvailable();
    if (isConnectedToInternet) {
      try {
        GetPromisesModel response =
            await listingService.getPromises(storageService.getToken() ?? '');
        if (response.status == true) {
          promisesDetails.addAll(response.data!);
          filteredPromisesDetails.assignAll(promisesDetails);
          calculatePromisesTotal();
        } else {}
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

  getReportsDetails() async {
    isLoading.value = true;
    reportsDetails.clear();
    filteredReportsDetails.clear();
    var isConnectedToInternet = await isInternetAvailable();
    if (isConnectedToInternet) {
      try {
        GetReportsModel response =
            await listingService.getReports(storageService.getToken() ?? '');
        if (response.status == true) {
          reportsDetails.addAll(response.data!);
          filteredReportsDetails.assignAll(reportsDetails);
          calculateReportTotal();
        } else {}
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

  getBloodGroupDetails() async {
    isLoading.value = true;
    bloodDetails.clear();
    filteredBloodDetails.clear();
    var isConnectedToInternet = await isInternetAvailable();
    if (isConnectedToInternet) {
      try {
        GetBloodModel response = await listingService
            .getBloodGroups(storageService.getToken() ?? '');
        if (response.status == true) {
          bloodDetails.addAll(response.data!);
          filteredBloodDetails.assignAll(bloodDetails);
        } else {}
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

  getExpatsDetails() async {
    isLoading.value = true;
    expatDetails.clear();
    filteredExpatDetails.clear();
    var isConnectedToInternet = await isInternetAvailable();
    if (isConnectedToInternet) {
      try {
        GetExpatModel response =
            await listingService.getExpats(storageService.getToken() ?? '');
        if (response.status == true) {
          expatDetails.addAll(response.data!);
          filteredExpatDetails.assignAll(expatDetails);
        } else {}
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

  deleteHouse(int houseId) async {
    isLoading.value = true;
    var isConnectedToInternet = await isInternetAvailable();
    if (isConnectedToInternet) {
      try {
        CommonResponse response = await listingService
            .deleteHouse(storageService.getToken() ?? '', {'id': houseId});
        if (response.status == true) {
          showToast(
              title: response.message.toString(),
              type: ToastificationType.success);
          getUserDetails();
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

  deleteUser(int userId) async {
    isLoading.value = true;
    var isConnectedToInternet = await isInternetAvailable();
    if (isConnectedToInternet) {
      try {
        CommonResponse response = await listingService
            .deleteUser(storageService.getToken() ?? '', {'id': userId});
        if (response.status == true) {
          showToast(
              title: response.message.toString(),
              type: ToastificationType.success);
          getUserDetails();
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

  _showLicenseExpiryWarning() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (licenseExpiry.value == 1) {
        showCommonDialog(
          licenseKey: licenseExpiry.value,
          Get.context!,
          message: '3',
        );
      } else if (licenseExpiry.value == 2) {
        showCommonDialog(
          licenseKey: licenseExpiry.value,
          userType: int.parse(userType),
          Get.context!,
          barrierDismissible: false,
          message: '',
        );
      }
    });
  }

  _showAppUpdateAlert(String versionCode) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (versionCode != lastAppVersion) {
        showCommonDialog(
          licenseKey: 0,
          userType: 0,
          updatesAvailable: true,
          barrierDismissible: false,
          onNoTap: () {},
          Get.context!,
          message: AppStrings.newUpdateAvailable,
        );
      }
    });
  }

  Future<void> getVersionCode() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String buildNumber = packageInfo.version;
    versionCode.value = 'V $buildNumber';
    _showAppUpdateAlert(buildNumber);
  }

  Map<String, List<PeopleData>> groupedUsers() {
    Map<String, List<PeopleData>> grouped = {};
    for (var house in filteredUserDetails) {
      final key = '${house.houseRegNo} - ${house.houseName} : ${house.houseId}';
      if (!grouped.containsKey(key)) {
        grouped[key] = [];
      }
      grouped[key]?.add(house);
    }
    return grouped;
  }

  calculateReportTotal() {
    reportTotal.value = 0.0;
    for (int i = 0; i < filteredReportsDetails.length; i++) {
      if (filteredReportsDetails[i].incomeOrExpense == '0') {
        reportTotal.value = reportTotal.value +
            double.parse(filteredReportsDetails[i].amount ?? '');
      } else {
        reportTotal.value = reportTotal.value -
            double.parse(filteredReportsDetails[i].amount ?? '');
      }
    }
  }

  calculatePromisesTotal() {
    promisesTotal.value = 0.0;
    for (int i = 0; i < filteredPromisesDetails.length; i++) {
      promisesTotal.value = promisesTotal.value +
          double.parse(filteredPromisesDetails[i].amount ?? '');
    }
  }

  void updateReportItem(Map<String, dynamic> updatedItem) {
    int index = filteredReportsDetails
        .indexWhere((item) => item.id == updatedItem['id']);
    if (index != -1) {
      filteredReportsDetails[index] = ReportsData.fromJson(updatedItem);
    }
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
        DateTime reportDate = DateFormat('dd/MM/yyyy').parse(report.date ?? '');

        isWithinDateRange =
            (reportDate.isAtSameMomentAs(from) || reportDate.isAfter(from)) &&
                (reportDate.isAtSameMomentAs(to) || reportDate.isBefore(to));
      }

      // Type Filter (Income/Expense)
      bool isTypeMatched =
          (isIncomeChecked.value && report.incomeOrExpense == '0') ||
              (isExpenseChecked.value && report.incomeOrExpense == '1') ||
              (!isIncomeChecked.value && !isExpenseChecked.value);

      // Role Filter (addedBy)
      bool isRoleMatched =
          (isPresidentChecked.value && report.addedBy.toString() == '0') ||
              (isSecretaryChecked.value && report.addedBy.toString() == '1') ||
              (isTreasurerChecked.value && report.addedBy.toString() == '2') ||
              (!isPresidentChecked.value &&
                  !isSecretaryChecked.value &&
                  !isTreasurerChecked.value);

      // Search Filter
      bool isSearchMatched = searchText.isEmpty ||
          (report.description?.toLowerCase().contains(searchText) ?? false) ||
          (report.amount.toString().contains(searchText)) ||
          (report.id.toString().contains(searchText));

      return isWithinDateRange &&
          isTypeMatched &&
          isRoleMatched &&
          isSearchMatched;
    }).toList();
    calculateReportTotal();
  }

  void applyBloodFilters() {
    String searchText = bloodSearchController.text.trim().toLowerCase();

    filteredBloodDetails.value = bloodDetails.where((blood) {
      bool isGenderMatched = (isMaleChecked.value && blood.gender == 'Male') ||
          (isFemaleChecked.value && blood.gender == 'Female') ||
          (!isMaleChecked.value && !isFemaleChecked.value);

      bool isBloodMatched =
          (isAposChecked.value && blood.bloodGroup == 'A+ve') ||
              (isAnegChecked.value && blood.bloodGroup == 'A-ve') ||
              (isBposChecked.value && blood.bloodGroup == 'B+ve') ||
              (isBnegChecked.value && blood.bloodGroup == 'B-ve') ||
              (isABposChecked.value && blood.bloodGroup == 'AB+ve') ||
              (isABnegChecked.value && blood.bloodGroup == 'AB-ve') ||
              (isOposChecked.value && blood.bloodGroup == 'O+ve') ||
              (isOnegChecked.value && blood.bloodGroup == 'O-ve') ||
              (!isAposChecked.value &&
                  !isAnegChecked.value &&
                  !isBposChecked.value &&
                  !isBnegChecked.value &&
                  !isABposChecked.value &&
                  !isABnegChecked.value &&
                  !isOposChecked.value &&
                  !isOnegChecked.value);

      // Search Filter
      bool isSearchMatched = searchText.isEmpty ||
          (blood.fName?.toLowerCase().contains(searchText) ?? false) ||
          (blood.lName?.toLowerCase().contains(searchText) ?? false) ||
          (blood.place?.toLowerCase().contains(searchText) ?? false) ||
          (blood.bloodGroup.toString().contains(searchText)) ||
          (blood.userRegNo.toString().contains(searchText));

      return isGenderMatched && isBloodMatched && isSearchMatched;
    }).toList();
  }

  clearReportFilters() {
    reportTotal.value = 0.0;
    filteredReportsDetails.assignAll(reportsDetails);
    calculateReportTotal();
    reportSearchController.clear();
    isReportFilterSubmitted.value = false;
    fromDate.value = AppStrings.selectFromDate;
    toDate.value = AppStrings.selectToDate;
    isIncomeChecked.value = false;
    isExpenseChecked.value = false;
    isPresidentChecked.value = false;
    isSecretaryChecked.value = false;
    isTreasurerChecked.value = false;
  }

  clearBloodFilters() {
    filteredBloodDetails.assignAll(bloodDetails);
    bloodSearchController.clear();
    isBloodFilterSubmitted.value = false;
    isMaleChecked.value = false;
    isFemaleChecked.value = false;
    isAposChecked.value = false;
    isAnegChecked.value = false;
    isBposChecked.value = false;
    isBnegChecked.value = false;
    isABposChecked.value = false;
    isABnegChecked.value = false;
    isOposChecked.value = false;
    isOnegChecked.value = false;
  }

  bool checkReportFilters() {
    bool isDateSelected = fromDate.value != AppStrings.selectFromDate ||
        toDate.value != AppStrings.selectToDate;

    bool isCheckboxChecked = isIncomeChecked.value ||
        isExpenseChecked.value ||
        isPresidentChecked.value ||
        isSecretaryChecked.value ||
        isTreasurerChecked.value;

    return isDateSelected || isCheckboxChecked;
  }

  bool checkBloodFilters() {
    bool isCheckboxChecked = isMaleChecked.value ||
        isFemaleChecked.value ||
        isAposChecked.value ||
        isAnegChecked.value ||
        isBposChecked.value ||
        isBnegChecked.value ||
        isABposChecked.value ||
        isABnegChecked.value ||
        isOposChecked.value ||
        isOnegChecked.value;

    return isCheckboxChecked;
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

  void toggleMaleCheckbox() {
    isMaleChecked.value = !isMaleChecked.value;
    if (isMaleChecked.value) {
    } else {
      selectedGenderType.value = null;
    }
    selectedGenderType.value = isMaleChecked.value ? GenderType.male : null;
  }

  void toggleFemaleCheckbox() {
    isFemaleChecked.value = !isFemaleChecked.value;
    if (isFemaleChecked.value) {
    } else {
      selectedGenderType.value = null;
    }
    selectedGenderType.value = isFemaleChecked.value ? GenderType.female : null;
  }

  void toggleAposCheckbox() {
    isAposChecked.value = !isAposChecked.value;
    if (isAposChecked.value) {
    } else {
      selectedBloodType.value = null;
    }
    selectedBloodType.value = isAposChecked.value ? BloodType.apos : null;
  }

  void toggleAnegCheckbox() {
    isAnegChecked.value = !isAnegChecked.value;
    if (isAnegChecked.value) {
    } else {
      selectedBloodType.value = null;
    }
    selectedBloodType.value = isAnegChecked.value ? BloodType.aneg : null;
  }

  void toggleBposCheckbox() {
    isBposChecked.value = !isBposChecked.value;
    if (isBposChecked.value) {
    } else {
      selectedBloodType.value = null;
    }
    selectedBloodType.value = isBposChecked.value ? BloodType.bpos : null;
  }

  void toggleBnegCheckbox() {
    isBnegChecked.value = !isBnegChecked.value;
    if (isBnegChecked.value) {
    } else {
      selectedBloodType.value = null;
    }
    selectedBloodType.value = isBnegChecked.value ? BloodType.bneg : null;
  }

  void toggleABposCheckbox() {
    isABposChecked.value = !isABposChecked.value;
    if (isABposChecked.value) {
    } else {
      selectedBloodType.value = null;
    }
    selectedBloodType.value = isABposChecked.value ? BloodType.abpos : null;
  }

  void toggleABnegCheckbox() {
    isABnegChecked.value = !isABnegChecked.value;
    if (isABnegChecked.value) {
    } else {
      selectedBloodType.value = null;
    }
    selectedBloodType.value = isABnegChecked.value ? BloodType.abneg : null;
  }

  void toggleOposCheckbox() {
    isOposChecked.value = !isOposChecked.value;
    if (isOposChecked.value) {
    } else {
      selectedBloodType.value = null;
    }
    selectedBloodType.value = isOposChecked.value ? BloodType.opos : null;
  }

  void toggleOnegCheckbox() {
    isOnegChecked.value = !isOnegChecked.value;
    if (isOnegChecked.value) {
    } else {
      selectedBloodType.value = null;
    }
    selectedBloodType.value = isOnegChecked.value ? BloodType.oneg : null;
  }

  searchUser(String query) {
    searchQuery.value = query.toLowerCase();
    if (searchQuery.isEmpty) {
      filteredUserDetails.value = userDetails;
    } else {
      filteredUserDetails.value = userDetails.where((house) {
        return house.houseRegNo!
                .toLowerCase()
                .contains(searchQuery.value.toLowerCase()) ||
            house.houseName!
                .toLowerCase()
                .contains(searchQuery.value.toLowerCase()) ||
            house.userRegNo!
                .toLowerCase()
                .contains(searchQuery.value.toLowerCase()) ||
            house.fName!
                .toLowerCase()
                .contains(searchQuery.value.toLowerCase()) ||
            house.lName!
                .toLowerCase()
                .contains(searchQuery.value.toLowerCase());
      }).toList();
    }
  }

  searchPromises(String query) {
    searchQuery.value = query.toLowerCase();
    if (searchQuery.isEmpty) {
      filteredPromisesDetails.value = promisesDetails;
      calculatePromisesTotal();
    } else {
      filteredPromisesDetails.value = promisesDetails.where((reports) {
        return reports.description!
                .toLowerCase()
                .contains(searchQuery.value.toLowerCase()) ||
            reports.userRegNo!
                .toLowerCase()
                .contains(searchQuery.value.toLowerCase()) ||
            reports.fName!
                .toLowerCase()
                .contains(searchQuery.value.toLowerCase()) ||
            reports.lName!
                .toLowerCase()
                .contains(searchQuery.value.toLowerCase());
      }).toList();
      calculatePromisesTotal();
    }
  }

  searchReports(String query) {
    searchQuery.value = query.toLowerCase();
    if (searchQuery.value.isEmpty) {
      filteredReportsDetails.value = reportsDetails;
      calculateReportTotal();
    } else {
      filteredReportsDetails.value = reportsDetails.where((reports) {
        return reports.description!.toLowerCase().contains(searchQuery.value) ||
            reports.id.toString().toLowerCase().contains(searchQuery.value);
      }).toList();
      calculateReportTotal();
    }
  }

  searchBlood(String query) {
    searchQuery.value = query.toLowerCase();
    if (searchQuery.isEmpty) {
      filteredBloodDetails.value = bloodDetails;
    } else {
      filteredBloodDetails.value = bloodDetails.where((reports) {
        return reports.bloodGroup!
                .toLowerCase()
                .contains(searchQuery.value.toLowerCase()) ||
            reports.fName!
                .toLowerCase()
                .contains(searchQuery.value.toLowerCase()) ||
            reports.lName!
                .toLowerCase()
                .contains(searchQuery.value.toLowerCase()) ||
            reports.userRegNo.toString().toLowerCase().contains(query) ||
            reports.place
                .toString()
                .toLowerCase()
                .contains(searchQuery.value.toLowerCase());
      }).toList();
    }
  }

  searchExpat(String query) {
    searchQuery.value = query.toLowerCase();
    if (searchQuery.isEmpty) {
      filteredExpatDetails.value = expatDetails;
    } else {
      filteredExpatDetails.value = expatDetails.where((reports) {
        return reports.country!
                .toLowerCase()
                .contains(searchQuery.value.toLowerCase()) ||
            reports.fName!
                .toLowerCase()
                .contains(searchQuery.value.toLowerCase()) ||
            reports.lName!
                .toLowerCase()
                .contains(searchQuery.value.toLowerCase()) ||
            reports.userRegNo
                .toString()
                .toLowerCase()
                .contains(searchQuery.value.toLowerCase()) ||
            reports.place
                .toString()
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

  int calculateTotalDue(List<PeopleData> people) {
    return people.fold(0, (sum, person) {
      int due = int.tryParse(person.due ?? '0') ?? 0;
      return sum + due;
    });
  }

  String getAddedBy(String addedBy) {
    if (addedBy == '0') {
      return AppStrings.president;
    } else if (addedBy == '1') {
      return AppStrings.secretary;
    } else {
      return AppStrings.treasurer;
    }
  }

  deleteReport(num id) async {
    isLoading.value = true;
    var isConnectedToInternet = await isInternetAvailable();
    if (isConnectedToInternet) {
      try {
        CommonResponse response = await listingService
            .deleteReport(storageService.getToken() ?? '', {"id": id});
        if (response.status == true) {
          showToast(
              title: response.message.toString(),
              type: ToastificationType.success);
          getReportsDetails();
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

  deletePromises(num id) async {
    isLoading.value = true;
    var isConnectedToInternet = await isInternetAvailable();
    if (isConnectedToInternet) {
      try {
        CommonResponse response = await listingService
            .deletePromises(storageService.getToken() ?? '', {"id": id});
        if (response.status == true) {
          showToast(
              title: response.message.toString(),
              type: ToastificationType.success);
          getPromisesDetails();
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

  performLogout() async {
    isLoggingOut.value = true;
    var isConnectedToInternet = await isInternetAvailable();
    if (isConnectedToInternet) {
      try {
        CommonResponse response = await listingService.logout(
          storageService.getToken() ?? '',
        );
        if (response.status == true) {
          showToast(
              title: response.message.toString(),
              type: ToastificationType.success);
          storageService.logout();
          Get.offAllNamed(Routes.LOGIN);
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
        isLoggingOut.value = false;
      }
    } else {
      showToast(
          title: AppStrings.noInternetConnection,
          type: ToastificationType.error);
      isLoggingOut.value = false;
    }
  }
}
