import 'package:flutter/material.dart';
import 'package:flutter_todo_app/models/category.dart';
import 'package:flutter_todo_app/models/priority.dart';

TextSpan getIsTaskDoneTextSpan(bool isDone){
    if(isDone){
      return 
        const TextSpan(children: [
        WidgetSpan(child: Icon(Icons.check_circle, color: Colors.green,)),
        TextSpan(text: "Done", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green))
        ]
      );
    }
    else {
      return const TextSpan(children: [
        WidgetSpan(child: Icon( Icons.highlight_off, color: Colors.orange,)),
        TextSpan(text: "Not done",style: TextStyle( color: Colors.orange))
      ]);
    }
  }

  TextStyle getPriorityStyle(Priority priority){
    if(priority.prioritySort >= 10) {return const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold);} 
    else if(priority.prioritySort >= 5){return const TextStyle();}
    else {return const TextStyle(color: Colors.lightGreen);}
  } 

  Icon getIconByCategory(Category category){
    if(category.categoryName == "Home") {return const Icon(Icons.home);}
    else if(category.categoryName == "Work") {return const Icon(Icons.work);}
    else if(category.categoryName == "School") {return const Icon(Icons.school);}
    else if(category.categoryName == "Other") {return const Icon(Icons.other_houses);}
    else {return const Icon(Icons.question_mark);}
  }
