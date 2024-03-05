import 'package:intl/intl.dart';

class ToDo{
  int id;
  String text;
  String completedTime;
  bool isDone;

  ToDo({
    required this.id,
    required this.text,
    this.completedTime = '',
    this.isDone = false,
  });

  static List<ToDo> toDoList(){
    return[
      ToDo(id: 1, text: 'Breakfast', completedTime: DateFormat('MMM d, yyyy hh:mm a').format(DateTime.parse('2023-08-20 20:18:04')), isDone: true),
      ToDo(id: 2, text: 'Exercise'),
      ToDo(id: 3, text: 'Daily Meeting'),
    ];
  }
}
