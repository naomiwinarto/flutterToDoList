import 'package:flutter/material.dart';
import 'package:flutter_application_1/toDo.dart';

class ToDoTile extends StatelessWidget {
  final ToDo toDoItem;
  final toDoOnClicked;
  final toDoOnDeleted;
  final toDoOnEdited;

  ToDoTile({
    super.key,
    required this.toDoItem,
    required this.toDoOnClicked,
    required this.toDoOnDeleted,
    required this.toDoOnEdited,
    
  });

  @override
  Widget build(BuildContext context) {
    final toDoController = TextEditingController(text: toDoItem.text);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: ListTile(
        onTap: () {
          toDoOnClicked(toDoItem);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        tileColor: toDoItem.isDone ? Colors.grey[300]: Colors.white60,
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        leading: Icon(
          toDoItem.isDone ? Icons.check_box_outlined : Icons.check_box_outline_blank,
          color: Colors.blue,
        ),
        title: Text(
          toDoItem.text,
          style: TextStyle(decoration: toDoItem.isDone ? TextDecoration.lineThrough : null),
        ),
        subtitle: toDoItem.isDone ? Text('completed on ' + toDoItem.completedTime): null,
        trailing: Wrap(
          children: [
            IconButton(
              icon: Icon(
                Icons.edit,
                color: toDoItem.isDone ? null : Colors.blue[800],
              ),
              onPressed: () {
                toDoItem.isDone ? null : showDialog(
                  context: context, 
                  builder: (context) => AlertDialog(
                    actions: [
                      TextButton(onPressed: () {
                        Navigator.pop(context);
                      }, 
                      child: Text('CANCEL'),
                      ),
                      TextButton(onPressed: () {
                        Navigator.pop(context);
                        toDoOnEdited(toDoItem.id, toDoController.text);
                      }, 
                      child: Text('SAVE'),
                      )
                    ],
                    title: Text('Edit'),
                    content: TextField(
                      controller: toDoController,
                      decoration: InputDecoration(
                        hintText: 'Edit to do item',
                        border: InputBorder.none,
                      ),
                    )
                  )
                );
              },
            ),
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.red[800],
              ),
              onPressed: () {
                showDialog(
                  context: context, 
                  builder: (context) => AlertDialog(
                    actions: [
                      TextButton(onPressed: () {
                        Navigator.pop(context);
                      }, 
                      child: Text('NO'),
                      ),
                      TextButton(onPressed: () {
                        Navigator.pop(context);
                        toDoOnDeleted(toDoItem.id);
                      }, 
                      child: Text('YES', style: TextStyle(color: Colors.red[800])),
                      )
                    ],
                    title: Text('Delete'),
                    content: Text('Are you sure to delete "${toDoItem.text}"?'),
                  )
                );
              },
            ),
          ]
        ),
      ),
    );
  }
}
