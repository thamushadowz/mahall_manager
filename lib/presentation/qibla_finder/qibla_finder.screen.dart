import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:get/get.dart';

import 'controllers/qibla_finder.controller.dart';

class QiblaFinderScreen extends GetView<QiblaFinderController> {
  const QiblaFinderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 48, 48, 48),
        body: StreamBuilder(
          stream: FlutterQiblah.qiblahStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(
                    color: Colors.white,
                  ));
            }

            final qiblahDirection = snapshot.data;
            controller.animation = Tween(
                    begin: controller.begin,
                    end: (qiblahDirection!.qiblah * (pi / 180) * -1))
                .animate(controller.animationController!);
            controller.begin = (qiblahDirection.qiblah * (pi / 180) * -1);
            controller.animationController!.forward(from: 0);

            return Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${qiblahDirection.direction.toInt()}°",
                      style: const TextStyle(color: Colors.white, fontSize: 24),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                        height: 300,
                        child: AnimatedBuilder(
                          animation: controller.animation!,
                          builder: (context, child) => Transform.rotate(
                              angle: controller.animation!.value,
                              child: Image.asset(
                                  'assets/images/qibla_compass.png')),
                        ))
                  ]),
            );
          },
        ),
      ),
    );
  }
}
