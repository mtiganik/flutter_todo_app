

import 'package:flutter/material.dart';
import 'package:flutter_todo_app/home/utils/date_parser.dart';
import 'package:flutter_todo_app/models/category.dart';
import 'package:flutter_todo_app/models/priority.dart';
import 'package:flutter_todo_app/models/task.dart';

class TaskListItem extends StatefulWidget{
  final Task task;
  final Category taskCategory;
  final Priority taskPriority;
  const TaskListItem({super.key, required this.task, required this.taskCategory, required this.taskPriority});

  @override
  State<StatefulWidget> createState() => _TaskListItemState();

}

class _TaskListItemState extends State<TaskListItem>{

  TextStyle getPriorityStyle(Priority priority){
    if(priority.prioritySort >= 10) {return const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold);} 
    else if(priority.prioritySort >= 5){return const TextStyle();}
    else {return const TextStyle(color: Colors.lightGreen);}
  } 
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.task.taskName),
      subtitle: Text.rich(
        TextSpan(
          children: <TextSpan>[
            TextSpan(text: "Created: ${previousTimeToString(widget.task.createdDt)}, "),
            TextSpan(text: "${widget.taskPriority.priorityName}\n", style: getPriorityStyle(widget.taskPriority)),
            TextSpan(text: "Due: ${futureTimeToString(widget.task.dueDt)}"),
            const TextSpan(text: "\nDue:"),
          ]
        )
      ),
    );

  }

}

//   TextSpan(
//     text: 'Hello\n', // default text style
//     children: <TextSpan>[
//       TextSpan(text: ' beautiful ', style: TextStyle(fontStyle: FontStyle.italic)),
//       TextSpan(text: 'world', style: TextStyle(fontWeight: FontWeight.bold)),
//     ],
//   ),
// ),

