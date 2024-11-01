import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../config.dart';
import '../../presentation/screens.dart';
import 'bindings/controllers/controllers_bindings.dart';
import 'routes.dart';

class EnvironmentsBadge extends StatelessWidget {
  final Widget child;

  EnvironmentsBadge({required this.child});

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
      page: () => const ContactUsScreen(),
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
  ];
}
