

import 'package:flutter_todo_app/models/user.dart';
import 'package:flutter_todo_app/services/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class UserService{

final DatabaseHelper _dbHelper;

UserService(this._dbHelper);
static UserService create(){
  return UserService(DatabaseHelper());
}
   Future<int> addUser(User user) async{
      Database db = await _dbHelper.database;
      return await db.insert("User", user.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace);
  }

   Future<int> updateUser(User user) async{

    Database db = await _dbHelper.database;
    return await db.update("User", user.toJson(), where: 'firstName = ?', whereArgs: [user.firstName],
    conflictAlgorithm: ConflictAlgorithm.replace);
  }

     Future<int> deleteUser(User user) async{

    Database db = await _dbHelper.database;
    return await db.delete("User", where: 'firstName = ?', whereArgs: [user.firstName]
    );
  }

   Future<List<User>?> getAllUser() async{

    Database db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query("User");
    if(maps.isEmpty){
      return null;
    }
    return List.generate(maps.length, (index) => User.fromJson(maps[index]));
  }

}