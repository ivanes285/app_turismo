import 'package:app_turismo/pages/splash_page.dart';
import 'package:app_turismo/services/categories_provider.dart';
import 'package:app_turismo/services/conection_status_provider.dart';
import 'package:app_turismo/services/events_providers.dart';
import 'package:app_turismo/services/places_providers.dart';
import 'package:app_turismo/utils/check_internet_connection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

final internetChecker = CheckInternetConnection();
void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => EventsProviders()),
    ChangeNotifierProvider(create: (_) => CategoriesProviders()),
    ChangeNotifierProvider(create: (_) => PlacesProviders()),
    ChangeNotifierProvider(create: (_) => ConnectionStatusChangeNotifier()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
      ),
      home: const SplashPage(),
    );
  }
}
