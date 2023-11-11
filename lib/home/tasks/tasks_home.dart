

import 'package:flutter/material.dart';
import 'package:flutter_todo_app/api/api_methods/category_api.dart';
import 'package:flutter_todo_app/api/api_methods/priority_api.dart';
import 'package:flutter_todo_app/api/api_methods/task_api.dart';
import 'package:flutter_todo_app/home/tasks/task_list_item.dart';
import 'package:flutter_todo_app/models/category.dart';
import 'package:flutter_todo_app/models/priority.dart';
import 'package:flutter_todo_app/models/task.dart';
import 'package:collection/collection.dart';

class TasksHome extends StatefulWidget{
  const TasksHome({super.key});

  @override
  State<StatefulWidget> createState() => _TasksHomeState();

}

class _TasksHomeState extends State<TasksHome>{

  Future<List<Task>?>? tasksFuture;
  List<Task>? tasks;
  List<Priority>? priorities;
  List<Category>? categories;
  @override
  void initState(){
    super.initState();
    initializeInMemoryElements();
    tasksFuture =TaskApi.getAllTasks();
  }
  Future<void> initializeInMemoryElements() async{
    final List<Task>? updatedTasks = await TaskApi.getAllTasks();
    final List<Priority>? updatedPriorities = await PriorityApi.getAllPriorities();
    final List<Category>? updatedCategories = await CategoryApi.getAllCategories();
    setState((){
      priorities = updatedPriorities;
      tasks = updatedTasks;
      categories = updatedCategories;
    });
  }

  Priority? getPriorityById(String? priorityId){
    return priorities?.cast<Priority?>().firstWhere((element) => element?.id == priorityId, orElse: () => null);
  }

  Category? getCategoryById(String? categoryId){
    return categories?.cast<Category?>().firstWhere((element) => element?.id == categoryId, orElse: () => null);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Task>?>(
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
            itemCount: tasks?.length ?? 0,
            itemBuilder: (context, index){
              Task? task = tasks?[index];
              Category? category = getCategoryById(task?.todoCategoryId);
              Priority? priority = getPriorityById(task?.todoPriorityId);
              return task != null && category != null && priority != null
              ? TaskListItem(task: task, taskCategory: category, taskPriority: priority)
              : const SizedBox.shrink();
              
            });
        }
      }
    );
  }

}