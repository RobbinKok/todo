import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
}

class ThemeNotifier extends ChangeNotifier {
  final String key = "theme";
  SharedPreferences _pref;
  bool _darktheme;

  bool get darkTheme => _darktheme;

  ThemeNotifier() {
    _darktheme = true;
    _loadFromPrefs();
  }

  toggleTheme() {
    _darktheme = !_darktheme;
    _saveToPrefs();
    notifyListeners();
  }

  _initPrefs() async {
    if (_pref == null) {
      _pref = await SharedPreferences.getInstance();
    }
  }

  _loadFromPrefs() async {
    await _initPrefs();
    _darktheme = _pref.getBool(key) ?? true;
    notifyListeners();
  }

  _saveToPrefs() async {
    await _initPrefs();
    _pref.setBool(key, _darktheme);
  }
}
