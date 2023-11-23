
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/api/api_methods/category_api.dart';
import 'package:flutter_todo_app/api/api_methods/priority_api.dart';
import 'package:flutter_todo_app/api/api_methods/task_api.dart';
import 'package:flutter_todo_app/models/category.dart';
import 'package:flutter_todo_app/models/priority.dart';
import 'package:flutter_todo_app/models/task.dart';
import 'package:uuid/uuid.dart';

class AddTaskPage extends StatefulWidget{
  const AddTaskPage({super.key});

  @override
  State<StatefulWidget> createState() => _AddTaskPageState();

}

class _AddTaskPageState extends State<AddTaskPage>{
  final _formKey = GlobalKey<FormState>();
  final taskNameController = TextEditingController();
  final dueDtController = TextEditingController();
  
  DateTime selectedDate = DateTime.now();

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
    var fetchPriorities = await PriorityApi.getAllPriorities();
    var fetchCategories = await CategoryApi.getAllCategories();
    setState(() {
      categories = fetchCategories;
      priorities = fetchPriorities;
    });
  }

  Future<void> saveTask() async{
    if(selectedCategory != null && selectedPriority != null){
      String taskName = taskNameController.text;
      String dueDt = dueDtController.text;
      Task newtask = Task(
        id: const Uuid().v4(),
        taskName: taskName,
        isCompleted: false,
        dueDt: dueDt,
        todoCategoryId: selectedCategory!.id,
        todoPriorityId: selectedPriority!.id,
      );
      int response = await TaskApi.addTask(newtask);
      if(context.mounted){
        if (response >= 200 && response < 300) {
          ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Task added!!!!!!')));
          Navigator.pop(context, newtask);

        } else {
          ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error adding new task')));
        }
      }
    }
  }

  Future<void> _selectDateMyWay(BuildContext context) async{
    final DateTime? pickedDate = await showDatePicker(
      context: context, 
      initialDate: DateTime.now(), 
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
      );
      if(pickedDate != null && pickedDate != DateTime.now()){
        dueDtController.text = pickedDate.toLocal().toString().split(' ')[0];
      }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: const Text("Add Task", style: TextStyle(color: Colors.white)),
      backgroundColor: Colors.blue,
    ),body:
     SingleChildScrollView(
      child:
      Padding(
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
                keyboardType: TextInputType.none,
                decoration: const InputDecoration(labelText: "Task due date"),
                validator: (value){
                  if(value == null || value.isEmpty){
                    return 'Please add a date';
                  }return null;
                },
                onTap:(){
                  _selectDateMyWay(context);
                }
              ),
              const SizedBox(height: 16.0),
              DropdownButtonFormField<Category>(
                value: selectedCategory,
                items: categories?.map((category){
                  return DropdownMenuItem<Category>(
                    value: category,
                    child: Text(category.categoryName));
                }).toList(), 
                onChanged: (newValue){
                  setState(() {
                    selectedCategory = newValue;
                  });
                }, decoration: const InputDecoration(labelText: "Select Category", 
                border:OutlineInputBorder()),
                validator:(value){
                  if(value == null){
                    return 'Please select a category';
                  }return null;
                }),
                const SizedBox(height: 16.0),


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
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: (){
                    if(_formKey.currentState!.validate()){
                      saveTask();
                    }
                  }, 
                  child: const Text('Save Task'))
            ],
          )
        )
    )
    ));
  }

@override
void dispose(){
  taskNameController.dispose();
  dueDtController.dispose();
  super.dispose();
}

}