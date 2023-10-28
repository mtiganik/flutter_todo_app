

import 'package:flutter_todo_app/models/category.dart';
import 'package:sqflite/sqflite.dart';

import '../db/database_helper.dart';

class CategoryService {

  static Future<Category?> getCategoryById(String categoryId) async{
    Database db = await DatabaseHelper().database;

    final List<Map<String, dynamic>> maps = await 
    db.query('Category', where: 'id = ?', whereArgs: [categoryId]);
    if(maps.isEmpty){
      return null;
    }
      return Category.fromJson(maps.first);
  }

  static Future<List<Category>?> getAllCategories() async{
    Database db = await DatabaseHelper().database;

    final List<Map<String,dynamic>> maps = await db.query("Category");
    if(maps.isEmpty){
      return null;
    }

    return List.generate(maps.length, (index) => Category.fromJson(maps[index]));
  }


  static Future<int> addCategory(Category category) async{
    Database db = await DatabaseHelper().database;

    return await db.insert("Category", category.toJson(),
    conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateCategory(Category category) async{
    Database db = await DatabaseHelper().database;

    return await db.update("Category", category.toJson(), 
    where: 'id = ?', whereArgs: [category.id],
    conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteCategory(Category category) async{
    Database db = await DatabaseHelper().database;

    return await db.delete("Category", where: "id = ?", whereArgs: [category.id]);
  }

}