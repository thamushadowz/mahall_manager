import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mahall_manager/infrastructure/theme/strings/app_strings.dart';
import 'package:toastification/toastification.dart';

import 'domain/core/di/dependancy.dart';
import 'domain/listing/listing_repository.dart';
import 'infrastructure/navigation/navigation.dart';
import 'infrastructure/navigation/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  var initialRoute = await Routes.initialRoute;
  DependencyCreator.init();
  await GetStorage.init();
  Get.put(ListingRepository());
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]).then((_) {
    runApp(Main(initialRoute));
  });
}

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

class Main extends StatelessWidget {
  final String initialRoute;

  const Main(this.initialRoute, {super.key});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: GetMaterialApp(
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
      ),
    );
  }

  Locale _getSavedLocale() {
    final storage = GetStorage();
    String lang = storage.read(AppStrings.preferredLanguage) ?? 'en';
    return Locale(lang);
  }
}
