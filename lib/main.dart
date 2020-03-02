import 'package:flutter/material.dart';

import 'package:todo/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        accentColor: Colors.white,
        backgroundColor: Colors.grey[300]

//        brightness: Brightness.light
      ),
      home: HomeScreen(),
    );
  }
}
