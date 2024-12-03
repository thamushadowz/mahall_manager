import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mahall_manager/infrastructure/theme/colors/app_colors.dart';
import 'package:mahall_manager/presentation/common_widgets/common_appbar_widget.dart';

import '../../domain/core/interfaces/validator.dart';
import '../../infrastructure/theme/strings/app_strings.dart';
import '../common_widgets/common_button_widget.dart';
import '../common_widgets/common_text_form_field.dart';
import '../common_widgets/common_text_widget.dart';
import 'controllers/announcement.controller.dart';

class AnnouncementScreen extends GetView<AnnouncementController> {
  const AnnouncementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CommonAppbarWidget(
          title: AppStrings.announcementManager,
        ),
        body: SizedBox.expand(
          child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/dark_background.png'),
                    fit: BoxFit.cover)),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

                return SingleChildScrollView(
                  padding: EdgeInsets.only(
                    top: keyboardHeight == 0 ? constraints.maxHeight * 0.2 : 20,
                    bottom: 20,
                  ),
                  child: Column(
                    mainAxisAlignment: keyboardHeight == 0
                        ? MainAxisAlignment.center
                        : MainAxisAlignment.start,
                    children: [
                      _buildAnnouncementWidget(),
                      const SizedBox(height: 20),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Padding _buildAnnouncementWidget() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Material(
        color: AppColors.white.withOpacity(0.8),
        elevation: 10,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CommonTextWidget(text: AppStrings.announcementManager),
                const SizedBox(height: 10),
                CommonTextFormField(
                  fillColor: AppColors.white.withOpacity(0.6),
                  textController: controller.announcementController,
                  minLines: 3,
                  maxLines: 30,
                  hint: AppStrings.typeHere,
                  keyboardType: TextInputType.multiline,
                  validator: Validators.validateAnnouncement,
                  suffixIcon: Icons.delete_sweep_outlined,
                  onSuffixTap: () {
                    controller.announcementController.clear();
                  },
                ),
                const SizedBox(height: 10),
                CommonButtonWidget(
                  onTap: () {
                    if (controller.formKey.currentState!.validate()) {
                      controller.sendNotification();
                    }
                  },
                  label: AppStrings.submit,
                  isLoading: false.obs,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
