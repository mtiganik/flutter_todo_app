

import 'package:flutter/material.dart';
import 'package:flutter_todo_app/api/api_methods/task_api.dart';
import 'package:flutter_todo_app/models/task.dart';

class TaskList extends StatefulWidget{
  const TaskList({super.key});

  @override
  State<StatefulWidget> createState() => _TaskListState();

}

class _TaskListState extends State<TaskList>{

  Future<List<Task>?>? tasksFuture;
  @override
  void initState(){
    super.initState();
    tasksFuture =TaskApi.getAllTasks();
  }
  // This method retrieves tasks from API:

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
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index){
              Task task = snapshot.data![index];
              return ListTile(
                title: Text(task.taskName)
              );
            }
            );
        }
      }
    );
  }

}