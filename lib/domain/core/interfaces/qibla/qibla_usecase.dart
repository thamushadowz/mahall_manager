import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:mahall_manager/domain/core/interfaces/qibla/qibla_repository.dart';

class QiblaUseCase {
  final QiblaRepository repository;

  QiblaUseCase(this.repository);

  Stream<QiblahDirection> getQiblaDirection() {
    return repository.getQiblaDirection();
  }

  Future<bool> checkLocationPermission() async {
    return await repository.checkLocationPermission();
  }
}
