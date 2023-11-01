import 'dart:convert';
import 'package:flutter_todo_app/api/api_config.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_todo_app/models/category.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import your Category model

class CategoryApi {
  static String url = "${APIConfig.getUrl()}TodoCategories";

  static Future<Category?> getCategoryById(String categoryId) async {
    String idUrl = "$url/$categoryId";
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await http.get(Uri.parse(idUrl), 
    headers: {
     'Authorization' : 'Bearer ${prefs.getString("token")}' 
    }
    );

    if (response.statusCode == 200) {
      return Category.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  static Future<List<Category>?> getAllCategories() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await http
        .get(Uri.parse(url), 
        headers: {'Authorization': 'Bearer ${prefs.getString("token")}'}
        );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      final categories = data.map((category) => Category.fromJson(category)).toList();
      return categories;
    } else {
      return null;
    }
  }

  static Future<int> updateCategory(Category category) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

    String idUrl = "$url/${category.id}";
    final response = await http.put(
      Uri.parse(idUrl),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer ${prefs.getString("token")}'
      },
      body: jsonEncode(category.toJson()),
    );
    return response.statusCode;
  }

  static Future<int> addCategory(Category category) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await http.post(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer ${prefs.getString("token")}'
      },
      body: jsonEncode(category.toJson()),
    );
    // 201 succesfull
    return response.statusCode;
  }

  static Future<int> deleteCategory(String categoryId) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

    String idUrl = "$url/$categoryId";
    final response = await http.delete(Uri.parse(idUrl),
      headers: {
        'Authorization': 'Bearer ${prefs.getString("token")}'
      },
);

    // 204 No Content indicates a successful deletion
    return response.statusCode;
  }
}
