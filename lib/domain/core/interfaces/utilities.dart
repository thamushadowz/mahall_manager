import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class Utilities {
  static RxString mahallName = "".obs;
  static final List<Map<String, String>> languages = [
    {'name': 'English', 'code': 'en'},
    {'name': 'മലയാളം', 'code': 'ml'},
  ];

  static List<String> getGenderList(BuildContext context) {
    return [
      AppLocalizations.of(context)!.male,
      AppLocalizations.of(context)!.female,
      AppLocalizations.of(context)!.others,
    ];
  }

  static List<String> getBloodList(BuildContext context) {
    return [
      AppLocalizations.of(context)!.a_pos,
      AppLocalizations.of(context)!.a_neg,
      AppLocalizations.of(context)!.b_pos,
      AppLocalizations.of(context)!.b_neg,
      AppLocalizations.of(context)!.ab_pos,
      AppLocalizations.of(context)!.ab_neg,
      AppLocalizations.of(context)!.o_pos,
      AppLocalizations.of(context)!.o_neg,
      AppLocalizations.of(context)!.others,
    ];
  }

  static List<String> getIncomeList(BuildContext context) {
    return [
      AppLocalizations.of(context)!.below_lakh,
      AppLocalizations.of(context)!.one_to_two_nine_lakh,
      AppLocalizations.of(context)!.three_to_four_nine_lakh,
      AppLocalizations.of(context)!.five_to_six_nine_lakh,
      AppLocalizations.of(context)!.seven_to_eight_nine_lakh,
      AppLocalizations.of(context)!.nine_to_nine_nine_lakh,
      AppLocalizations.of(context)!.above_ten_lakh,
    ];
  }

  static List<String> getDistrictList(BuildContext context) {
    return [
      AppLocalizations.of(context)!.alappuzha,
      AppLocalizations.of(context)!.ernakulam,
      AppLocalizations.of(context)!.idukki,
      AppLocalizations.of(context)!.kannur,
      AppLocalizations.of(context)!.kasaragod,
      AppLocalizations.of(context)!.kollam,
      AppLocalizations.of(context)!.kottayam,
      AppLocalizations.of(context)!.kozhikode,
      AppLocalizations.of(context)!.malappuram,
      AppLocalizations.of(context)!.palakkad,
      AppLocalizations.of(context)!.pathanamthitta,
      AppLocalizations.of(context)!.thiruvananthapuram,
      AppLocalizations.of(context)!.thrissur,
      AppLocalizations.of(context)!.wayanad,
    ];
  }

  static List<String> getStateList(BuildContext context) {
    return [
      'Kerala',
    ];
  }

  static List<String> getCountryList(BuildContext context) {
    return [
      'Saudi Arabia',
      'Oman',
      'Qatar',
      'Dubai',
      'USA',
      'UK',
      'Germany',
      'Australia',
      'New Zealand'
    ];
  }
}
