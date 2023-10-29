

import 'package:flutter_todo_app/models/user.dart';
import 'package:flutter_todo_app/db/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class UserService{

  static Future<int> addUser(User user) async{
      DatabaseHelper dbHelper = DatabaseHelper();
      Database db = await dbHelper.database;
      return await db.insert("User", user.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateUser(User user) async{
    DatabaseHelper dbHelper = DatabaseHelper();
    Database db = await dbHelper.database;
    return await db.update("User", user.toJson(), where: 'firstName = ?', whereArgs: [user.firstName],
    conflictAlgorithm: ConflictAlgorithm.replace);
  }


  static Future<List<User>?> getAllUser() async{
    DatabaseHelper dbHelper = DatabaseHelper();
    Database db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query("User");
    if(maps.isEmpty){
      return null;
    }
    return List.generate(maps.length, (index) => User.fromJson(maps[index], 0, ""));
  }
    static Future<int> deleteUser(User user) async{
    DatabaseHelper dbHelper = DatabaseHelper();
    Database db = await dbHelper.database;
    return await db.delete("User", where: 'firstName = ?', whereArgs: [user.firstName]
    );
  }

}