import 'package:flutter/foundation.dart' hide Category;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' hide Priority;
import 'package:flutter_todo_app/db/initial_db_values.dart';
import 'package:flutter_todo_app/models/category.dart';
import 'package:flutter_todo_app/models/priority.dart';
import 'package:flutter_todo_app/models/user.dart';
import 'package:flutter_todo_app/db/database_helper.dart';
import 'package:flutter_todo_app/services/category_service.dart';
import 'package:flutter_todo_app/services/user_service.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbDebug extends StatelessWidget {
  DbDebug({super.key});

  void handleInitialization() {}

  final Priority priority1 = Priority(
      id: "f123dsfdsfds443232143123",
      priorityName: "My 3rd priority",
      prioritySort: 0);
  final User user1 = User(
      token: "dsfdsfsfds",
      refreshToken: "fdsfdsfsd",
      firstName: "Mihkel",
      lastName: "Tiganik");
  final Category category1 =
      Category(id: "dsaasddsa", categoryName: "Home", categorySort: 0);


  void handleDataRead() async {
    DatabaseHelper dbHelper = DatabaseHelper();
    //Database db = await dbHelper.database;

    // await dbHelper.deleteDb();
    // await dbHelper.initDatabase();

    var tables = await dbHelper.getAllTableNames();
    if (tables != null) {
      for (var table in tables) {
        print(table);
      }
    }
    // await InitialDbValues.addCategories();

    // await InitialDbValues.addPriorities();
    // await InitialDbValues.addTask();

    // print("Deleted db");


//  print(id);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("In Dogs file"),
        const Text("Press to load data to db1234:"),
        ElevatedButton(
            onPressed: handleDataRead, child: const Text("Read data from db")),
      ],
    );
  }
}
