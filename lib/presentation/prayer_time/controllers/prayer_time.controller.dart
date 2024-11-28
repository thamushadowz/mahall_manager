import 'package:adhan/adhan.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../domain/core/interfaces/utility_services.dart';

class PrayerTimeController extends GetxController {
  RxString selectedMethod = ''.obs;
  RxString selectedMadhab = ''.obs;
  RxString decorationGif = ''.obs;

  RxBool isSettingsClicked = false.obs;
  RxBool isLoading = true.obs;
  RxBool isSubhAlarmOn = true.obs;
  RxBool isLuhrAlarmOn = true.obs;
  RxBool isAsrAlarmOn = true.obs;
  RxBool isMagribAlarmOn = true.obs;
  RxBool isIshaAlarmOn = true.obs;

  CalculationMethod methodKey = CalculationMethod.karachi;
  Madhab madhabKey = Madhab.shafi;

  late Position currentCoordinates;
  double latitude = 0.0;
  double longitude = 0.0;
  late Coordinates myCoordinates;

  CalculationParameters params = CalculationMethod.karachi.getParameters();

  Rxn<PrayerTimes> prayerTimes = Rxn<PrayerTimes>();

  final prayerMethods = {
    'Muslim World League': CalculationMethod.muslim_world_league,
    'Egyptian General Authority': CalculationMethod.egyptian,
    'University of Islamic Sciences, Karachi': CalculationMethod.karachi,
    'Umm Al-Qura University, Makkah': CalculationMethod.umm_al_qura,
    'Dubai': CalculationMethod.dubai,
    'Moonsighting Committee': CalculationMethod.moon_sighting_committee,
    'North America': CalculationMethod.north_america,
    'Kuwait': CalculationMethod.kuwait,
    'Qatar': CalculationMethod.qatar,
    'Singapore': CalculationMethod.singapore,
    'Turkey': CalculationMethod.turkey,
    'Tehran': CalculationMethod.tehran,
    'Other': CalculationMethod.other,
  };

  final madhabs = {
    'Shafi': Madhab.shafi,
    'Hanafi': Madhab.hanafi,
  };

  Future<Position?> getCurrentLocation() async {
    bool permissionGranted;
    permissionGranted = await requestLocationPermission();
    if (permissionGranted) {
      return await Geolocator.getCurrentPosition();
    } else {
      return null;
    }
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    setDecorationGif();
    currentCoordinates = (await getCurrentLocation())!;
    latitude = currentCoordinates.latitude;
    longitude = currentCoordinates.longitude;
    myCoordinates = Coordinates(latitude, longitude);

    params.madhab = Madhab.shafi;
    prayerTimes.value = PrayerTimes.today(myCoordinates, params);
    Future.delayed(Duration(seconds: 3));
    isLoading.value = false;
    printTimings();
  }

  void setSelectedMethod(String methodName) {
    selectedMethod.value = methodName;
    methodKey = prayerMethods[methodName]!;
    params = methodKey.getParameters();
    print('Selected Method: $methodKey');
  }

  void setSelectedMadhab(String madhabName) {
    selectedMadhab.value = madhabName;
    madhabKey = madhabs[madhabName]!;
    params.madhab = madhabKey;
    print('Selected Madhab: $madhabName');
  }

  void setDecorationGif() {
    if (DateFormat.jm().format(DateTime.now()).split(' ').last.toLowerCase() ==
        'am') {
      if (int.parse(DateFormat.jm().format(DateTime.now()).split(':').first) <
          3) {
        decorationGif.value = 'assets/images/isha.gif';
      } else if ((int.parse(
                  DateFormat.jm().format(DateTime.now()).split(':').first) >=
              3) &&
          (int.parse(DateFormat.jm().format(DateTime.now()).split(':').first) <
              6)) {
        decorationGif.value = 'assets/images/subh.gif';
      } else {
        decorationGif.value = 'assets/images/luhr.gif';
      }
    } else {
      if (int.parse(DateFormat.jm().format(DateTime.now()).split(':').first) <
          3) {
        decorationGif.value = 'assets/images/luhr.gif';
      } else if ((int.parse(
                  DateFormat.jm().format(DateTime.now()).split(':').first) >=
              3) &&
          (int.parse(DateFormat.jm().format(DateTime.now()).split(':').first) <
              5)) {
        decorationGif.value = 'assets/images/asr.gif';
      } else if ((int.parse(
                  DateFormat.jm().format(DateTime.now()).split(':').first) >=
              5) &&
          (int.parse(DateFormat.jm().format(DateTime.now()).split(':').first) <
              7)) {
        decorationGif.value = 'assets/images/magrib.gif';
      } else {
        decorationGif.value = 'assets/images/isha.gif';
      }
    }
  }

  printTimings() {
    print(
        "---Today's Prayer Times in Your Local Timezone(${prayerTimes.value?.fajr.timeZoneName})---");
    print(DateFormat.jm().format(prayerTimes.value!.fajr));
    print(DateFormat.jm().format(prayerTimes.value!.sunrise));
    print(DateFormat.jm().format(prayerTimes.value!.dhuhr));
    print(DateFormat.jm().format(prayerTimes.value!.asr));
    print(DateFormat.jm().format(prayerTimes.value!.maghrib));
    print(DateFormat.jm().format(prayerTimes.value!.isha));

    print('Current Time :: ${DateFormat.jm().format(DateTime.now())}');
    print('Current Prayer :: ${prayerTimes.value!.currentPrayer().name}');
  }
}
