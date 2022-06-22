
import 'package:app_turismo/pages/splash_page.dart';
import 'package:app_turismo/services/events_providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {

  runApp(MultiProvider(
  providers: [ChangeNotifierProvider(create: (_)=> EventsProviders())],
  child: const MyApp()));

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:const SplashPage(),
         );
  }
}

