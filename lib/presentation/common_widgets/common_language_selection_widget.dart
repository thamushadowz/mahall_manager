import 'package:flutter/material.dart';
import 'package:mahall_manager/infrastructure/theme/colors/app_colors.dart';

import '../../domain/core/interfaces/utilities.dart';
import '../../infrastructure/theme/measures/app_measures.dart';

class CommonLanguageSelectionWidget extends StatelessWidget {
  const CommonLanguageSelectionWidget(
      {super.key, required this.selectedLanguage, required this.onChanged});

  final String selectedLanguage;
  final Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.grey),
      ),
      child: DropdownButton(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        underline: const SizedBox(),
        icon: const Icon(Icons.language),
        value: selectedLanguage,
        onChanged: onChanged,
        items: Utilities.languages.map<DropdownMenuItem<String>>(
          (Map<String, String> language) {
            return DropdownMenuItem<String>(
              value: language['name'],
              child: Text(
                language['name']!,
                style: TextStyle(
                    fontSize: AppMeasures.mediumTextSize,
                    fontWeight: AppMeasures.mediumWeight),
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
