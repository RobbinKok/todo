import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'todo.dart';
import 'new_item.view.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => Home();
}

class Home extends State<HomeScreen> {
  List<Todo> list = List<Todo>();
  SharedPreferences sharedPreferences;

  @override
  void initState() {
    initSharedPrefrence();
    super.initState();
  }

  initSharedPrefrence() async {
    sharedPreferences = await SharedPreferences.getInstance();
    dataLoad();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        child: Column(
          children: <Widget>[
            _appbar(),
            SizedBox(height: 5),
            _bodywidget(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Theme.of(context).accentColor),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () => goToNewItem(),
      ),
    );
  }

  Widget _appbar() {
    return Container(
      height: 115,
      padding: EdgeInsets.only(top: 42, bottom: 16, right: 16, left: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Todo',
            style: TextStyle(
                color: Theme.of(context).accentColor,
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
          IconButton(
              icon: Icon(
                Icons.settings,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () => _buttonPress())
        ],
      ),
    );
  }

  Widget _bodywidget() {
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
                topRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30)),
          ),
          child: body()),
    );
  }

  Widget body() {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        return Dismissible(
          key: Key(list[index].hashCode.toString()),
          onDismissed: (direction) => removeItem(list[index]),
          direction: DismissDirection.startToEnd,
          background: Container(
            color: Theme.of(context).primaryColor,
            child: Icon(
              Icons.delete,
              color: Theme.of(context).accentColor,
            ),
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 12.0),
          ),
          child: ListTile(
            title: Text(list[index].title),
            trailing: Checkbox(value: list[index].completed, onChanged: null),
            onTap: () => setComplete(list[index]),
          ),
        );
      },
    );
  }

  void removeItem(Todo item) {
    list.remove(item);
  }

  void setComplete(Todo item) {
    setState(() {
      item.completed = !item.completed;
    });
  }

  void goToNewItem() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return NewItemView();
    })).then((title) {
      if (title != null) {
        newTodo(Todo(title: title));
      }
    });
  }

  void newTodo(Todo item) {
    list.add(item);
    dataSave();
  }

  void dataSave() {
    List<String> sharedPrefList =
        list.map((item) => jsonEncode(item.topMap())).toList();
    sharedPreferences.setStringList('list', sharedPrefList);
  }

  void dataLoad() {
    List<String> sharedPrefList = sharedPreferences.getStringList('list');
    list =
        sharedPrefList.map((item) => Todo.fromMap(jsonDecode(item))).toList();
    setState(() {});
  }

  void _buttonPress() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Color(0xFF737373),
            padding: EdgeInsets.only(left: 4, right: 4),
            child: Container(
              padding: EdgeInsets.only(left: 4, right: 4),
              decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
              child: Column(
                children: <Widget>[],
              ),
            ),
          );
        });
  }
}
