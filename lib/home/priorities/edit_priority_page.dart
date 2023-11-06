

import 'package:flutter/material.dart';
import 'package:flutter_todo_app/models/priority.dart';

class EditPriorityPage extends StatefulWidget{
  final Priority priority;
  const EditPriorityPage({super.key, required this.priority});

  @override
  State<StatefulWidget> createState() => _EditPriorityPageState();
}

class _EditPriorityPageState extends State<EditPriorityPage>{
  @override
  Widget build(BuildContext context) {
    return Text("Edit page of priority: ${widget.priority.priorityName}");

  }

}