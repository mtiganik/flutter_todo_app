

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' hide Priority;
import 'package:flutter_todo_app/db_debug/dog.dart';
import 'package:flutter_todo_app/models/priority.dart';
import 'package:flutter_todo_app/services/database_helper.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbDebug extends StatelessWidget{
  DbDebug({super.key});

  void handleInitialization() {
  }

final Priority priority1 = Priority(id: "f123dsfdsfds443232143123", priorityName: "My 3rd priority", prioritySort: 0);

void handleDataAdd() async{
  DatabaseHelper dbHelper = DatabaseHelper();

  Database db = await dbHelper.database;
  var dog =const  Dog(id: 3, name: "REX", age: 3);
  await db.insert('Priority', 
  priority1.toJson(),
  conflictAlgorithm: ConflictAlgorithm.replace);

  print("Data added");
}

void handleDataRead() async{

}



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("In Dogs file"),
        const Text("Press to initialize db1223:"),
        ElevatedButton(onPressed: handleDataAdd, child: const Text("Add data")),
        const Text("Press to load data to db:"),
        ElevatedButton(onPressed: handleDataRead, child: const Text("Read data from db")),

      ],
    );
  }
  
}