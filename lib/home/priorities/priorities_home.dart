

import 'package:flutter/material.dart';
import 'package:flutter_todo_app/api/api_methods/priority_api.dart';
import 'package:flutter_todo_app/home/priorities/add_priority_page.dart';
import 'package:flutter_todo_app/home/priorities/priority_list_item.dart';
import 'package:flutter_todo_app/models/priority.dart';

class PrioritiesHome extends StatefulWidget{
  const PrioritiesHome({super.key});
  
  @override
  State<StatefulWidget> createState() => _PrioritiesHomeState();
}
class _PrioritiesHomeState extends State<PrioritiesHome>{
  Future<List<Priority>?>? prioritiesFuture;

  @override
  void initState(){
    super.initState();
    prioritiesFuture = PriorityApi.getAllPriorities();
  }

  Future<void> handleAddPriorityPress(BuildContext context) async{
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: ((context) => const AddPriorityPage())
      )).then((value){
        if(value == true){
          setState(() {
            prioritiesFuture = PriorityApi.getAllPriorities();
          });
        }
      });
  }
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
              ElevatedButton(
                  onPressed: () {
                    handleAddPriorityPress(context);
                  },
                  child: const Text("Add new")),
            ],
          ),
          FutureBuilder(
            future: prioritiesFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("Error: ${snapshot.error}"),
                );
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(
                  child: Text("No priorities available"),
                );
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    Priority priority = snapshot.data![index];
                    return PriorityListItem(priority: priority);
                  },
                );
              }
            },
          )
        ],
      ),
    );
  }
}
