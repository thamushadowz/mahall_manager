import 'package:adhan/adhan.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../domain/core/interfaces/utility_services.dart';

class PrayerTimeController extends GetxController {
  RxString selectedMethod = ''.obs;
  RxString selectedMadhab = ''.obs;

  CalculationMethod methodKey = CalculationMethod.karachi;
  Madhab madhabKey = Madhab.shafi;

  RxBool isSettingsClicked = false.obs;
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
    currentCoordinates = (await getCurrentLocation())!;
    latitude = currentCoordinates.latitude;
    longitude = currentCoordinates.longitude;
    myCoordinates = Coordinates(latitude, longitude);

    params.madhab = Madhab.shafi;
    prayerTimes.value = PrayerTimes.today(myCoordinates, params);
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

  printTimings() {
    print(
        "---Today's Prayer Times in Your Local Timezone(${prayerTimes.value?.fajr.timeZoneName})---");
    print(DateFormat.jm().format(prayerTimes.value!.fajr));
    print(DateFormat.jm().format(prayerTimes.value!.sunrise));
    print(DateFormat.jm().format(prayerTimes.value!.dhuhr));
    print(DateFormat.jm().format(prayerTimes.value!.asr));
    print(DateFormat.jm().format(prayerTimes.value!.maghrib));
    print(DateFormat.jm().format(prayerTimes.value!.isha));
  }
}
