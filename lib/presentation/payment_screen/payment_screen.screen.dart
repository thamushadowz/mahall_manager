import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mahall_manager/domain/core/interfaces/common_alert.dart';
import 'package:mahall_manager/infrastructure/theme/colors/app_colors.dart';
import 'package:mahall_manager/infrastructure/theme/measures/app_measures.dart';
import 'package:mahall_manager/presentation/common_widgets/common_button_widget.dart';
import 'package:mahall_manager/presentation/common_widgets/common_text_form_field.dart';
import 'package:mahall_manager/presentation/common_widgets/common_text_widget.dart';

import '../../domain/core/interfaces/validator.dart';
import '../../infrastructure/theme/strings/app_strings.dart';
import '../common_widgets/common_appbar_widget.dart';
import 'controllers/payment_screen.controller.dart';

class PaymentScreenScreen extends GetView<PaymentScreenController> {
  const PaymentScreenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        appBar: CommonAppbarWidget(title: AppStrings.paymentDetails),
        body: Obx(() => controller.paymentSuccess.value
            ? _buildSuccessWidget(context)
            : _buildMainWidget(context)));
  }

  _buildSuccessWidget(BuildContext context) {
    return RepaintBoundary(
      key: controller.screenshotKey,
      child: Stack(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              height: controller.totalOrNot
                  ? MediaQuery.of(context).size.height * 0.6
                  : MediaQuery.of(context).size.height * 0.5,
              color: AppColors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset('assets/animations/success.json',
                      width: 220, height: 220),
                  CommonTextWidget(
                    text: AppStrings.paymentSuccess,
                    fontSize: 25,
                    color: AppColors.themeColor,
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                ),
                color: AppColors.themeColor,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CommonTextWidget(
                    text: AppStrings.paymentDetails,
                    color: AppColors.white,
                  ),
                  const Divider(height: 25),
                  controller.args['promises'] != null
                      ? _buildPromisesPaymentSuccessDetailsWidget()
                      : _buildUserPaymentSuccessDetailsWidget(),
                  _buildDataRow(
                      color: AppColors.white,
                      label: '${AppStrings.date} : ',
                      text: controller.fetchFormattedDate()),
                  const Divider(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          controller.takeScreenshotAndShare(
                              controller.house.phone ?? '',
                              controller.totalOrNot
                                  ? '${controller.house.houseName}'
                                  : '${controller.house.fName} ${controller.house.lName}');
                        },
                        icon: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(60),
                              border: Border.all(color: AppColors.white)),
                          child: Icon(
                            Icons.share_outlined,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildUserPaymentSuccessDetailsWidget() {
    return Column(
      children: [
        _buildDataRow(
            color: AppColors.white,
            label: '${AppStrings.referenceNo} : ',
            text: controller.referenceNo),
        const Divider(height: 20),
        controller.totalOrNot
            ? const SizedBox()
            : _buildDataRow(
                color: AppColors.white,
                label: '${AppStrings.name} : ',
                text:
                    '${controller.house.userRegNo} - ${controller.house.fName} ${controller.house.lName}'),
        controller.totalOrNot ? const SizedBox() : const Divider(height: 20),
        _buildDataRow(
            color: AppColors.white,
            label: '${AppStrings.houseName} : ',
            text:
                '${controller.house.houseRegNo} - ${controller.house.houseName}'),
        const Divider(height: 20),
        _buildDataRow(
            color: AppColors.white,
            label: '${AppStrings.paidAmount} : ',
            text: '₹ ${controller.textController.text}'),
        const Divider(height: 20),
        controller.totalOrNot
            ? const SizedBox()
            : _buildDataRow(
                color: AppColors.white,
                label: '${AppStrings.currentDue} : ',
                text:
                    '₹ ${int.parse(controller.house.due ?? '') - int.parse(controller.textController.text)}'),
        controller.totalOrNot ? const SizedBox() : const Divider(height: 20),
      ],
    );
  }

  _buildPromisesPaymentSuccessDetailsWidget() {
    return Column(
      children: [
        _buildDataRow(
            color: AppColors.white,
            label: '${AppStrings.referenceNo} : ',
            text: controller.referenceNo),
        const Divider(height: 20),
        _buildDataRow(
            color: AppColors.white,
            label: '${AppStrings.description} : ',
            text: '${controller.promises.description}'),
        const Divider(height: 20),
        _buildDataRow(
            color: AppColors.white,
            label: '${AppStrings.promisedDate} : ',
            text: '${controller.promises.date}'),
        const Divider(height: 20),
        _buildDataRow(
            color: AppColors.white,
            label: '${AppStrings.paidAmount} : ',
            text: '₹ ${controller.promises.amount}'),
        const Divider(height: 20),
      ],
    );
  }

  _buildMainWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Material(
        elevation: 10,
        borderRadius: BorderRadius.circular(20),
        color: AppColors.white,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: controller.formKey,
            child: controller.args['promises'] != null
                ? _buildPromisePaymentWidget(context)
                : _buildUserPaymentWidget(context),
          ),
        ),
      ),
    );
  }

  Column _buildUserPaymentWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        controller.totalOrNot
            ? const SizedBox()
            : _buildDataRow(
                color: AppColors.black,
                label: '${AppStrings.name} : ',
                text:
                    '${controller.house.userRegNo} - ${controller.house.fName} ${controller.house.lName}'),
        controller.totalOrNot ? const SizedBox() : const Divider(height: 25),
        _buildDataRow(
            color: AppColors.black,
            label: '${AppStrings.houseName} : ',
            text:
                '${controller.house.houseRegNo} - ${controller.house.houseName}'),
        const Divider(height: 25),
        _buildDataRow(
            color: AppColors.black,
            label: '${AppStrings.currentDue} : ',
            text:
                '₹ ${controller.totalOrNot ? controller.house.totalDue : controller.house.due}'),
        const Divider(height: 25),
        _buildDataRow(
            color: AppColors.black,
            label: '${AppStrings.date} : ',
            text: controller.fetchFormattedDate()),
        const Divider(height: 25),
        controller.totalOrNot
            ? const SizedBox()
            : CommonTextFormField(
                label: AppStrings.enterCustomAmount,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                keyboardType: TextInputType.number,
                prefixText: '₹ ',
                validator: Validators.validateAmount,
                textController: controller.textController,
              ),
        const SizedBox(height: 20),
        CommonButtonWidget(
          onTap: () {
            if (controller.formKey.currentState!.validate()) {
              showCommonDialog(context,
                  message: AppStrings.areYouSureToPay,
                  yesButtonName: AppStrings.payNow,
                  messageColor: AppColors.darkRed, onYesTap: () {
                controller.paymentSuccess.value = true;
                Get.close(0);
              });
            }
          },
          label: AppStrings.payNow,
          isLoading: false.obs,
        )
      ],
    );
  }

  Column _buildPromisePaymentWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildDataRow(
            color: AppColors.black,
            label: '${AppStrings.description} : ',
            text: controller.promises.description ?? ''),
        const Divider(height: 25),
        _buildDataRow(
            color: AppColors.black,
            label: '${AppStrings.date} : ',
            text: controller.promises.date ?? ''),
        const Divider(height: 25),
        _buildDataRow(
            color: AppColors.black,
            label: '${AppStrings.amount} : ',
            text: '₹ ${controller.promises.amount}'),
        const Divider(height: 25),
        CommonButtonWidget(
          onTap: () {
            if (controller.formKey.currentState!.validate()) {
              showCommonDialog(context,
                  message: AppStrings.areYouSureToPay,
                  yesButtonName: AppStrings.payNow,
                  messageColor: AppColors.darkRed, onYesTap: () {
                controller.paymentSuccess.value = true;
                Get.close(0);
              });
            }
          },
          label: AppStrings.payNow,
          isLoading: false.obs,
        )
      ],
    );
  }

  _buildDataRow(
      {required String label, required String text, required Color color}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CommonTextWidget(
          color: color,
          text: label,
          fontSize: AppMeasures.normalTextSize,
          fontWeight: AppMeasures.mediumWeight,
        ),
        Expanded(
          child: CommonTextWidget(
            color: color,
            text: text,
            textAlign: TextAlign.end,
            fontSize: AppMeasures.normalTextSize,
            fontWeight: AppMeasures.mediumWeight,
          ),
        ),
      ],
    );
  }
}
