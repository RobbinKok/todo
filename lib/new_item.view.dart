import 'package:flutter/material.dart';

class NewItemView extends StatefulWidget {
  String title;

  NewItemView({this.title});

  @override
  _NewItemViewState createState() => _NewItemViewState();
}

class _NewItemViewState extends State<NewItemView> {
  TextEditingController textFieldController;
  @override
  void initState() {
    textFieldController = TextEditingController(text: widget.title);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Theme.of(context).backgroundColor,
        body: Container(
          child: Column(
            children: <Widget>[
              _appbar(),
              SizedBox(
                height: 5,
              ),
              _body(context)
            ],
          ),
        ));
  }

  Widget _appbar() {
    return Container(
      height: 115,
      padding: EdgeInsets.only(top: 42, bottom: 16, left: 16, right: 16),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'New Item',
            style: TextStyle(
                color: Theme.of(context).accentColor,
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _body(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(left: 4, right: 4),
      child: Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 8),
        height: MediaQuery.of(context).size.height * 1 - 129,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Theme.of(context).accentColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
                topRight: Radius.circular(30))),
        child: Column(
          children: <Widget>[
            TextField(
              autofocus: true,
              controller: textFieldController,
              onEditingComplete: () => save(),
              textAlign: TextAlign.center,
              decoration: InputDecoration(hintText: 'enter note'),
            ),
            SizedBox(
              height: 5,
            ),
            FlatButton(
              color: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              onPressed: () => save(),
              child: Text(
                "save",
                style: TextStyle(color: Theme.of(context).accentColor),
              ),
            )
          ],
        ),
      ),
    );
  }

  void save() {
    if (textFieldController.text.isNotEmpty) {
      Navigator.of(context).pop(textFieldController.text);
    }
  }
}
