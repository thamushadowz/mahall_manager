import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mahall_manager/infrastructure/navigation/routes.dart';
import 'package:mahall_manager/infrastructure/theme/colors/app_colors.dart';
import 'package:mahall_manager/infrastructure/theme/strings/app_strings.dart';
import 'package:mahall_manager/presentation/common_widgets/common_appbar_widget.dart';
import 'package:mahall_manager/presentation/common_widgets/common_text_widget.dart';

import 'controllers/duas.controller.dart';

class DuasScreen extends GetView<DuasController> {
  const DuasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbarWidget(title: AppStrings.duas),
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/dark_background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Obx(
          () {
            if (controller.duas.isEmpty) {
              return Center(
                child: CommonTextWidget(
                  text: "No Duas Available",
                  fontSize: 18,
                  color: AppColors.white.withOpacity(0.8),
                ),
              );
            }
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              itemCount: controller.duas.length,
              itemBuilder: (context, index) {
                final dua = controller.duas[index];
                return GestureDetector(
                  onTap: () {
                    Get.toNamed(
                      Routes.VIEW_NOTIFICATION,
                      arguments: {'dua': dua},
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(
                        colors: [
                          AppColors.grey.withOpacity(0.7),
                          AppColors.black.withOpacity(0.9),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.black.withOpacity(0.6),
                          offset: const Offset(2, 4),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonTextWidget(
                                text: dua.title.toString(),
                                fontSize: 16,
                                color: AppColors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.arrow_forward_rounded,
                          color: AppColors.white.withOpacity(0.8),
                          size: 25,
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
