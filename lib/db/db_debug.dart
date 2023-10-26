

import 'package:flutter/foundation.dart' hide Category;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' hide Priority;
import 'package:flutter_todo_app/models/category.dart';
import 'package:flutter_todo_app/models/priority.dart';
import 'package:flutter_todo_app/models/user.dart';
import 'package:flutter_todo_app/db/database_helper.dart';
import 'package:flutter_todo_app/services/user_service.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbDebug extends StatelessWidget{
  DbDebug({super.key});

  void handleInitialization() {
  }

final Priority priority1 = Priority(id: "f123dsfdsfds443232143123", priorityName: "My 3rd priority", prioritySort: 0);
final User user1 = User(token: "dsfdsfsfds", refreshToken: "fdsfdsfsd", firstName: "Mihkel", lastName: "Tiganik");
final Category category1 = Category(id: "dsaasddsa", categoryName: "Home", categorySort: 0);

void handleDataAdd() async{
  DatabaseHelper dbHelper = DatabaseHelper();

  Database db = await dbHelper.database;

  await db.insert('category', 
  category1.toJson(),
  conflictAlgorithm: ConflictAlgorithm.replace);

  print("Data added");
}

void handleDataRead() async{
  // UserService userService = UserService();
  final User user2 = User(token: "gfdgfdasdg", refreshToken: "vcxvxc", firstName: "Annu1", lastName: "Suurmänd");
  // var userService = UserService.create();
  var id = await UserService.addUser(user2);
  print(id);
  print("Data added");
  // if(users != null) for (var e in users) print('${e.firstName} ${e.lastName}');
//  var id = await UserService.updateUser(user2); 

//  print(id);

}



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("In Dogs file"),
        const Text("Press to initialize db:"),
        ElevatedButton(onPressed: handleDataAdd, child: const Text("Add data")),
        const Text("Press to load data to db12:"),
        ElevatedButton(onPressed: handleDataRead, child: const Text("Read data from db")),

      ],
    );
  }
  
}