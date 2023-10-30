
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_todo_app/api/api_config.dart';
import 'package:flutter_todo_app/models/priority.dart';

class PriorityApi{
  static String url = "${APIConfig.getUrl()}TodoPriorities";

  static Future<Priority?> getPriorityById(String priorityId) async{
    String idUrl = "$url/$priorityId";
    final response = await http.get(Uri.parse(idUrl));
    if(response.statusCode == 200){
      return Priority.fromJson(jsonDecode(response.body));
    }
  }

  static Future<List<Priority>?> getAllPriorities() async{
    final response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      final List<dynamic> data = jsonDecode(response.body);
      final priorities = data.map((priority) 
      =>Priority.fromJson(priority)).toList();
      return priorities;
    }else {
      return null;
    }
  }

  static Future<int> updatePriority(Priority priority) async{
    String idUrl = "$url/${priority.id}";
    final response = await http.put(
      Uri.parse(idUrl),
      headers:{
        "Content-Type": "application/json",
      },
      body: jsonEncode(priority.toJson()),
    );
    return response.statusCode;
  }

  static Future<int> addPriority(Priority priority) async{
    final response = await http.post(
      Uri.parse(url),
      headers:{
        "Content-Type": "application/json",
      },
      body: jsonEncode(priority.toJson()),
    );
    // 201 success
    return response.statusCode;
  }

  static Future<int> deletePriority(String priorityId) async{
    String idUrl = "$url/$priorityId";
    final response = await http.delete(Uri.parse(idUrl));

    return response.statusCode;
  }
}