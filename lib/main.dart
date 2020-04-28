import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:todo/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.red,
          accentColor: Colors.white,
          textSelectionColor: Colors.white,
          backgroundColor: Colors.grey[300],
          canvasColor: Colors.transparent
          //        brightness: Brightness.light
          ),
          /*
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.red,
           textSelectionColor: Colors.white,
          accentColor: Colors.grey[800],
          backgroundColor: Colors.grey[900]
        ),*/
      home: HomeScreen(),
    );
  }
}
