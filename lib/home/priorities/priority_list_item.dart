

import 'package:flutter/material.dart';
import 'package:flutter_todo_app/home/priorities/edit_priority_page.dart';
import 'package:flutter_todo_app/home/utils/deleteConfirmationDialog.dart';
import 'package:flutter_todo_app/models/priority.dart';

class PriorityListItem extends StatefulWidget{
  final Priority priority;
  final Function(Priority) onPriorityUpdate;

  const PriorityListItem({super.key, required this.priority, required this.onPriorityUpdate});
  
  @override
  State<StatefulWidget> createState() => _PriorityListItemState();

}

class _PriorityListItemState extends State<PriorityListItem>{
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.priority.priorityName),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context){
            return EditPriorityPage(priority: widget.priority);
          })).then((value) => {widget.onPriorityUpdate(value)});
      },
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: ()async{
          showDeleteConfirmationDialog(context);
        },
      ),
    );
  }

Future<void> showDeleteConfirmationDialog(BuildContext context) async{
 final result = await showDialog<bool>(
  context: context,
  builder: (context){
    return const DeleteConfirmationDialog(
      title: "Delete Priority", 
      content: "Are you sure you want to delete this priority?");
  }
 );

 if(result != null && result){
  print("Pressed delete");
 }
}

}