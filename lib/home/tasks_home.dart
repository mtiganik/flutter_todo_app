

import 'package:flutter/material.dart';
import 'package:flutter_todo_app/api/api_methods/category_api.dart';
import 'package:flutter_todo_app/api/api_methods/priority_api.dart';
import 'package:flutter_todo_app/api/api_methods/task_api.dart';
import 'package:flutter_todo_app/home/tasks/add_task_page.dart';
import 'package:flutter_todo_app/home/tasks/task_list_item.dart';
import 'package:flutter_todo_app/home/utils/popup_menu.dart';
import 'package:flutter_todo_app/models/category.dart';
import 'package:flutter_todo_app/models/priority.dart';
import 'package:flutter_todo_app/models/task.dart';
import 'package:collection/collection.dart';
import 'package:toggle_switch/toggle_switch.dart';


class TasksHome extends StatefulWidget{
  const TasksHome({super.key});

  @override
  State<StatefulWidget> createState() => _TasksHomeState();

}

class _TasksHomeState extends State<TasksHome>{

  Future<List<Task>?>? tasksFuture;
  List<Task>? displayTasks;
  List<Task>? allTasks;
  List<Priority>? priorities;
  List<Category>? categories;
  int? initialDoneNotDoneToggleSwitch;
  @override
  void initState(){
    super.initState();
    initializeInMemoryElements();
    tasksFuture =TaskApi.getAllTasks();
    initialDoneNotDoneToggleSwitch = 0;
  }
  Future<void> initializeInMemoryElements() async{
    final List<Task>? updatedTasks = await TaskApi.getAllTasks();
    final List<Priority>? updatedPriorities = await PriorityApi.getAllPriorities();
    final List<Category>? updatedCategories = await CategoryApi.getAllCategories();
    setState((){
      priorities = updatedPriorities;
      displayTasks = updatedTasks;
      allTasks = updatedTasks;
      categories = updatedCategories;
    });
  }
  Future<void> handleAddTaskPress(BuildContext context)async{
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (((context) => const AddTaskPage()))
    )).then((value){
      if(value is Task){
        setState(() {
          displayTasks?.insert(0, value);
        });
      }
    });
  }

  Priority? getPriorityById(String? priorityId){
    return priorities?.cast<Priority?>().firstWhere((element) => element?.id == priorityId, orElse: () => null);
  }

  Category? getCategoryById(String? categoryId){
    return categories?.cast<Category?>().firstWhere((element) => element?.id == categoryId, orElse: () => null);
  }

  void handleDoneNotDoneToggleSwith(index){
    int indexCopy = index;
    setState(() {
      initialDoneNotDoneToggleSwitch = index;
      if(indexCopy == 0){displayTasks = allTasks;}
      else if(indexCopy == 1){displayTasks = allTasks?.where((element) => element.isCompleted == true).toList();}
      else if(indexCopy == 2){displayTasks = allTasks?.where((element) => element.isCompleted == false).toList();}
    });
  }


  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Todo app", style:TextStyle(color: Colors.white)),

          actions: const [
  PopupMenu()
          ],
  ),
      body: 
Column(children: [
  Row(
    children: [
  ToggleSwitch(
  initialLabelIndex: initialDoneNotDoneToggleSwitch,
  totalSwitches: 3,
  activeBgColor: const [Colors.blue],
  labels: const ['All tasks', 'Done', 'Not done'],
  customWidths: const [90,70,90],
  onToggle: (index) {
    handleDoneNotDoneToggleSwith(index);
    print("Index");
  },
),
ElevatedButton(onPressed: (){handleAddTaskPress(context);}, child: const Text("Add new"))
  ]),

  Expanded(child: 
      SingleChildScrollView(
        child: 
    FutureBuilder<List<Task>?>(
      future: tasksFuture,
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator(),);
        } else if (snapshot.hasError){
          return Center(child: Text('Error: ${snapshot.error}'),);
        } else if(!snapshot.hasData || snapshot.data!.isEmpty){
          // no data to display
          return const Center(child: Text('No tasks available.'),);
        } else{
          // display data
          return ListView.builder(
            shrinkWrap: true,
            itemCount: displayTasks?.length ?? 0,
            physics:const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index){
              Task? task = displayTasks?[index];
              Category? category = getCategoryById(task?.todoCategoryId);
              Priority? priority = getPriorityById(task?.todoPriorityId);
              return task != null && category != null && priority != null
              ? TaskListItem(task: task, taskCategory: category, taskPriority: priority)
              : const SizedBox.shrink();
              
            });
        }
      }
    )
)),
],)
);}

}