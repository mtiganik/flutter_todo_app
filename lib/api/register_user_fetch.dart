import 'dart:convert';

import 'package:flutter_todo_app/api/api_config.dart';
import 'package:flutter_todo_app/models/login.dart';
import 'package:flutter_todo_app/models/user.dart';
import 'package:http/http.dart' as http;

Future<User> RegisterUserFetch(Login login) async {
   Map<String, String> headers = {"Content-type": "application/json"};

final url = Uri.parse('${APIConfig.getUrl()}Account/Register');
// const x = const login.toJson();
print(login.toJson());
  final response = await http.post(
      url,
      headers: headers,
      // body: '{"email": "${login.email}", "password": "${login.password}", "firstName": "${login.firstName}", "lastName": "${login.lastName}"}'
      // body: '{"email": ${login.email}, "password": ${login.password}, "firstName": ${login.firstName}, "lastName": ${login.lastName}}'

      body: jsonEncode(login.toJson()),

      // '{"email": "${login.email}", "password": "${login.password}", "firstName": "${login.firstName}", "lastName": "${login.lastName}"}'
      );

  if (response.statusCode == 200) {
    return User.fromJson(json.decode(response.body));
  } else {
    return User(token: "", status: response.reasonPhrase);
  }
}
