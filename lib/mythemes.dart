import 'package:flutter/material.dart';

enum MyThemesKeys { LIGHT, DARK }

class MyThemes {
  static final ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.red,
      accentColor: Colors.white,
      textSelectionColor: Colors.white,
      backgroundColor: Colors.grey[300],
      indicatorColor: Colors.grey[900],
      canvasColor: Colors.transparent
      //        brightness: Brightness.light
      );

  static final ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.red,
      textSelectionColor: Colors.white,
      accentColor: Colors.grey[800],
      backgroundColor: Colors.grey[900],
      indicatorColor: Colors.white,
      canvasColor: Colors.transparent);

  static ThemeData getThemeFromKey(MyThemesKeys themesKeys) {
    switch (themesKeys) {
      case MyThemesKeys.LIGHT:
        return lightTheme;
        break;
      case MyThemesKeys.DARK:
        return darkTheme;
        break;

      default:
        return lightTheme;
    }
  }
}
