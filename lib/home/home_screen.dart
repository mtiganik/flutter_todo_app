

import 'package:flutter/material.dart';
import 'package:flutter_todo_app/api/api_methods/category_api.dart';
import 'package:flutter_todo_app/api/api_methods/task_api.dart';
import 'package:flutter_todo_app/api/shared_preferences_config.dart';
import 'package:flutter_todo_app/db/database_helper.dart';
import 'package:flutter_todo_app/db/initial_db_values.dart';
import 'package:flutter_todo_app/home/categories/categories_home.dart';
import 'package:flutter_todo_app/home/priorities/priorities_home.dart';
import 'package:flutter_todo_app/home/task_list.dart';
import 'package:flutter_todo_app/services/category_service.dart';
import 'package:flutter_todo_app/services/task_service.dart';
import 'package:flutter_todo_app/state_mgmt/auth_model.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget{
  const HomeScreen({super.key});

  Future<void> handleLogout(AuthModel authModel) async{
    await SharedPreferencesSettings().removeSharedPrefs();
    authModel.setIsUserLoggedIn(false);
  }

  void handleCategoriesPressed(){
  }

  void handlePrioritiesPressed(){

  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Todo app", style:TextStyle(color: Colors.white)),
      ),
      body:Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(onPressed: (){Navigator.push(context,MaterialPageRoute(builder: ((context) => const CategoriesHome()))); }, child: Text("Categories")),
              ElevatedButton(onPressed: (){Navigator.push(context,MaterialPageRoute(builder: ((context) => const PrioritiesHome()))); }, child: Text("Priorities")),
                Consumer<AuthModel>(builder: (context, authModel, child) {
                  return ElevatedButton(
                      onPressed: () => handleLogout(authModel),
                      child: const Text("Logout"));
                }
        )

            ],
          ),
          const TaskList(),

        ],
      )
    );

  }


}