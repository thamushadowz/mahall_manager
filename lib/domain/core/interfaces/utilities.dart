import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mahall_manager/domain/listing/models/id_name_model.dart';

import '../../../infrastructure/theme/strings/app_strings.dart';

class Utilities {
  static final List<Map<String, String>> languages = [
    {'name': 'English', 'code': 'en'},
    {'name': 'മലയാളം', 'code': 'ml'},
  ];

  static List<String> getGenderList(BuildContext context) {
    return [
      AppStrings.male,
      AppStrings.female,
      AppStrings.others,
    ];
  }

  static List<String> getBloodList(BuildContext context) {
    return [
      AppStrings.apos,
      AppStrings.aneg,
      AppStrings.bpos,
      AppStrings.bneg,
      AppStrings.abpos,
      AppStrings.abneg,
      AppStrings.opos,
      AppStrings.oneg,
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

  static List<IdNameModel> getDistrictList(BuildContext context, int stateId) {
    if (stateId == 1) {
      return [
        IdNameModel(
            id: 1, name: AppLocalizations.of(context)!.thiruvananthapuram),
        IdNameModel(id: 2, name: AppLocalizations.of(context)!.kollam),
        IdNameModel(id: 3, name: AppLocalizations.of(context)!.pathanamthitta),
        IdNameModel(id: 4, name: AppLocalizations.of(context)!.alappuzha),
        IdNameModel(id: 5, name: AppLocalizations.of(context)!.kottayam),
        IdNameModel(id: 6, name: AppLocalizations.of(context)!.idukki),
        IdNameModel(id: 7, name: AppLocalizations.of(context)!.ernakulam),
        IdNameModel(id: 8, name: AppLocalizations.of(context)!.thrissur),
        IdNameModel(id: 9, name: AppLocalizations.of(context)!.palakkad),
        IdNameModel(id: 10, name: AppLocalizations.of(context)!.malappuram),
        IdNameModel(id: 11, name: AppLocalizations.of(context)!.kozhikode),
        IdNameModel(id: 12, name: AppLocalizations.of(context)!.wayanad),
        IdNameModel(id: 13, name: AppLocalizations.of(context)!.kannur),
        IdNameModel(id: 14, name: AppLocalizations.of(context)!.kasaragod),
      ];
    } else if (stateId == 2) {
      return [
        IdNameModel(id: 1, name: 'Bagalkot'),
        IdNameModel(id: 2, name: 'Ballari'),
        IdNameModel(id: 3, name: 'Belagavi'),
        IdNameModel(id: 4, name: 'Bengaluru Rural'),
        IdNameModel(id: 5, name: 'Bengaluru Urban'),
        IdNameModel(id: 6, name: 'Bidar'),
        IdNameModel(id: 7, name: 'Chamarajanagar'),
        IdNameModel(id: 8, name: 'Chikkaballapur'),
        IdNameModel(id: 9, name: 'Chikkamagaluru'),
        IdNameModel(id: 10, name: 'Chitradurga'),
        IdNameModel(id: 11, name: 'Mangalore'),
        IdNameModel(id: 12, name: 'Davanagere'),
        IdNameModel(id: 13, name: 'Dharwad'),
        IdNameModel(id: 14, name: 'Gadag'),
        IdNameModel(id: 15, name: 'Hassan'),
        IdNameModel(id: 16, name: 'Haveri'),
        IdNameModel(id: 17, name: 'Kalaburagi'),
        IdNameModel(id: 18, name: 'Kodagu'),
        IdNameModel(id: 19, name: 'Kolar'),
        IdNameModel(id: 20, name: 'Koppal'),
        IdNameModel(id: 21, name: 'Mandya'),
        IdNameModel(id: 22, name: 'Mysuru'),
        IdNameModel(id: 23, name: 'Raichur'),
        IdNameModel(id: 24, name: 'Ramanagara'),
        IdNameModel(id: 25, name: 'Shivamogga'),
        IdNameModel(id: 26, name: 'Tumakuru'),
        IdNameModel(id: 27, name: 'Udupi'),
        IdNameModel(id: 28, name: 'Karwar'),
        IdNameModel(id: 29, name: 'Vijayapura'),
        IdNameModel(id: 30, name: 'Yadgir')
      ];
    } else if (stateId == 3) {
      return [
        IdNameModel(id: 1, name: 'Ariyalur'),
        IdNameModel(id: 2, name: 'Chengalpattu'),
        IdNameModel(id: 3, name: 'Chennai'),
        IdNameModel(id: 4, name: 'Coimbatore'),
        IdNameModel(id: 5, name: 'Cuddalore'),
        IdNameModel(id: 6, name: 'Dharmapuri'),
        IdNameModel(id: 7, name: 'Dindigul'),
        IdNameModel(id: 8, name: 'Erode'),
        IdNameModel(id: 9, name: 'Kallakurichi'),
        IdNameModel(id: 10, name: 'Kancheepuram'),
        IdNameModel(id: 11, name: 'Karur'),
        IdNameModel(id: 12, name: 'Krishnagiri'),
        IdNameModel(id: 13, name: 'Madurai'),
        IdNameModel(id: 14, name: 'Mayiladuthurai'),
        IdNameModel(id: 15, name: 'Nagapattinam'),
        IdNameModel(id: 16, name: 'Namakkal'),
        IdNameModel(id: 17, name: 'Nilgiris'),
        IdNameModel(id: 18, name: 'Perambalur'),
        IdNameModel(id: 19, name: 'Pudukkottai'),
        IdNameModel(id: 20, name: 'Ramanathapuram'),
        IdNameModel(id: 21, name: 'Ranipet'),
        IdNameModel(id: 22, name: 'Salem'),
        IdNameModel(id: 23, name: 'Sivaganga'),
        IdNameModel(id: 24, name: 'Tenkasi'),
        IdNameModel(id: 25, name: 'Thanjavur'),
        IdNameModel(id: 26, name: 'Theni'),
        IdNameModel(id: 27, name: 'Thiruvallur'),
        IdNameModel(id: 28, name: 'Thiruvarur'),
        IdNameModel(id: 29, name: 'Tuticorin'),
        IdNameModel(id: 30, name: 'Tiruchirappalli'),
        IdNameModel(id: 31, name: 'Tirunelveli'),
        IdNameModel(id: 32, name: 'Tirupathur'),
        IdNameModel(id: 33, name: 'Tiruppur'),
        IdNameModel(id: 34, name: 'Tiruvannamalai'),
        IdNameModel(id: 35, name: 'Vellore'),
        IdNameModel(id: 36, name: 'Viluppuram'),
        IdNameModel(id: 37, name: 'Virudhunagar'),
      ];
    } else {
      return [];
    }
  }

  static List<IdNameModel> getStateList(BuildContext context) {
    return [
      IdNameModel(id: 1, name: AppStrings.kerala),
      IdNameModel(id: 2, name: AppStrings.karnataka),
      IdNameModel(id: 3, name: AppStrings.tamilNadu),
    ];
  }

  static List<IdNameModel> getCountryList(BuildContext context) {
    return [
      IdNameModel(id: 1, name: "United Arab Emirates (UAE)"),
      IdNameModel(id: 2, name: "Saudi Arabia"),
      IdNameModel(id: 3, name: "United States"),
      IdNameModel(id: 4, name: "Canada"),
      IdNameModel(id: 5, name: "United Kingdom"),
      IdNameModel(id: 6, name: "Australia"),
      IdNameModel(id: 7, name: "Qatar"),
      IdNameModel(id: 8, name: "Oman"),
      IdNameModel(id: 9, name: "Kuwait"),
      IdNameModel(id: 10, name: "Singapore"),
      IdNameModel(id: 11, name: "Malaysia"),
      IdNameModel(id: 12, name: "Germany"),
      IdNameModel(id: 13, name: "New Zealand"),
      IdNameModel(id: 14, name: "Bahrain"),
      IdNameModel(id: 15, name: "South Africa"),
      IdNameModel(id: 16, name: "Italy"),
      IdNameModel(id: 17, name: "Japan"),
      IdNameModel(id: 18, name: "France"),
      IdNameModel(id: 19, name: "South Korea"),
      IdNameModel(id: 20, name: "Netherlands"),
    ];
  }
}
