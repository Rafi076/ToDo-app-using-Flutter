import 'package:flutter/material.dart';
import 'package:todo_app_using_flutter/constants/colors.dart';
import 'package:todo_app_using_flutter/model/todo.dart';
import 'package:todo_app_using_flutter/widgets/todo_item.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todoslist = ToDo.todoList();
  List<ToDo> _foundToDo = [];
  final _todoController = TextEditingController();

  @override
  void initState() {
    _foundToDo = todoslist;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: amber,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Column(
              children: [
                searchBox(), // this widget work for creating search box

                // to create listview after the search opiton
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 25, bottom: 15),
                        child: Text(
                          'All ToDo',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w400),
                        ),
                      ),
                      for (ToDo todoo in _foundToDo)
                        ToDoItem(
                          todo: todoo,
                          onToDoChanged: _handleToDoChanged,
                          onDeleteItem: _deletedToDoItem,
                        ), // first todo camed from todo.dart file..
                    ],
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                      bottom: 20,
                      right: 20,
                      left: 20,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.amber[50],
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 0.0),
                          blurRadius: 10.0,
                          spreadRadius: 0.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: _todoController,
                      decoration: InputDecoration(
                        hintText: 'Add ToDo',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    bottom: 20,
                    right: 20,
                  ),
                  child: ElevatedButton(
                    child: Text(
                      '+',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                    onPressed: () {
                      _addToDoItem(
                          _todoController.text); // to get text of addToDo field
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: amber,
                      minimumSize: Size(60, 60),
                      elevation: 10,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  /// here this fuctions are created for backend!! (
  ///
  /// _handleToDoChanged function used to change the state of todo items!
  void _handleToDoChanged(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  /// _deleteToDoItem function used to delete the ToDo item!!
  void _deletedToDoItem(String id) {
    setState(() {
      todoslist.removeWhere((item) => item.id == id);
    });
  }

  //_addToDoItem funtion used to add item on the list
  void _addToDoItem(String toDo) {
    setState(() {
      todoslist.add(ToDo(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          todoText: toDo));
    });

    // after adding the item clear the "Add Todo" field
    _todoController.clear();
  }

  /// _runFilter function used for searched item
  void _runFilter(String enteredkeyword) {
    List<ToDo> results = [];
    if (enteredkeyword.isEmpty) {
      results = todoslist;
    } else {
      results = todoslist
          .where((item) => item.todoText!
              .toLowerCase()
              .contains(enteredkeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundToDo = results;
    });
  }

  /// )

// for creating search box
  Widget searchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(25)),
      child: TextField(
        /// on changed finction used for searchbox to find item
        onChanged: (value) => _runFilter(value),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(0),
            prefix: Icon(
              Icons.search,
              color: black,
              size: 25,
            ),
            prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 15),
            border: InputBorder.none,
            hintText: ' Search',
            hintStyle: TextStyle(color: grey)),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: amber,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.menu,
            color: black,
            size: 30,
          ),
          Container(
              height: 40,
              width: 40,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                      'https://randomuser.me/api/portraits/men/1.jpg')))
        ],
      ),
    );
  }
}
