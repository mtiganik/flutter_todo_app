

import 'package:flutter_todo_app/models/user.dart';
import 'package:flutter_todo_app/db/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class UserService{

// business logic is that there is only one user in users table.

  static Future<int> addUser(User user) async{

    Database db = await DatabaseHelper().database;
    final List<Map<String, dynamic>> userMaps = await db.query("User");
    if(userMaps.isEmpty){
      // no user, we are allowed to add an user
    return await db.insert("User", user.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    }
    throw StateError("There is already user in db. delete all users to add a new one");
  }

  static Future<int> updateUser(User user) async{
    Database db = await DatabaseHelper().database;
    return await db.update("User", user.toJson(), where: 'firstName = ?', whereArgs: [user.firstName],
    conflictAlgorithm: ConflictAlgorithm.replace);
  }


  static Future<User?> getUser() async{
    Database db = await DatabaseHelper().database;
    final List<Map<String, dynamic>> maps = await db.query("User");
    if(maps.isEmpty){
      return null;
    }
    return List.generate(maps.length, (index) => User.fromJson(maps[index], 0, ""))[0];
  }
    static Future<int> deleteUserData() async{
    Database db = await DatabaseHelper().database;
    return await db.rawDelete("DELETE FROM User");
  }

}