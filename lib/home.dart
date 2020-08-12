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
  List<Todo> done = List<Todo>();
  SharedPreferences sharedPreferences;
  TextEditingController textFieldController = TextEditingController();

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
      resizeToAvoidBottomPadding: false,
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        child: Column(
          children: <Widget>[
            _appbar(),
            SizedBox(height: 5),
            /*list.isNotEmpty ?*/ _bodywidget() // : empty(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Theme.of(context).textSelectionColor),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () => _buttonPress(),
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
                color: Theme.of(context).textSelectionColor,
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
          IconButton(
            icon: Icon(
              Icons.info_outline,
              color: Theme.of(context).textSelectionColor,
            ),
            onPressed: () => showHelpSheet(),
          )
        ],
      ),
    );
  }

  Widget _bodywidget() {
    return DefaultTabController(
      length: 2,
      child: SingleChildScrollView(
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
          child: Scaffold(
            appBar: TabBar(
                labelColor: Theme.of(context).indicatorColor,
                tabs: [
                  Tab(text: 'Todo items'),
                  Tab(
                    text: 'Archive',
                  )
                ],
                indicatorColor: Theme.of(context).accentColor),
            body: TabBarView(children: [
              list.isNotEmpty ? itemBody() : empty(),
              done.isNotEmpty ? doneBody() : empty()
            ]),
          ),
        ),
      ),
    );
  }

  Widget itemBody() {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        return Dismissible(
          key: Key(list[index].toString()),
          onDismissed: (direction) {
            if (direction == DismissDirection.startToEnd) {
              removeItem(list[index]);
            } else {
              archieveItem(list[index]);
            }
          },
          //=> removeItem(list[index]),
          background: Container(
            color: Theme.of(context).primaryColor,
            child: Icon(
              Icons.delete,
              color: Theme.of(context).textSelectionColor,
            ),
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 12.0),
          ),
          secondaryBackground: Container(
            color: Colors.green[500],
            child: Icon(
              Icons.archive,
              color: Theme.of(context).textSelectionColor,
            ),
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 12.0),
          ),
          child: ListTile(
            title: Text(
              list[index].title,
              style: list[index].completed
                  ? TextStyle(
                      decoration: TextDecoration.lineThrough,
                      color: Colors.grey)
                  : TextStyle(),
            ),
            trailing: Checkbox(value: list[index].completed, onChanged: null),
            onTap: () => setComplete(list[index]),
            onLongPress: () => editOnSwipe(list[index]),
            //onLongPress: () => editTodo(list[index], "taq"),
          ),
        );
      },
    );
  }

  Widget doneBody() {
    return ListView.builder(
      itemCount: done.length,
      itemBuilder: (context, index) {
        return Dismissible(
          key: Key(done[index].toString()),
          onDismissed: (direction) {
            if (direction == DismissDirection.startToEnd) {
              removeDoneItem(done[index]);
            } else {
              unArchieveItem(done[index]);
            }
          },
          //=> removeItem(list[index]),
          background: Container(
            color: Theme.of(context).primaryColor,
            child: Icon(
              Icons.delete,
              color: Theme.of(context).textSelectionColor,
            ),
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 12.0),
          ),
          secondaryBackground: Container(
            color: Colors.green[500],
            child: Icon(
              Icons.unarchive,
              color: Theme.of(context).textSelectionColor,
            ),
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 12.0),
          ),
          child: ListTile(
            title: Text(
              done[index].title,
              style: done[index].completed
                  ? TextStyle(
                      decoration: TextDecoration.lineThrough,
                      color: Colors.grey)
                  : TextStyle(),
            ),
            trailing: Checkbox(value: done[index].completed, onChanged: null),
            onTap: () => setComplete(done[index]),
            onLongPress: () => editOnSwipe(done[index]),
            //onLongPress: () => editTodo(list[index], "taq"),
          ),
        );
      },
    );
  }

  Widget empty() {
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
          child: Center(
            child: ListTile(
              title: Text(
                'There are no items to display here right now.',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ));
  }

  void removeItem(Todo item) {
    list.remove(item);
    setState(() {});
    dataSave();
  }

  void removeDoneItem(Todo item) {
    done.remove(item);
    setState(() {});
    dataSave();
  }

  void archieveItem(Todo item) {
    done.add(item);
    list.remove(item);
    setState(() {});
    dataSave();
  }

  void unArchieveItem(Todo item) {
    list.add(item);
    done.remove(item);
    setState(() {});
    dataSave();
  }

  void setComplete(Todo item) {
    setState(() {});
    item.completed = !item.completed;
    setState(() {});
    dataSave();
  }

  void goEditItem(Todo item) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return NewItemView(title: item.title);
    })).then((title) {
      if (title != null) {
        editTodo(item, title);
      }
    });
  }

  void editTodo(Todo item, String title) {
    item.title = title;
    setState(() {});
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
    List<String> sharedPrefDone =
        done.map((item) => jsonEncode(item.topMap())).toList();
    sharedPreferences.setStringList('done', sharedPrefDone);
  }

  void dataLoad() {
    List<String> sharedPrefList = sharedPreferences.getStringList('list');
    list =
        sharedPrefList.map((item) => Todo.fromMap(jsonDecode(item))).toList();
    List<String> sharedPrefDone = sharedPreferences.getStringList('done');
    done =
        sharedPrefDone.map((item) => Todo.fromMap(jsonDecode(item))).toList();
    setState(() {});
  }

  void save() {
    if (textFieldController.text.isNotEmpty) {
      Navigator.of(context).pop(textFieldController.text);
      newTodo(Todo(title: textFieldController.text));
      textFieldController.clear();
    }
  }

  void editTodoItem(Todo item) {
    if (textFieldController.text.isNotEmpty) {
      Navigator.of(context).pop(textFieldController.text);
      String title = textFieldController.text;
      editTodo(item, title);
      textFieldController.clear();
      setState(() {});
    }
  }

  void _buttonPress() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Colors.transparent,
            //padding: EdgeInsets.only(left: 4, right: 4),
            child: Container(
              // padding: EdgeInsets.only(left: 4, right: 4),
              decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
              child: Column(
                children: <Widget>[
                  TextField(
                    autofocus: true,
                    controller: textFieldController,
                    onEditingComplete: () => save(),
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: 'Enter a note here',
                    ),
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
                      style: TextStyle(
                          color: Theme.of(context).textSelectionColor),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  void editOnSwipe(Todo item) {
    textFieldController = TextEditingController(text: item.title);
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Colors.transparent,
            //padding: EdgeInsets.only(left: 4, right: 4),
            child: Container(
              //padding: EdgeInsets.only(left: 4, right: 4),
              decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
              child: Column(
                children: <Widget>[
                  TextField(
                    autofocus: true,
                    controller: textFieldController,
                    onEditingComplete: () => editTodoItem(item),
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: 'Enter a note here',
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  FlatButton(
                    color: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    onPressed: () => editTodoItem(item),
                    child: Text(
                      "save",
                      style: TextStyle(
                          color: Theme.of(context).textSelectionColor),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  void showHelpSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 120,
            color: Colors.transparent,
            padding: EdgeInsets.only(left: 0, right: 0),
            child: Container(
                padding: EdgeInsets.only(left: 0, right: 0),
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25)),
                ),
                child: Center(
                  child: Text(
                    'Press the + icon to add an new item.\n Swipe from left to right to delete the item \n Press and hold the new item to edit it.',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                )),
          );
        });
  }
}
