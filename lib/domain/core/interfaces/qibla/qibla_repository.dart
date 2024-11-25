import 'package:flutter_qiblah/flutter_qiblah.dart';

class QiblaRepository {
  Stream<QiblahDirection> getQiblaDirection() {
    return FlutterQiblah.qiblahStream;
  }

  Future<bool> checkLocationPermission() async {
    return await FlutterQiblah.androidDeviceSensorSupport() != null;
  }
}
