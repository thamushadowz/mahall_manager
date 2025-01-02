import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mahall_manager/domain/core/interfaces/validator.dart';
import 'package:mahall_manager/infrastructure/theme/colors/app_colors.dart';
import 'package:mahall_manager/infrastructure/theme/measures/app_measures.dart';
import 'package:mahall_manager/presentation/common_widgets/common_appbar_widget.dart';
import 'package:mahall_manager/presentation/common_widgets/common_button_widget.dart';
import 'package:mahall_manager/presentation/common_widgets/common_clickable_text_widget.dart';
import 'package:mahall_manager/presentation/common_widgets/common_text_field_shimmer_widget.dart';
import 'package:mahall_manager/presentation/common_widgets/common_text_form_field.dart';
import 'package:mahall_manager/presentation/common_widgets/common_text_widget.dart';

import '../../infrastructure/theme/strings/app_strings.dart';
import 'controllers/committee_details.controller.dart';

class CommitteeDetailsScreen extends GetView<CommitteeDetailsController> {
  const CommitteeDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: CommonAppbarWidget(
          title: AppStrings.committeeDetails,
          actions: [
            controller.userType == '2'
                ? const SizedBox.shrink()
                : IconButton(
                    onPressed: () {
                      _showAddCommitteeDialog(context);
                    },
                    icon: const Icon(Icons.add),
                  ),
            const SizedBox(width: 10),
          ],
        ),
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/dark_background.png'),
                  fit: BoxFit.cover)),
          child: _buildCommitteeList(),
        ),
      ),
    );
  }

  Widget _buildCommitteeList() {
    return Column(
      children: [
        // Committee List
        Expanded(
          child: Obx(
            () => controller.isDataLoading.value
                ? ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return const Card(
                        color: Colors.transparent,
                        elevation: 3,
                        margin: EdgeInsets.symmetric(vertical: 6),
                        child: CommonTextFieldShimmerWidget(
                          height: 100,
                        ),
                      );
                    },
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: controller.committeeList.length,
                    itemBuilder: (context, index) {
                      final member = controller.committeeList[index];
                      return Card(
                        color: Colors.transparent,
                        elevation: 3,
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.white.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: AppColors.blueGrey.withOpacity(0.5)),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.grey.withOpacity(0.2),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ListTile(
                            title: Align(
                              alignment: Alignment.center,
                              child: CommonTextWidget(
                                text: member.designation ?? '',
                                fontSize: AppMeasures.bigTextSize,
                              ),
                            ),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 35,
                                  backgroundColor: AppColors.black,
                                  child: Image.asset(
                                    'assets/logo/Mahall_manager_trans_logo.png',
                                  ),
                                ),
                                const SizedBox(width: 20),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CommonTextWidget(
                                        text: member.name ?? '',
                                        fontSize: AppMeasures.normalTextSize,
                                        fontWeight: AppMeasures.mediumWeight,
                                      ),
                                      CommonClickableTextWidget(
                                        title: '+91 ${member.phone}',
                                        fontSize: AppMeasures.normalTextSize,
                                        fontWeight: AppMeasures.mediumWeight,
                                        textColor: AppColors.blue,
                                        onTap: () {
                                          _generateBottomSheet(
                                              member.phone ?? '');
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                controller.userType == '2'
                                    ? const SizedBox.shrink()
                                    : IconButton(
                                        onPressed: () {
                                          controller.designationController
                                              .text = member.designation ?? '';
                                          controller.nameController.text =
                                              member.name ?? '';
                                          controller.mobileController.text =
                                              member.phone ?? '';
                                          _showAddCommitteeDialog(context,
                                              id: member.id!.toInt());
                                        },
                                        icon: const Icon(
                                          Icons.edit_note,
                                          size: 20,
                                        )),
                                controller.userType == '2'
                                    ? const SizedBox.shrink()
                                    : IconButton(
                                        onPressed: () {
                                          controller.deleteCommitteeDetails(
                                              member.id!.toInt());
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: AppColors.darkRed,
                                          size: 20,
                                        )),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ),
      ],
    );
  }

  void _showAddCommitteeDialog(BuildContext context, {int? id}) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CommonTextFormField(
                  textController: controller.designationController,
                  focusNode: controller.designationFocusNode,
                  label: AppStrings.designation,
                  suffixIcon: Icons.person,
                  onFieldSubmitted: (value) {
                    FocusScope.of(context)
                        .requestFocus(controller.nameFocusNode);
                  },
                  validator: Validators.required,
                ),
                const SizedBox(height: 10),
                CommonTextFormField(
                    textController: controller.nameController,
                    focusNode: controller.nameFocusNode,
                    label: AppStrings.name,
                    suffixIcon: Icons.abc_rounded,
                    onFieldSubmitted: (value) {
                      FocusScope.of(context)
                          .requestFocus(controller.mobileFocusNode);
                    },
                    validator: Validators.required),
                const SizedBox(height: 10),
                CommonTextFormField(
                    textController: controller.mobileController,
                    focusNode: controller.mobileFocusNode,
                    label: AppStrings.mobileNo,
                    suffixIcon: Icons.phone_iphone_rounded,
                    prefixText: '+91 ',
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    keyboardType: TextInputType.number,
                    validator: Validators.required),
                const SizedBox(height: 20),
                CommonButtonWidget(
                  onTap: () {
                    if (controller.formKey.currentState!.validate()) {
                      if (id == null) {
                        controller.addCommitteeDetails();
                      } else {
                        controller.updateCommitteeDetails(id);
                      }
                      Get.back();
                    }
                  },
                  label: AppStrings.submit,
                  isLoading: controller.isLoading,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _generateBottomSheet(String number) {
    Get.bottomSheet(
      backgroundColor: AppColors.white.withOpacity(0.8),
      SizedBox(
        height: 140,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _generateContactButton(
              title: AppStrings.call,
              onTap: () {
                controller.launchDialer(number);
              },
              icon: 'assets/images/call_icon.png',
            ),
            _generateContactButton(
              title: AppStrings.whatsapp,
              onTap: () {
                controller.launchWhatsApp(number);
              },
              icon: 'assets/images/whatsapp_icon.png',
            ),
          ],
        ),
      ),
    );
  }

  Widget _generateContactButton({
    required String title,
    required Function() onTap,
    required String icon,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(50),
          onTap: onTap,
          radius: 40,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.lightGrey.withOpacity(0.3),
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: AppColors.blueGrey),
            ),
            child: Image.asset(
              icon,
              height: 40,
              width: 40,
            ),
          ),
        ),
        const SizedBox(height: 8),
        CommonTextWidget(
          text: title,
          fontSize: AppMeasures.smallTextSize,
          fontWeight: FontWeight.w500,
          color: AppColors.black,
        ),
      ],
    );
  }
}
