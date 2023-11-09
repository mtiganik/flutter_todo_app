

import 'package:flutter/material.dart';
import 'package:flutter_todo_app/api/api_methods/priority_api.dart';
import 'package:flutter_todo_app/models/priority.dart';
import 'package:uuid/uuid.dart';

class AddPriorityPage extends StatefulWidget{
  const AddPriorityPage({super.key});
  
  @override
  State<StatefulWidget> createState() => _AddPriorityPageState();

}

class _AddPriorityPageState extends State<AddPriorityPage>{

  final _formKey = GlobalKey<FormState>();
  final priorityNameController = TextEditingController();
  final prioritySortController = TextEditingController();

  Future<bool> handleDataAdd() async{
    Priority priority = Priority(
      id: const Uuid().v4(),
      priorityName: priorityNameController.text,
      prioritySort: int.parse(prioritySortController.text)
    );
    var result = await PriorityApi.addPriority(priority);
    if(result == 201){return true;}
    else{return false;}
  }

  Future<void> handleAddPriorityPress() async{
    if(_formKey.currentState!.validate()){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );
      var postResult = await handleDataAdd();
      if(context.mounted){
        if(postResult){
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("New priority added"))
          );
          Navigator.pop(context,true); // true indicates to refresh current priority list
        }else{
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Error adding new priority"))
          );
        }
      }
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: const Text("Add Priority", style:TextStyle(color: Colors.white)),
    backgroundColor: Colors.blue,
    ),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key:_formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Priority Name"),
            TextFormField(
              controller: priorityNameController,
              validator: (value){
                if (value == null || value.isEmpty){
                  return 'Please enter some text';
                }return null;
              },
              decoration: const InputDecoration(
                hintText: 'Enter Priority name'
              )
            ),
            const SizedBox(height: 20,),
            const Text("Priority sort"),
            TextFormField(
              controller: prioritySortController,
              keyboardType: TextInputType.number,
              validator: (value){
                if(value == null || value.isEmpty){
                  return "Invalid input";
                }return null;
              },
              decoration: const InputDecoration(
                hintText: "Enter priority sort"
              ),
            ),
            const SizedBox(height:20),
            ElevatedButton(
            onPressed:  handleAddPriorityPress,
            child: const Text("Add priority"))
          ],
        ),
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