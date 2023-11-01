import 'dart:convert';

import 'package:flutter_todo_app/api/api_config.dart';
// import 'package:flutter_todo_app/models/login.dart';
import 'package:flutter_todo_app/models/user.dart';
import 'package:http/http.dart' as http;



 Future<User> registerUserApi({required String email, required String password,required String firstName,required String lastName}) async {
   Map<String, String> headers = {"Content-type": "application/json"};

final url = Uri.parse('${APIConfig.getUrl()}Account/Register');
  final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode( {
    'email' : email,
    'password' : password,
    'firstName' : firstName,
    'lastName' : lastName,
  }
),
      );

  if (response.statusCode == 200) {
    User user = User.fromJson(json.decode(response.body), response.statusCode, "User registration succesfull");
  return user;
  } else {

  Map<String, dynamic> responseBody = json.decode(response.body);

  String statusMessage = "";
  if (responseBody.containsKey("messages") && responseBody["messages"].isNotEmpty) {
    statusMessage = responseBody["messages"][0];
  }
  return User(token: "", refreshToken: "", statusCode: response.statusCode, statusMessage: statusMessage);

}
 }