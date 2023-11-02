

import 'package:flutter/material.dart';
import 'package:flutter_todo_app/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthModel extends ChangeNotifier{
  bool _isUserLoggedIn = false;
  bool _isInitialized = false;

  AuthModel(){
    init();
  }

  Future<void> init() async{
    // var user = await UserService.getUser();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getString("token") == null) {
      _isUserLoggedIn = false;
    } else {
      _isUserLoggedIn = true;
    }
    _isInitialized = true;
    notifyListeners();
  }

  bool isUserLoggedIn(){
    return _isUserLoggedIn;
  }

  bool isInitilized(){
    return _isInitialized;
  }

  setIsUserLoggedIn(bool status){
    _isUserLoggedIn = status;
    notifyListeners();
  }
}