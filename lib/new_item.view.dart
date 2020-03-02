import 'package:flutter/material.dart';


class NewItemView extends StatefulWidget{
  	@override
    _NewItemViewState createState() => _NewItemViewState();
}

class _NewItemViewState extends State<NewItemView>{
  TextEditingController textFieldController = TextEditingController();
  
  @override
  Widget build(BuildContext context){

    return Scaffold(
      appBar: AppBar(
        title: Text("New Item"),
        backgroundColor: Colors.red[500],
      ),
      body: Column(
        children: <Widget>[
          TextField(
            controller: textFieldController,
            onEditingComplete: () => save(),
          ),
          FlatButton(onPressed: () => save(),
          child: Text("save", style: TextStyle(color: Colors.red[500]),),
          )
        ],
      ),
    );


  }
    void save(){
      print(textFieldController.text);
    }

}