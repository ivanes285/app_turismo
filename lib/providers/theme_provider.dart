import 'package:app_turismo/components/change_theme.dart';
import 'package:flutter/material.dart';

// class ThemeProvider extends ChangeNotifier {
//   ThemePreferens themePreferens = ThemePreferens();

//   String get theme => _theme;

//   set setTheme(String theme) {
//     _theme = theme;
//     themePreferens.setModeTheme(theme);
//     notifyListeners();
//   }

//   bool isDarkTheme() => _theme == ThemePreferens.DARK;
// }

class ThemeProvider extends ChangeNotifier {
  ThemePreferens themePreferens = ThemePreferens();
  String _themeData = ThemePreferens.DARK;

 String get  getTheme => _themeData;

 set setTheme(String theme) {
    _themeData = theme;
    themePreferens.setModeTheme(theme);
    notifyListeners();
  }
   bool isDarkTheme() => _themeData == ThemePreferens.DARK;
}
