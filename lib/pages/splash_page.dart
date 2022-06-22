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
  final size= MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
      height: size.height,
      width: size.width,
      color: Colors.black26,
      child: const Center(child: Text("Splash Page",style: TextStyle(color:Colors.white)),)
      
      ),
    
    );
  }

  void toHome() async {

    log("Splash Ejecutado");
    await Future.delayed(const Duration(seconds: 3), () => {
    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => const HomePage()),)
    });
  
  }
}
