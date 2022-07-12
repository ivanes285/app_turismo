import 'dart:developer';
import 'package:app_turismo/pages/main_page.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    toHome();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      // ignore: sized_box_for_whitespace
      body: Container(
          height: size.height,
          width: size.width,
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/logo.png',
                height: 320,
              ),
              const SizedBox(
                height: 50.0,
              ),
              const Text("Pedro Moncayo Turístico",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25.0,
                      decorationStyle: TextDecorationStyle.wavy)),
              const SizedBox(
                height: 30.0,
              ),
              const SizedBox(
                  width: 250,
                  child: Center(
                    child: LinearProgressIndicator(),
                  ))
            ],
          ))),
    );
  }

  void toHome() async {
    log("Splash Ejecutado");
    await Future.delayed(
        const Duration(seconds: 2),
        () => {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const MainPage()),
              )
            });
  }
}
