import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mahall_manager/domain/core/interfaces/snackbar_service.dart';
import 'package:mahall_manager/infrastructure/theme/strings/app_strings.dart';

import 'infrastructure/navigation/navigation.dart';
import 'infrastructure/navigation/routes.dart';

void main() async {
  var initialRoute = await Routes.initialRoute;
  await GetStorage.init();
  Get.put(SnackbarService());
  runApp(Main(initialRoute));
}

class Main extends StatelessWidget {
  final String initialRoute;

  const Main(this.initialRoute, {super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: _getSavedLocale(),
      supportedLocales: const [
        Locale('en'),
        Locale('ml'),
      ],
      initialRoute: initialRoute,
      getPages: Nav.routes,
      debugShowCheckedModeBanner: false,
    );
  }

  Locale _getSavedLocale() {
    final storage = GetStorage();
    String lang = storage.read(AppStrings.preferredLanguage) ?? 'en';
    return Locale(lang);
  }
}
