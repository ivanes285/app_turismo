import 'package:app_turismo/components/splash_page.dart';
import 'package:app_turismo/providers/categories_provider.dart';
import 'package:app_turismo/providers/conection_status_provider.dart';
import 'package:app_turismo/providers/events_providers.dart';
import 'package:app_turismo/providers/places_providers.dart';
import 'package:app_turismo/providers/theme_provider.dart';
import 'package:app_turismo/theme/theme.dart';
import 'package:app_turismo/utils/check_internet_connection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';


final internetChecker = CheckInternetConnection();
void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => EventsProviders()),
    ChangeNotifierProvider(create: (_) => CategoriesProviders()),
    ChangeNotifierProvider(create: (_) => PlacesProviders()),
    ChangeNotifierProvider(create: (_) => ConnectionStatusChangeNotifier()),
    ChangeNotifierProvider(create: (_) => ThemeProvider()),
   
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme.isDarkTheme() ? ThemeDark : ThemeLight,
      home: const SplashPage(),
    );
  }
}
