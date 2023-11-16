
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/api/api_methods/category_api.dart';
import 'package:flutter_todo_app/api/api_methods/priority_api.dart';
import 'package:flutter_todo_app/models/category.dart';
import 'package:flutter_todo_app/models/priority.dart';
import 'package:flutter_todo_app/models/task.dart';

class AddTaskPage extends StatefulWidget{
  const AddTaskPage({super.key});

  @override
  State<StatefulWidget> createState() => _AddTaskPageState();

}

class _AddTaskPageState extends State<AddTaskPage>{
  final _formKey = GlobalKey<FormState>();
  final taskNameController = TextEditingController();
  final dueDtController = TextEditingController();
  
  Category? selectedCategory;
  Priority? selectedPriority;
  List<Category>? categories;
  List<Priority>? priorities;
  @override
  void initState(){
    super.initState();
    initializeData();
  }
  Future<void> initializeData() async{
    priorities = await PriorityApi.getAllPriorities();
    categories = await CategoryApi.getAllCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: const Text("Add Task", style: TextStyle(color: Colors.white)),
      backgroundColor: Colors.blue,
    ),body: SingleChildScrollView(
      child:Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: taskNameController,
                decoration: const InputDecoration(labelText: "Task name"),
                validator: (value){
                  if(value == null || value.isEmpty){
                    return 'Please enter task name';
                  }return null;
                },
              ),
              TextFormField(
                controller: dueDtController,
                keyboardType: TextInputType.datetime,
                decoration: const InputDecoration(labelText: "Task due date"),
                validator: (value){
                  if(value == null || value.isEmpty){
                    return 'Please add a date';
                  }return null;
                },
              ),
              const SizedBox(height: 16.0),
              DropdownButtonFormField<Priority>(
                value: selectedPriority,
                items: priorities?.map((priority){
                  return DropdownMenuItem<Priority>(
                    value: priority,
                    child: Text(priority.priorityName));
                }).toList(), 
                onChanged: (newValue){
                  setState(() {
                    selectedPriority = newValue;
                  });
                }, decoration: const InputDecoration(labelText: "Select Priority", 
                border:OutlineInputBorder()),
                validator:(value){
                  if(value == null){
                    return 'Please select a priority';
                  }return null;
                }),


            ],
          )

        )

    ))
    
    );
  }

@override
void dispose(){
  taskNameController.dispose();
  dueDtController.dispose();
  super.dispose();
}

}