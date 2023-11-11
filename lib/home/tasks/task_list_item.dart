

import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("${widget.task.taskName}, cat: ${widget.taskCategory.categoryName}, pri: ${widget.taskPriority.priorityName}"),
    );

  }

}