import 'dart:async';

import 'package:adhan/adhan.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';

import '../../../domain/core/interfaces/utility_services.dart';

class PrayerTimeController extends GetxController {
  //final AudioPlayer _audioPlayer = AudioPlayer();

  RxString selectedMethod = ''.obs;
  RxString selectedMadhab = ''.obs;
  RxString decorationGif = ''.obs;
  RxString hijriDate = ''.obs;
  RxString nextPrayerName = ''.obs;

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
  Rx<Duration> timeRemaining = const Duration().obs;
  late Timer _timer;

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
    getHijriDate();
    setDecorationGif();
    currentCoordinates = (await getCurrentLocation())!;
    latitude = currentCoordinates.latitude;
    longitude = currentCoordinates.longitude;
    myCoordinates = Coordinates(latitude, longitude);

    params.madhab = Madhab.shafi;
    prayerTimes.value = PrayerTimes.today(myCoordinates, params);
    Future.delayed(const Duration(seconds: 3));
    isLoading.value = false;
    nextPrayerName.value = prayerTimes.value!.nextPrayer().name;
    _updateCountdown();
  }

  @override
  void onClose() {
    //_audioPlayer.dispose();
    _timer.cancel();
    super.onClose();
  }

/*  Future<void> playAzan(Prayer prayer) async {
    if (prayer == Prayer.fajr && isSubhAlarmOn.value ||
        prayer == Prayer.dhuhr && isLuhrAlarmOn.value ||
        prayer == Prayer.asr && isAsrAlarmOn.value ||
        prayer == Prayer.maghrib && isMagribAlarmOn.value ||
        prayer == Prayer.isha && isIshaAlarmOn.value) {
      await _audioPlayer.play(AssetSource('audios/azaan.mp3'));
    }
  }*/

  void _updateCountdown() {
    Prayer? nextPrayer = prayerTimes.value?.nextPrayer();
    DateTime? nextPrayerTime = prayerTimes.value?.timeForPrayer(nextPrayer!);
    /*DateTime now = DateTime.now();
    DateTime? nextPrayerTime = now.add(Duration(seconds: 5));*/

    if (nextPrayer == Prayer.isha) {
      DateTime now = DateTime.now();
      DateTime tomorrow = now.add(const Duration(days: 1));
      nextPrayer = Prayer.fajr;
      nextPrayerTime = prayerTimes.value?.timeForPrayer(nextPrayer)!.add(
            Duration(
              days: tomorrow.day - now.day,
            ),
          );
    }

    timeRemaining.value = nextPrayerTime!.difference(DateTime.now());

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      timeRemaining.value = nextPrayerTime!.difference(DateTime.now());
      if (timeRemaining.value.isNegative) {
        _timer.cancel();
        //await playAzan(nextPrayer!);
        nextPrayerName.value = prayerTimes.value!.nextPrayer().name;
        _updateCountdown();
      }
    });
  }

  String capitalizeFirstLetter(String str) {
    if (str.isEmpty) return str;
    return str[0].toUpperCase() + str.substring(1);
  }

  getHijriDate() {
    final date = HijriCalendar.now();
    hijriDate.value = '${date.hDay} ${date.longMonthName} ${date.hYear}';
  }

  void setSelectedMethod(String methodName) {
    selectedMethod.value = methodName;
    methodKey = prayerMethods[methodName]!;
    params = methodKey.getParameters();
  }

  void setSelectedMadhab(String madhabName) {
    selectedMadhab.value = madhabName;
    madhabKey = madhabs[madhabName]!;
    params.madhab = madhabKey;
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
      if ((int.parse(DateFormat.jm().format(DateTime.now()).split(':').first) ==
              12) ||
          (int.parse(DateFormat.jm().format(DateTime.now()).split(':').first) <
              3)) {
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
}
