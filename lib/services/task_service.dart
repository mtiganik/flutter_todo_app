

import 'package:flutter_todo_app/models/task.dart';
import 'package:flutter_todo_app/services/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class TaskService{

  static Future<Task?> getTaskById(String taskId) async{
    DatabaseHelper dbHelper = DatabaseHelper();
    Database db = await dbHelper.database;

    final List<Map<String, dynamic>> maps = await 
    db.query('Task', where: 'id = ?', whereArgs: [taskId]);
    if(maps.isEmpty) return null;

    return Task.fromJson(maps.first);
  }

  static Future<List<Task>?> getAllTasks() async{
    DatabaseHelper dbHelper = DatabaseHelper();
    Database db = await dbHelper.database;

    final List<Map<String, dynamic>> maps = await db.query('Task');
    if(maps.isEmpty) return null;

    return List.generate(maps.length, (index) => Task.fromJson(maps[index]));
  }

  static Future<int> addTask(Task task) async{
    DatabaseHelper dbHelper = DatabaseHelper();
    Database db = await dbHelper.database;

    return await db.insert('Task', task.toJson(),
    conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateTask(Task task) async{
    DatabaseHelper dbHelper = DatabaseHelper();
    Database db = await dbHelper.database;
    return await db.update('Task',task.toJson(),
     where: 'id = ?', whereArgs: [task.id]);
  }

  static Future<int> deleteTask(Task task) async{
    DatabaseHelper dbHelper = DatabaseHelper();
    Database db = await dbHelper.database;

    return await db.delete('Task', where: 'id = ?', whereArgs: [task.id]);
  }

  static Future<List<Task>?> getTasksByCategoryId(String categoryId)async{
    DatabaseHelper dbHelper = DatabaseHelper();
    Database db = await dbHelper.database;

    final List<Map<String, dynamic>> maps = 
    await db.query('Task', where: 'categoryId = ?', whereArgs: [categoryId]);
    if(maps.isEmpty) return null;

    return List.generate(maps.length, (index) => Task.fromJson(maps[index]));
  }

  static Future<List<Task>?> getTasksByPriorityId(String priorityId)async{
    DatabaseHelper dbHelper = DatabaseHelper();
    Database db = await dbHelper.database;

    final List<Map<String, dynamic>> maps =
    await db.query('Task', where: 'priorityId = ?', whereArgs: [priorityId]);
    if(maps.isEmpty) return null;

    return List.generate(maps.length, (index) => Task.fromJson(maps[index]));
  }

  static Future<List<Task>?> getIsDoneTasks()async{
    // TODO Implement
    throw UnimplementedError();

  }

  static Future<List<Task>?> getNotDoneTasks()async{
        // TODO Implement
    throw UnimplementedError();

  }
}