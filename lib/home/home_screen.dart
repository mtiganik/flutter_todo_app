

import 'package:flutter/material.dart';
import 'package:flutter_todo_app/api/api_methods/category_api.dart';
import 'package:flutter_todo_app/api/api_methods/task_api.dart';
import 'package:flutter_todo_app/db/database_helper.dart';
import 'package:flutter_todo_app/db/initial_db_values.dart';
import 'package:flutter_todo_app/services/category_service.dart';
import 'package:flutter_todo_app/services/task_service.dart';
import 'package:flutter_todo_app/state_mgmt/auth_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget{
  const HomeScreen({super.key});

  Future<void> handleApi() async{

  }

  Future<void> handleLogout(AuthModel authModel) async{

  }
  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Text("From home Screen"),
        ElevatedButton(onPressed: handleApi, child: Text("Api testing")),

        Text("Logout"),
        Consumer<AuthModel>(
          builder:(context, authModel, child){
            return ElevatedButton(
              onPressed: () => handleLogout(authModel), 
              child: Text("Logout testing"));
          }
        )
      ],
    );

  }


}