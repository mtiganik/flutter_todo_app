

import 'package:flutter_todo_app/models/priority.dart';
import 'package:flutter_todo_app/services/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class PriorityService{

  static Future<Priority?> getPriorityById(String priorityId)async{
    DatabaseHelper dbHelper = DatabaseHelper();
    Database db = await dbHelper.database;

    final List<Map<String, dynamic>> maps = await
    db.query('Priority', where: 'id = ?', whereArgs: [priorityId]);
    if(maps.isEmpty) return null;

    return Priority.fromJson(maps.first);
  }

  static Future<List<Priority>?> getAllPriorities() async{
    DatabaseHelper dbHelper = DatabaseHelper();
    Database db = await dbHelper.database;
    
    final List<Map<String, dynamic>> maps = await db.query("Priority");
    if(maps.isEmpty) return null;

    return List.generate(maps.length, (index) => Priority.fromJson(maps[index]));
  }

  static Future<int> addPriority(Priority priority) async{
    DatabaseHelper dbHelper = DatabaseHelper();
    Database db = await dbHelper.database;

    return await db.insert("Priority", priority.toJson(),
    conflictAlgorithm: ConflictAlgorithm.replace);

  }

  static Future<int> updatePriority(Priority priority) async{
    DatabaseHelper dbHelper = DatabaseHelper();
    Database db = await dbHelper.database;

    return await db.update("Priority", priority.toJson(), 
    where: 'id = ?', whereArgs: [priority.id],
    conflictAlgorithm: ConflictAlgorithm.replace);

  }

  static Future<int> deletePriority(Priority priority) async{
    DatabaseHelper dbHelper = DatabaseHelper();
    Database db = await dbHelper.database;

    return await db.delete("Category", where: 'id = ?', whereArgs: [priority.id]);
  }
}