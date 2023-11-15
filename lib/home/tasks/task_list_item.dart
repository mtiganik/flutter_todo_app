

import 'package:flutter/material.dart';
import 'package:flutter_todo_app/api/api_methods/task_api.dart';
import 'package:flutter_todo_app/home/utils/date_parser.dart';
import 'package:flutter_todo_app/home/tasks/task_list_item_methods.dart';
import 'package:flutter_todo_app/models/category.dart';
import 'package:flutter_todo_app/models/priority.dart';
import 'package:flutter_todo_app/models/task.dart';

enum MenuItems {markAsDone, edit, archieve, delete}

class TaskListItem extends StatefulWidget{
  final Task task;
  final Category taskCategory;
  final Priority taskPriority;
  final Function(Task) onUpdate;
  const TaskListItem({super.key, required this.task, required this.taskCategory, required this.taskPriority, required this.onUpdate});

  @override
  State<StatefulWidget> createState() => _TaskListItemState();

}

class _TaskListItemState extends State<TaskListItem>{
  MenuItems? selectedMenuItem;

  Future<void> handleMarkAsDone()async{
     Task updatedTask =  widget.task.copyWith(isCompleted: !widget.task.isCompleted);
    var result = await TaskApi.updateTask(updatedTask);
    if (result >= 200 && result < 300){
      widget.onUpdate(updatedTask);
    }
  }

  void handleLongPress(){
    print("Long pressed ${widget.task.taskName}");
  }
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => handleMarkAsDone(),
      onLongPress: () => handleLongPress(),
      title: Text(widget.task.taskName),
      leading: getIconByCategory(widget.taskCategory),
      subtitle: Text.rich(
        TextSpan(
          children: [
            TextSpan(text: "${previousTimeToString(widget.task.createdDt)}, "),
            TextSpan(text: "${widget.taskPriority.priorityName}\n", style: getPriorityStyle(widget.taskPriority)),
            TextSpan(text: "Due: ${futureTimeToString(widget.task.dueDt)}\n"),
            TextSpan(text: "${widget.taskCategory.categoryName} category,"),
            getIsTaskDoneTextSpan(widget.task.isCompleted)
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

