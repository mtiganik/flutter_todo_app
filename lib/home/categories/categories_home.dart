

import 'package:flutter/material.dart';
import 'package:flutter_todo_app/home/categories/add_category_page.dart';
import 'package:flutter_todo_app/home/categories/categories_list.dart';

class CategoriesHome extends StatelessWidget{
  const CategoriesHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories", style: TextStyle(color:Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              ElevatedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: ((context) =>  AddCategoryPage()))); }, child: const Text("Add new")),
            ]
          ),
          const CategoriesList(),
        ],
      )
    );

  }

}