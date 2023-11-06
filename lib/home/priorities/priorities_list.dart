import 'package:flutter/material.dart';
import 'package:flutter_todo_app/api/api_methods/priority_api.dart';
import 'package:flutter_todo_app/home/priorities/priority_list_item.dart';
import 'package:flutter_todo_app/models/priority.dart';

class PrioritiesList extends StatefulWidget {
  const PrioritiesList({super.key});

  @override
  State<StatefulWidget> createState() => _PrioritiesListState();
}

class _PrioritiesListState extends State<PrioritiesList> {
  Future<List<Priority>?>? prioritiesFuture;

  @override
  void initState() {
    super.initState();
    prioritiesFuture = PriorityApi.getAllPriorities();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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
    );
  }
}
