//package imports
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

//custom imports
import 'package:todo/home.dart';
import 'package:todo/mythemes.dart';

//void main() => runApp(MyApp());

void main() => runApp(
      ChangeNotifierProvider<AppState>(
        create: (context) => AppState(),
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light));
    return Consumer<AppState>(
      builder: (context, appState, _) {
        return MaterialApp(
          theme: MyThemes.lightTheme,
          darkTheme: MyThemes.darkTheme,
          themeMode: appState.isDarkTheme ? ThemeMode.dark : ThemeMode.light,
          debugShowCheckedModeBanner: false,
          home: HomeScreen(),
        );
      },
    );
  }
}

class AppState extends ChangeNotifier {
  bool isDarkTheme = false;

  void updateTheme(bool isDarkTheme) {
    this.isDarkTheme = isDarkTheme;
    notifyListeners();
  }
}
