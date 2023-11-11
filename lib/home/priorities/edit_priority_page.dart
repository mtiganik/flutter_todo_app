

import 'package:flutter/material.dart';
import 'package:flutter_todo_app/api/api_methods/priority_api.dart';
import 'package:flutter_todo_app/models/priority.dart';

class EditPriorityPage extends StatefulWidget{
  final Priority priority;
  const EditPriorityPage({super.key, required this.priority});

  @override
  State<StatefulWidget> createState() => _EditPriorityPageState();
}

class _EditPriorityPageState extends State<EditPriorityPage>{
  final _formKey = GlobalKey<FormState>();
  final priorityNameController = TextEditingController();
  final prioritySortController = TextEditingController();

Future<Priority?> updatePriority() async{
  Priority newPriority = Priority(
    id: widget.priority.id,
    priorityName: priorityNameController.text,
    prioritySort: int.parse(prioritySortController.text)
  );
  var response = await PriorityApi.updatePriority(newPriority);
  if(response >= 200 && response <300){return newPriority;}
  else {return null;}
}

Future<void> handleEditButtonPress() async{
  if(_formKey.currentState!.validate()){
    var updatedPriority = await updatePriority();
    if(context.mounted){
      if(updatedPriority == null){
        ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error editing priority')));
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Updated priority')));
        Navigator.pop(context, updatedPriority);
      }
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit ${widget.priority.priorityName} priority")),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child:Form(
        key:_formKey,
        child: Column(
          children: [
            TextFormField(
              controller: priorityNameController,
              decoration: const InputDecoration(labelText: "Priority name"),
              validator: (value){
                if(value == null || value.isEmpty){
                  return 'Please enter a priority name';
                }return null;
              },
            ),
          const SizedBox(height: 16,),
          TextFormField(
            controller: prioritySortController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: "Priority sort"),
            validator: (value){
              if(value == null || value.isEmpty){
                return 'Please enter priority sort';
              }return null;
            }),
            const SizedBox(height: 16,),
            ElevatedButton(
              onPressed: handleEditButtonPress, 
              child: const Text("Save changes")),
          ],
        )
      )
      ),
    );

  }

  @override
  void dispose(){
    priorityNameController.dispose();
    prioritySortController.dispose();
    super.dispose();
  }

}