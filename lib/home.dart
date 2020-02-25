import 'package:flutter/material.dart';

class Homescreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => Home();
}

class Home extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
            child: Column(
          children: <Widget>[
            _appbar(),
            _body(),
          ],
        )),
      ),
    );
  }
}

Widget _appbar() {
  return Container(
    height: 150,
    padding: EdgeInsets.only(top: 42, bottom: 16, left: 16, right: 16),
    decoration: BoxDecoration(
        color: Color(0xFF42A5F5),
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25))),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "Todo",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {}),
      ],
    ),
  );
}

Widget _body(){
  return Container(
    child: Text("data"),
  );

}