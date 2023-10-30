
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_todo_app/api/api_config.dart';
import 'package:flutter_todo_app/models/task.dart';

class TaskApi{
  static String url = "${APIConfig.getUrl()}TodoTasks";

  static Future<Task?> getTaskById(String taskId, String token) async{
    String idUrl = "$url/$taskId";
    final response = await http.get(Uri.parse(idUrl),
      headers: {
        'Authorization': 'Bearer $token'
      });
    if(response.statusCode == 200){
      return Task.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  static Future<List<Task>?> getAllTasks(String token) async{
    final response = await http.get(Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token'
      });
    if(response.statusCode == 200){
      final List<dynamic> data = jsonDecode(response.body);
      final tasks = data.map((task) 
      => Task.fromJson(task)).toList();
      return tasks;
    }else{
      return null;
    }
  }

  static Future<int> addTask(Task task, String token) async{
    final response = await http.post(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(task.toJson()),
    );
    return response.statusCode;
  }

  static Future<int> updateTask(Task task, String token) async{
    String idUrl= "$url/${task.id}";
    final response = await http.put(
      Uri.parse(idUrl),
      headers:{
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(task.toJson()),
    );
    return response.statusCode;
  }

  static Future<int> deleteTask(Task task, String token) async{
    String idUrl = "$url/${task.id}";
    final response = await http.delete(Uri.parse(idUrl),
      headers: {
        'Authorization': 'Bearer $token'
      });

    return response.statusCode;
  }

  static Future<List<Task>?> getTasksByCategoryId(String categoryId, String token) async{
    List<Task>? tasks = await getAllTasks(token);
    if(tasks != null){
      return tasks.where((task) => task.todoCategoryId == categoryId).toList();
    }
    return null;
  }

  static Future<List<Task>?> getTasksByPriorityId(String priorityId, String token) async{
    List<Task>? tasks = await getAllTasks(token);
    if(tasks != null){
      return tasks.where((task) => task.todoPriorityId == priorityId).toList();
    }
    return null;
  }

  static Future<List<Task>?> getIsDoneTasks(String token) async{
    List<Task>? tasks = await getAllTasks(token);
    if(tasks != null){
      return tasks.where((task) => task.isCompleted == true).toList();
    }
    return null;
  }

  static Future<List<Task>?> getNotDoneTasks(String token) async{
    List<Task>? tasks = await getAllTasks(token);
    if(tasks != null){
      return tasks.where((task) => task.isCompleted == false).toList();
    }
    return null;
  }
}