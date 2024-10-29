import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mahall_manager/presentation/home/widgets/drawer_widget.dart';
import 'package:mahall_manager/presentation/home/widgets/pie_chart_widget.dart';

import '../common_widgets/common_appbar_widget.dart';
import 'controllers/home.controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          final now = DateTime.now();
          if (controller.lastPressedAt == null ||
              now.difference(controller.lastPressedAt!) >
                  const Duration(seconds: 2)) {
            controller.lastPressedAt = now;
            Get.showSnackbar(
              const GetSnackBar(
                snackPosition: SnackPosition.TOP,
                message: 'Press back again to exit',
                duration: Duration(seconds: 2),
              ),
            );
            return false;
          }
          return true;
        },
        child: Scaffold(
          drawer: DrawerWidget(controller: controller),
          appBar: const CommonAppbarWidget(
            title: 'Home',
          ),
          body: Center(
            child: SizedBox(
              width: 250,
              height: 250,
              child: PieChartWidget(
                controller: controller,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
