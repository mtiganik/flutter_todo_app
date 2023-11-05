

import 'package:flutter/material.dart';
import 'package:flutter_todo_app/home/priorities/add_priority_page.dart';
import 'package:flutter_todo_app/home/priorities/priorities_list.dart';

class PrioritiesHome extends StatelessWidget{
  const PrioritiesHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Priorities", style: TextStyle(color:Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: ((context) =>  AddPriorityPage()))); }, child: const Text("Add new")),
            ],
          ),
          const PrioritiesList()
        ],
      ),
    );

  }

}