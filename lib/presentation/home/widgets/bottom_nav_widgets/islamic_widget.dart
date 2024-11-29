import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mahall_manager/infrastructure/theme/colors/app_colors.dart';
import 'package:mahall_manager/presentation/common_widgets/common_text_widget.dart';
import 'package:mahall_manager/presentation/home/controllers/home.controller.dart';

class IslamicWidget extends StatelessWidget {
  const IslamicWidget({super.key, required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/dark_background.png'),
              fit: BoxFit.cover)),
      padding: const EdgeInsets.all(20.0),
      child: _buildClickableIconsGridView(),
    );
  }

  _buildClickableIconsGridView() {
    return SizedBox(
      width: MediaQuery.of(Get.context!).size.width,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 4,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Get.toNamed(controller.islamicGrid[index]['onClick']);
            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      controller.islamicGrid[index]['icon'],
                      width: 40,
                      height: 40,
                      color: AppColors.themeColor,
                    ),
                    const SizedBox(height: 10),
                    CommonTextWidget(
                      text: controller.islamicGrid[index]['title'],
                      fontSize: 10,
                      color: AppColors.themeColor,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          childAspectRatio: 1,
        ),
      ),
    );
  }
}
