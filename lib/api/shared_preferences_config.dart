

import 'package:flutter_todo_app/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesConfig {

  Future<void> addUserSharedPrefs(User user) async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', user.token);
      prefs.setString('refreshToken', user.refreshToken);
      prefs.setString('firstName', user.firstName ?? "");
      prefs.setString('lastName', user.lastName ?? "");
  }

  Future<User> getUserFromSharedPrefs() async{
    SharedPreferences prefs= await SharedPreferences.getInstance();
    return User(
      token: prefs.getString("token") ?? "",
      refreshToken: prefs.getString("refreshToken") ?? "",
    );
  }

  Future<void> removeSharedPrefs()async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('token');
      prefs.remove('refreshToken');
      prefs.remove('firstName');
      prefs.remove('lastName');
  }
}