import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_todo_app/api/api_config.dart';
import 'package:flutter_todo_app/api/shared_preferences_config.dart';
import 'package:flutter_todo_app/models/user.dart';
import 'package:flutter_todo_app/state_mgmt/auth_model.dart';
import 'package:http/http.dart' as http;

class LogoutHandle extends StatefulWidget {
  const LogoutHandle({super.key});

  @override
  State<StatefulWidget> createState() => _LogoutHandleState();

  Future<void> handle401Status(int statusCode) async{
    final state = _LogoutHandleState();
    await state.if401HandleRefreshToken(statusCode);

  }
}

class _LogoutHandleState extends State<LogoutHandle> {
  Future<void> if401HandleRefreshToken(int statusCode) async {
    if (statusCode != 401) {
      return;
    } else {
      print("401 status occured");
      User user = await SharedPreferencesConfig().getUserFromSharedPrefs();
      if (user.token == "" || user.refreshToken == "") {
        // TODO: log user out
        await SharedPreferencesConfig().removeSharedPrefs();
        AuthModel().setIsUserLoggedIn(false);
        // Navigator.of(context).pushReplacementNamed('/login');;
        // TODO: navigate to loginScreen
      } else {
        // var requestBody = jsonEncode(user.toJson());

        //"https://taltech.akaver.com/api/v1/Account/RefreshToken"
        var url = "${APIConfig.getUrl()}Account/RefreshToken"; 


        final response = await http.post(Uri.parse(url), headers: {"Content-Type": "text/json"},
        body: jsonEncode({
          'jwt':user.token,
          'refreshToken': user.refreshToken
        }));

        if (response.statusCode == 200) {
          // update prefs
          user = User.fromJson(json.decode(response.body), 200, "Updated user");
          await SharedPreferencesConfig().addUserSharedPrefs(user);

          // TODO: refresh page
        } else {

          Map<String, dynamic> responseBody = json.decode(response.body);
          print("Couldnt update token: ${responseBody.toString()} ");
          await SharedPreferencesConfig().removeSharedPrefs();
          AuthModel().setIsUserLoggedIn(false);


          // TODO: log user out
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
