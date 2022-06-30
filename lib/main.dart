import 'package:app_turismo/pages/splash_page.dart';
import 'package:app_turismo/services/categories_provider.dart';
import 'package:app_turismo/services/events_providers.dart';
import 'package:app_turismo/services/places_providers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => EventsProviders()),
    ChangeNotifierProvider(create: (_) => CategoriesProviders()),
    ChangeNotifierProvider(create: (_) => PlacesProviders()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.light().copyWith(
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
      ),
      home: const SplashPage(),
    );
  }
}
