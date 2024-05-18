import 'package:flutter/material.dart';
import 'package:todo_app_using_flutter/constants/colors.dart';
import 'package:todo_app_using_flutter/model/todo.dart';

class ToDoItem extends StatelessWidget {
  final ToDo todo;

  const ToDoItem({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // to see todo item
    return Container(
        margin: EdgeInsets.only(bottom: 5),
        child: ListTile(
          onTap: () {
            print('clicked');
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          tileColor: Colors.amber,
          leading: Icon(
            todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
            color: Colors.amber[50],
          ),
          title: Text(
            todo.todoText!,
            style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
                decoration: todo.isDone ? TextDecoration.lineThrough : null),
          ),
          trailing: Container(
            padding: EdgeInsets.all(0),
            margin: EdgeInsets.symmetric(vertical: 10),
            height: 35,
            width: 35,
            decoration: BoxDecoration(
                color: Colors.amber[50],
                borderRadius: BorderRadius.circular(5)),
            child: IconButton(
              color: black,
              iconSize: 20,
              icon: Icon(Icons.delete),
              onPressed: () {
                print('deleted');
              },
            ),
          ),
        ));
  }
}
