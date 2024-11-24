import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../config.dart';
import '../../presentation/screens.dart';
import '../../presentation/user_registration/registration.screen.dart';
import 'bindings/controllers/controllers_bindings.dart';
import 'routes.dart';

class EnvironmentsBadge extends StatelessWidget {
  final Widget child;

  const EnvironmentsBadge({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    var env = ConfigEnvironments.getEnvironments()['env'];
    return env != Environments.PRODUCTION
        ? Banner(
            location: BannerLocation.topStart,
            message: env!,
            color: env == Environments.QAS ? Colors.blue : Colors.purple,
            child: child,
          )
        : SizedBox(child: child);
  }
}

class Nav {
  static List<GetPage> routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => const SplashScreen(),
      binding: SplashControllerBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => const HomeScreen(),
      binding: HomeControllerBinding(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginScreen(),
      binding: LoginControllerBinding(),
    ),
    GetPage(
      name: Routes.REGISTRATION,
      page: () => const RegistrationScreen(),
      binding: RegistrationControllerBinding(),
    ),
    GetPage(
      name: Routes.HOUSE_REGISTRATION,
      page: () => const HouseRegistrationScreen(),
      binding: HouseRegistrationControllerBinding(),
    ),
    GetPage(
      name: Routes.COMMITTEE_REGISTRATION,
      page: () => const CommitteeRegistrationScreen(),
      binding: CommitteeRegistrationControllerBinding(),
    ),
    GetPage(
      name: Routes.RESET_PASSWORD,
      page: () => const ResetPasswordScreen(),
      binding: ResetPasswordControllerBinding(),
    ),
    GetPage(
      name: Routes.CONTACT_US,
      page: () => ContactUsScreen(),
      binding: ContactUsControllerBinding(),
    ),
    GetPage(
      name: Routes.ADD_INCOME,
      page: () => const AddIncomeScreen(),
      binding: AddIncomeControllerBinding(),
    ),
    GetPage(
      name: Routes.ADD_EXPENSES,
      page: () => const AddExpensesScreen(),
      binding: AddExpensesControllerBinding(),
    ),
    GetPage(
      name: Routes.SEARCH_SCREEN,
      page: () => const SearchScreenScreen(),
      binding: SearchScreenControllerBinding(),
    ),
    GetPage(
      name: Routes.PAYMENT_SCREEN,
      page: () => const PaymentScreenScreen(),
      binding: PaymentScreenControllerBinding(),
    ),
    GetPage(
      name: Routes.PROMISES,
      page: () => const PromisesScreen(),
      binding: PromisesControllerBinding(),
    ),
    GetPage(
      name: Routes.DELETE_ACCOUNT,
      page: () => const DeleteAccountScreen(),
      binding: DeleteAccountControllerBinding(),
    ),
    GetPage(
      name: Routes.CONTACT_DEVELOPERS,
      page: () => const ContactDevelopersScreen(),
      binding: ContactDevelopersControllerBinding(),
    ),
    GetPage(
      name: Routes.PLACE_REGISTRATION,
      page: () => const PlaceRegistrationScreen(),
      binding: PlaceRegistrationControllerBinding(),
    ),
    GetPage(
      name: Routes.MARRIAGE_REGISTRATION,
      page: () => const MarriageRegistrationScreen(),
      binding: MarriageRegistrationControllerBinding(),
    ),
    GetPage(
      name: Routes.ANNOUNCEMENT,
      page: () => const AnnouncementScreen(),
      binding: AnnouncementControllerBinding(),
    ),
    GetPage(
      name: Routes.MARRIAGE_CERTIFICATES,
      page: () => const MarriageCertificatesScreen(),
      binding: MarriageCertificatesControllerBinding(),
    ),
    GetPage(
      name: Routes.DEATH_REGISTRATION,
      page: () => const DeathRegistrationScreen(),
      binding: DeathRegistrationControllerBinding(),
    ),
    GetPage(
      name: Routes.DEATH_LIST,
      page: () => const DeathListScreen(),
      binding: DeathListControllerBinding(),
    ),
    GetPage(
      name: Routes.PDF_VIEWER,
      page: () => const PdfViewerScreen(),
      binding: PdfViewerControllerBinding(),
    ),
    GetPage(
      name: Routes.REPORTS_LIST,
      page: () => const ReportsListScreen(),
      binding: ReportsListControllerBinding(),
    ),
  ];
}
