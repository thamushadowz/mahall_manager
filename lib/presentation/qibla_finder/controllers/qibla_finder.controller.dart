import 'package:flutter/animation.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:get/get.dart';
import 'package:mahall_manager/domain/core/interfaces/qibla/qibla_repository.dart';

import '../../../domain/core/interfaces/qibla/qibla_usecase.dart';
import '../../../domain/core/interfaces/utility_services.dart';

class QiblaFinderController extends GetxController
    with GetTickerProviderStateMixin {
  final QiblaUseCase useCase = QiblaUseCase(QiblaRepository());

  var isPermissionGranted = false.obs;
  late Stream<QiblahDirection> qiblaStream;

  late final AnimationController? animationController;

  Animation<double>? animation;
  double begin = 0.0;
  bool isVibrated = false;

  @override
  Future<void> onInit() async {
    super.onInit();
    isPermissionGranted.value = await requestLocationPermission();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    animation = Tween(begin: 0.0, end: 0.0).animate(animationController!);
    qiblaStream = useCase.getQiblaDirection();
  }

  @override
  void onClose() {
    animationController?.dispose();
    super.onClose();
  }
}
