// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_application_1/toDo.dart';
import 'package:flutter_application_1/toDoTile.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final toDoList = ToDo.toDoList();
  final toDoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        backgroundColor: Colors.blue[100],
        leading: Icon(
          Icons.sticky_note_2_sharp,
          color: Colors.blue[800],
        ),
        title: Text(
          'To Do List',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue[800]),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: toDoList.isEmpty ? 
              Center(
                child: Text (
                  'To Do List is Empty', 
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue[800], fontSize: 25),
                ),
              )  : 
              ListView(
                children: [
                  for (ToDo toDo in toDoList)
                    ToDoTile(
                      toDoItem: toDo,
                      toDoOnClicked: toDoOnClick,
                      toDoOnDeleted: deleteToDo,
                      toDoOnEdited: editToDo,
                    ),
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
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextField(
                      controller: toDoController,
                      decoration: InputDecoration(
                        hintText: 'Add to do item',
                        border: InputBorder.none,
                      ),
                    ),
                  )
                ),
                Container(
                   margin: EdgeInsets.only(
                      bottom: 20,
                      right: 20,
                    ),
                    child: ElevatedButton(
                      child: Icon(
                        Icons.add,
                        color: Colors.blue[800],
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[100],
                        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 25),
                      ),
                      onPressed: () {
                        if (toDoController.text.isNotEmpty){
                          addToDo(toDoController.text);
                        } else {
                          showDialog(
                            context: context, 
                            builder: (context) => AlertDialog(
                              actions: [
                                TextButton(onPressed: () {
                                  Navigator.pop(context);
                                }, 
                                child: Text('OK'),
                                )
                              ],
                              title: Text('Failed to add item'),
                              content: Text('Please fill the textbox'),
                            )
                          );
                        }
                      },
                    ),
                )
              ]
            ),
          )
        ],
      ),
    );
  }

  void toDoOnClick(ToDo toDo) {
    setState(() {
      toDo.isDone = !toDo.isDone;
      toDo.completedTime = DateFormat('MMM d, yyyy hh:mm a').format(DateTime.now());
    });
  }

  void deleteToDo(int id) {
    setState(() {
      toDoList.removeWhere((toDo) => toDo.id == id);
    });
  }

  void addToDo(String text) {
    setState(() {
      toDoList.add(ToDo(id: toDoList.length + 1, text: text));
    });
    toDoController.clear();
  }

  void editToDo(int id, String text) {
    setState(() {
      toDoList.elementAt(
        toDoList.indexWhere((toDo) => toDo.id == id)
        ).text = text;
    });
  }
}
