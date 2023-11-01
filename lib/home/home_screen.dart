

import 'package:flutter/material.dart';
import 'package:flutter_todo_app/api/api_methods/category_api.dart';
import 'package:flutter_todo_app/api/api_methods/task_api.dart';
import 'package:flutter_todo_app/services/category_service.dart';
import 'package:flutter_todo_app/state_mgmt/auth_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget{
  const HomeScreen({super.key});

  Future<void> handleApi() async{
    var categoriesFromDB = await CategoryService.getAllCategories();
    var categoriesFromApi = await CategoryApi.getAllCategories();
    var tasksFromApi = await TaskApi.getAllTasks();
    if(categoriesFromApi != null){
    for (var item in categoriesFromApi) {
        print(item);
      }
    }
if (tasksFromApi != null) {
      for (var item in tasksFromApi) {
        print(item);
      }
    }
  }

  Future<void> handleLogout(AuthModel authModel) async{

    authModel.setIsUserLoggedIn(false);

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