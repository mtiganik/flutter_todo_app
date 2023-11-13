

import 'package:flutter/material.dart';
import 'package:flutter_todo_app/home/utils/date_parser.dart';
import 'package:flutter_todo_app/models/category.dart';
import 'package:flutter_todo_app/models/priority.dart';
import 'package:flutter_todo_app/models/task.dart';

enum MenuItems {markAsDone, edit, archieve, delete}

class TaskListItem extends StatefulWidget{
  final Task task;
  final Category taskCategory;
  final Priority taskPriority;
  const TaskListItem({super.key, required this.task, required this.taskCategory, required this.taskPriority});

  @override
  State<StatefulWidget> createState() => _TaskListItemState();

}

class _TaskListItemState extends State<TaskListItem>{
  MenuItems? selectedMenuItem;

  Future<void> handleMarkAsDone()async{
    print("On handle mark as done");
  }
  TextStyle getPriorityStyle(Priority priority){
    if(priority.prioritySort >= 10) {return const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold);} 
    else if(priority.prioritySort >= 5){return const TextStyle();}
    else {return const TextStyle(color: Colors.lightGreen);}
  } 

  Icon getIconByCategory(Category category){
    if(category.categoryName == "Home") {return const Icon(Icons.home);}
    else if(category.categoryName == "Work") {return const Icon(Icons.work);}
    else if(category.categoryName == "School") {return const Icon(Icons.school);}
    else if(category.categoryName == "Other") {return const Icon(Icons.other_houses);}
    else {return const Icon(Icons.question_mark);}
  }
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.task.taskName),
      leading: getIconByCategory(widget.taskCategory),
      subtitle: Text.rich(
        TextSpan(
          children: <TextSpan>[
            TextSpan(text: "${previousTimeToString(widget.task.createdDt)}, "),
            TextSpan(text: "${widget.taskPriority.priorityName}\n", style: getPriorityStyle(widget.taskPriority)),
            TextSpan(text: "Due: ${futureTimeToString(widget.task.dueDt)}"),
          ]
        )
      ),
      trailing: PopupMenuButton<MenuItems>(
        onSelected: (MenuItems result){
          if(result == MenuItems.markAsDone){
            handleMarkAsDone();
          }

        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<MenuItems>>[
          const PopupMenuItem<MenuItems>(
            value: MenuItems.markAsDone,
            child: Text("Mark as done")),
          
          const PopupMenuItem<MenuItems>(
            value: MenuItems.edit,
            child: Text("Edit")),
          
          const PopupMenuItem<MenuItems>(
            value: MenuItems.archieve,
            child: Text("Archive")),
          
          const PopupMenuItem<MenuItems>(
            value: MenuItems.delete,
            child: Text("Delete"),
          )
        ],
      )
    );
  }
}

