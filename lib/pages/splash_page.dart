import 'dart:developer';
import 'package:app_turismo/pages/home_page.dart';
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
      backgroundColor: Colors.amber,
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
                height: 250,
              ),
               const SizedBox(
                height: 30.0,
              ),
              const Text("Pedro Moncayo Turismo",style: TextStyle(color: Colors.white,
               fontSize: 25.0, decorationStyle: TextDecorationStyle.wavy)),
              const SizedBox(
                height: 30.0,
              ),
              const CircularProgressIndicator(color: Colors.white)
            ],
          ))),
    );
  }

  void toHome() async {
    log("Splash Ejecutado");
    await Future.delayed(
        const Duration(seconds: 3),
        () => {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              )
            });
  }
}
