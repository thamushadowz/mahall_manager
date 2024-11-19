import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mahall_manager/domain/listing/models/get_house_and_users_model.dart';
import 'package:mahall_manager/domain/listing/models/house_registration_model.dart';
import 'package:toastification/toastification.dart';

import '../../../domain/core/interfaces/common_alert.dart';
import '../../../domain/core/interfaces/utility_services.dart';
import '../../../domain/listing/listing_repository.dart';
import '../../../domain/listing/listing_service.dart';
import '../../../domain/listing/models/common_response.dart';
import '../../../infrastructure/dal/services/storage_service.dart';
import '../../../infrastructure/theme/strings/app_strings.dart';

class RegistrationController extends GetxController {
  String mainHeading = AppStrings.registration;
  PeopleData person = PeopleData();
  RxList<HouseData> houseData = RxList([]);
  RxBool isExpat = false.obs;
  RxBool isWillingToDonate = false.obs;
  RxBool isRegistrationSuccess = false.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  ListingService listingService = Get.find<ListingRepository>();
  final StorageService _storageService = StorageService();

  final RxBool isLoading = false.obs;
  final RxBool isDataLoading = false.obs;
  final RxBool isHouseDataSuccessful = false.obs;
  RxInt selectedState = 0.obs;
  int houseId = 0;
  bool isEditing = false;

  final regNoFocusNode = FocusNode();
  final fNameFocusNode = FocusNode();
  final lNameFocusNode = FocusNode();
  final houseNameFocusNode = FocusNode();
  final placeFocusNode = FocusNode();
  final districtFocusNode = FocusNode();
  final stateFocusNode = FocusNode();
  final mobileNoFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final genderFocusNode = FocusNode();
  final dobFocusNode = FocusNode();
  final ageFocusNode = FocusNode();
  final jobFocusNode = FocusNode();
  final incomeFocusNode = FocusNode();
  final bloodFocusNode = FocusNode();
  final pendingAmountFocusNode = FocusNode();
  final countryFocusNode = FocusNode();

  final regNoController = TextEditingController();
  final fNameController = TextEditingController();
  final lNameController = TextEditingController();
  final houseNameController = TextEditingController();
  final placeController = TextEditingController();
  final districtController = TextEditingController();
  final stateController = TextEditingController();
  final mobileNoController = TextEditingController();
  final passwordController = TextEditingController();
  final genderController = TextEditingController();
  final dobController = TextEditingController();
  final ageController = TextEditingController();
  final jobController = TextEditingController();
  final incomeController = TextEditingController();
  final bloodController = TextEditingController();
  final pendingAmountController = TextEditingController();
  final countryController = TextEditingController();

  @override
  void onInit() {
    if (Get.arguments != null) {
      isEditing = true;
      mainHeading = AppStrings.editUser;
      person = Get.arguments;
      regNoController.text = person.userRegNo ?? '';
      fNameController.text = person.fName ?? '';
      lNameController.text = person.lName ?? '';
      houseNameController.text = person.houseName ?? '';
      placeController.text = person.place ?? '';
      districtController.text = person.district ?? '';
      stateController.text = person.state ?? '';
      mobileNoController.text = person.phone ?? '';
      genderController.text = person.gender ?? '';
      dobController.text = person.dob ?? '';
      ageController.text = person.age ?? '';
      jobController.text = person.job ?? '';
      incomeController.text = person.annualIncome ?? '';
      bloodController.text = person.bloodGroup ?? '';
      pendingAmountController.text = person.due ?? '';
      countryController.text = person.country ?? '';
      isWillingToDonate.value = person.willingToDonateBlood ?? false;
      isExpat.value = person.isExpat ?? false;
    } else {
      getHouseDetailsList();
    }
    super.onInit();
  }

  int calculateAge(DateTime birthDate) {
    DateTime today = DateTime.now();
    int age = today.year - birthDate.year;
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  getHouseDetailsList() async {
    isDataLoading.value = true;
    var isConnectedToInternet = await isInternetAvailable();
    if (isConnectedToInternet) {
      try {
        HouseRegistrationModel response = await listingService
            .getHouseDetails(_storageService.getToken() ?? '');
        print('token is : ${_storageService.getToken()}');
        if (response.status == true) {
          houseData.addAll(response.data!);
          isHouseDataSuccessful.value = true;
        } else {
          isHouseDataSuccessful.value = false;
        }
      } catch (e) {
        showToast(
            title: AppStrings.somethingWentWrong,
            type: ToastificationType.error);
      } finally {
        isDataLoading.value = false;
      }
    } else {
      showToast(
          title: AppStrings.noInternetConnection,
          type: ToastificationType.error);
      isDataLoading.value = false;
    }
  }

  performRegistration() async {
    var userData = PeopleData(
        userRegNo: regNoController.text.trim(),
        fName: fNameController.text.trim(),
        lName: lNameController.text.trim(),
        houseName: houseId.toString().trim(),
        phone: mobileNoController.text.trim(),
        gender: genderController.text.trim(),
        dob: dobController.text.trim(),
        age: ageController.text.trim(),
        job: jobController.text.trim(),
        annualIncome: incomeController.text.trim(),
        due: pendingAmountController.text.trim(),
        willingToDonateBlood: isWillingToDonate.value,
        bloodGroup: bloodController.text.trim(),
        isExpat: isExpat.value,
        country: countryController.text.trim());
    print('peopleDataaaa ::: ${userData.toJson()}');
    isLoading.value = true;
    var isConnectedToInternet = await isInternetAvailable();
    if (isConnectedToInternet) {
      try {
        CommonResponse response = await listingService.userRegistration(
            _storageService.getToken() ?? '', userData);
        print('USER DATA ::: ${userData.toJson()}');
        if (response.status == true) {
          showToast(
              title: response.message.toString(),
              type: ToastificationType.success);
          resetForm();
          isRegistrationSuccess.value = true;
        } else {
          isRegistrationSuccess.value = false;
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
        print('Exception : $e');
        showToast(
            title: AppStrings.somethingWentWrong,
            type: ToastificationType.error);
        isRegistrationSuccess.value = false;
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

  editUserDetails() async {
    isLoading.value = true;
    var isConnectedToInternet = await isInternetAvailable();
    if (isConnectedToInternet) {
      try {
        CommonResponse response = await listingService.updateUser(
            _storageService.getToken() ?? '',
            PeopleData(
                id: person.id,
                fName: fNameController.text.trim(),
                lName: lNameController.text.trim(),
                phone: mobileNoController.text.trim(),
                gender: genderController.text.trim(),
                dob: dobController.text.trim(),
                age: ageController.text.trim(),
                job: jobController.text.trim(),
                annualIncome: incomeController.text.trim(),
                due: pendingAmountController.text.trim(),
                willingToDonateBlood: isWillingToDonate.value,
                bloodGroup: bloodController.text.trim(),
                isExpat: isExpat.value,
                country: countryController.text.trim()));
        if (response.status == true) {
          showToast(
              title: response.message.toString(),
              type: ToastificationType.success);
          Get.back();
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

  @override
  void onClose() {
    disposeAll();
    super.onClose();
  }

  void resetForm() {
    regNoController.clear();
    fNameController.clear();
    lNameController.clear();
    houseNameController.clear();
    placeController.clear();
    districtController.clear();
    stateController.clear();
    mobileNoController.clear();
    passwordController.clear();
    genderController.clear();
    dobController.clear();
    ageController.clear();
    jobController.clear();
    incomeController.clear();
    bloodController.clear();
    pendingAmountController.clear();
    countryController.clear();
    isWillingToDonate.value = false;
    isExpat.value = false;
  }

  void disposeAll() {
    regNoController.dispose();
    fNameController.dispose();
    lNameController.dispose();
    houseNameController.dispose();
    placeController.dispose();
    districtController.dispose();
    stateController.dispose();
    mobileNoController.dispose();
    passwordController.dispose();
    genderController.dispose();
    dobController.dispose();
    ageController.dispose();
    jobController.dispose();
    incomeController.dispose();
    bloodController.dispose();
    pendingAmountController.dispose();
    countryController.dispose();

    regNoFocusNode.dispose();
    fNameFocusNode.dispose();
    lNameFocusNode.dispose();
    houseNameFocusNode.dispose();
    placeFocusNode.dispose();
    districtFocusNode.dispose();
    stateFocusNode.dispose();
    mobileNoFocusNode.dispose();
    passwordFocusNode.dispose();
    genderFocusNode.dispose();
    dobFocusNode.dispose();
    ageFocusNode.dispose();
    jobFocusNode.dispose();
    incomeFocusNode.dispose();
    bloodFocusNode.dispose();
    pendingAmountFocusNode.dispose();
    countryFocusNode.dispose();
  }
}
