// // ignore_for_file: avoid_unnecessary_containers

// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:developer';

import 'package:app_turismo/components/change_theme.dart';
import 'package:app_turismo/providers/theme_provider.dart';
import 'package:app_turismo/theme/style_global.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  ThemeProvider themeChangeProvider = ThemeProvider();

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
    log(themeChangeProvider.getTheme.toString());
    log("hola");
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.setTheme =
        await themeChangeProvider.themePreferens.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Center(
          child: Column(children: [
            const SizedBox(height: 150),
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Themas.kBackgroundColorButton,
                borderRadius: BorderRadius.circular(20),
              ),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Text(
                      'Tema de la aplicación',
                      style: Themas.whiteTextStyle
                          .copyWith(color: Colors.white, fontSize: 18),
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Icon(Icons.wb_sunny,
                          color: Theme.of(context).primaryColorDark),
                      Switch(
                          value: theme.isDarkTheme(),
                          onChanged: (value) {
                            String newTheme = value
                                ? ThemePreferens.DARK
                                : ThemePreferens.LIGHT;
                            theme.setTheme = newTheme;
                          }),
                    ]),
                    const SizedBox(width: 5),
                  ]),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Themas.kBackgroundColorButton,
                borderRadius: BorderRadius.circular(20),
              ),
              width: double.infinity,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/iconosetting.png',
                        height: 70, width: 70),
                    Text(
                      'Pedro Moncayo Turístico',
                      style: Themas.whiteTextStyle
                          .copyWith(color: Colors.white, fontSize: 10),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Versión 1.0.1',
                      style: Themas.whiteTextStyle
                          .copyWith(color: Colors.white, fontSize: 10),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Desarrollado por:',
                      style: Themas.whiteTextStyle
                          .copyWith(color: Colors.white, fontSize: 20),
                    ),
                    InkWell(
                        child: const Text('@ialescanov',
                            style: TextStyle(
                                color: Color(0xff005CA5),
                                decoration: TextDecoration.underline,
                                fontSize: 20)),
                        onTap: () {
                          const toEmail = 'ialescanov@utn.edu.ec';
                          const subject = 'Sugerencia';
                          const message =
                              'Hola me gustaría hacerte una sugerencia ..\n';
                          const url =
                              'mailto:$toEmail?subject=$subject&body=$message';
                          _launchUrl(url);
                        }),
                    const SizedBox(width: 5),
                  ]),
            ),
          ]),
        ));
  }
}

Future<void> _launchUrl(String url) async {
  final Uri _url = Uri.parse(url);
  if (!await launchUrl(_url,
      mode: LaunchMode.platformDefault,
      webViewConfiguration:
          const WebViewConfiguration(enableJavaScript: true))) {
    throw 'Could not launch $_url';
  }
}
