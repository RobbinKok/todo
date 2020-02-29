import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => Home();
}

class Home extends State<HomeScreen> {
    
    List<Todo> list = List<Todo>();
    @override
    void initState(){
      list.add(Todo(title: "item a"));
      list.add(Todo(title: "item b"));
      list.add(Todo(title: "item c"));
      super.initState();
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFEFF4),
      body: Container(
        child: Column(
          children: <Widget>[
            _appbar(),
            SizedBox(height: 5),
            _bodywidget(),
          ],
        ),
      ),
    );
  }

  Widget _appbar() {
    return Container(
      height: 130,
      padding: EdgeInsets.only(top: 42, bottom: 16, right: 16, left: 16),
      decoration: BoxDecoration(
        color: Color(0xFF42A5F5),
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
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
          ),
          IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.white,
              ),
              onPressed: () {})
        ],
      ),
    );
  }

  Widget _bodywidget() {
    
    
    


    return Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 8),
        height: MediaQuery.of(context).size.height * 1 - 150,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index){
            return ListTile(
              title: Text(list[index].title),
              trailing: Icon(Icons.check_box),
              onTap: () => print(list[index].title),
            );
          }
          ,
        ),);
  }
}

class Todo {
  String title;
  bool completed;

  Todo(
    {
      this.title, 
      this.completed = false,
    }
    );
}
