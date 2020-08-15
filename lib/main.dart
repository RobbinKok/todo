//package imports
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

//custom imports
import 'package:todo/home.dart';
import 'package:todo/mythemes.dart';

//void main() => runApp(MyApp());

void main() => runApp(
      MyApp(),
    );

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light));
    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
          builder: (context, ThemeNotifier notifier, child) {
        return MaterialApp(
          theme: notifier.darkTheme ? MyThemes.darkTheme : MyThemes.lightTheme,
          home: HomeScreen(),
        );
      }),
    );
  }
}
