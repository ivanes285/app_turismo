// // ignore_for_file: avoid_unnecessary_containers

import 'package:app_turismo/components/change_theme.dart';
import 'package:app_turismo/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.setTheme = await ThemePreferens.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
             Text(
              "Cambiar tema de la aplicación ?",
              style: TextStyle(color: Theme.of(context).primaryColorDark, fontSize:18),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.wb_sunny, color: Theme.of(context).primaryColorDark),
              Switch(
                  value: theme.isDarkTheme(),
                  onChanged: (value) {
                    String newTheme =
                        value ? ThemePreferens.DARK : ThemePreferens.LIGHT;
                    theme.setTheme = newTheme;
                  }),
            ])
          ]),
        ));
  }
}
