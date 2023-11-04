
import 'dart:convert';

import 'package:flutter_todo_app/api/handle_401_status.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_todo_app/api/api_config.dart';
import 'package:flutter_todo_app/models/priority.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PriorityApi{
  static String url = "${APIConfig.getUrl()}TodoPriorities";

  static Future<Priority?> getPriorityById(String priorityId) async{
    String idUrl = "$url/$priorityId";
    SharedPreferences prefs = await SharedPreferences.getInstance();    

    final response = await http.get(Uri.parse(idUrl),
      headers: {
        'Authorization': 'Bearer ${prefs.getString("token")}'
      },);

    await const LogoutHandle().handle401Status(response.statusCode);

    if(response.statusCode == 200){
      return Priority.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  static Future<List<Priority>?> getAllPriorities() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.get(Uri.parse(url),
      headers: {
        'Authorization': 'Bearer ${prefs.getString("token")}'
      },);
    await const LogoutHandle().handle401Status(response.statusCode);
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String idUrl = "$url/${priority.id}";
    final response = await http.put(
      Uri.parse(idUrl),
      headers:{
        "Content-Type": "application/json",
        'Authorization': 'Bearer ${prefs.getString("token")}'
      },
      body: jsonEncode(priority.toJson()),
    );
    await const LogoutHandle().handle401Status(response.statusCode);
    return response.statusCode;
  }

  static Future<int> addPriority(Priority priority) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.post(
      Uri.parse(url),
      headers:{
        "Content-Type": "application/json",
        'Authorization': 'Bearer ${prefs.getString("token")}'
      },
      body: jsonEncode(priority.toJson()),
    );
    await const LogoutHandle().handle401Status(response.statusCode);
    // 201 success
    return response.statusCode;
  }

  static Future<int> deletePriority(String priorityId) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String idUrl = "$url/$priorityId";
    final response = await http.delete(Uri.parse(idUrl),
      headers: {
        'Authorization': 'Bearer ${prefs.getString("token")}'
      });
    await const LogoutHandle().handle401Status(response.statusCode);

    return response.statusCode;
  }
}