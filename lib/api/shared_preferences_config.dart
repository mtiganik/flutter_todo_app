

import 'package:flutter_todo_app/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesSettings {

  Future<void> addUserSharedPrefs(User user) async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', user.token);
      prefs.setString('refreshToken', user.refreshToken);
      prefs.setString('firstName', user.firstName ?? "");
      prefs.setString('lastName', user.lastName ?? "");
  }

  Future<void> removeSharedPrefs()async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('token');
      prefs.remove('refreshToken');
      prefs.remove('firstName');
      prefs.remove('lastName');
  }
}