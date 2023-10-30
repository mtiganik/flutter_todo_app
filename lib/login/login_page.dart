
import 'dart:convert';

import 'package:flutter_todo_app/login/login_button.dart';
import 'package:flutter_todo_app/login/login_header.dart';
import 'package:flutter_todo_app/login/page_navigation.dart';
import 'package:flutter_todo_app/login/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/login/email_text_input.dart';
import 'package:flutter_todo_app/login/password_text_input.dart';
import 'package:flutter_todo_app/models/user.dart';
import 'package:flutter_todo_app/state_mgmt/auth_model.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget{
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,

          title: const Text("Login", style: TextStyle(color: Colors.white)),
        ),
        body: 
        
        SingleChildScrollView(
          child:

        Container(
        // width: double.infinity,
        // height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.red, Colors.white],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter
        ),
        
      ),
      child: 
       const LoginPageBox()
    )));
  }
}


class LoginPageBox extends StatefulWidget{
  const LoginPageBox({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPageBoxState();
}

class _LoginPageBoxState extends State<LoginPageBox>{
  String email = '';
  String password = '';
void handleEmailChanged(String newEmail){
  setState(() {
    email = newEmail;
  });
}
void handlePasswordChange(String newPassword){
  setState(() {
    password = newPassword;
  });
}

void handleLoginPressed (AuthModel model)async{
  // AuthModel authmodel = new ;
  // Provider.of<AuthModel>(context, listen: false);

  model.setIsUserLoggedIn(true);
  //User user = await loginUser(email = "aaa@bbb.eeq", password="q1w2E+");
  print("Pressed login");
  // print(user.token);
}

  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration:  BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20.0),
      ),
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.all(35.0),

      child:  
      
      Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
       const LoginHeader(title: "Login",),
       EmailTextInput(labelText: "Email", onEmailChanged: handleEmailChanged),
       PasswordTextInput(labelText: "Password", onPasswordChanged: handlePasswordChange),
       Consumer<AuthModel>(
        builder:(context, authModel, child){
          return LoginButton(label: "Login", onPressed: () => handleLoginPressed(authModel));
        }
       ),
       

        Text("Enter entered: $email"),
        const PageNavigation(title: "Register new account", targetPage: RegisterPage())
      ]
    ));
  }
}



Future<User> loginUser(String email, String password) async {
  final url = Uri.parse("https://taltech.akaver.com/api/v1/Account/Login");
  
  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      "email": email,
      "password": password,
    }),
  );

  if (response.statusCode == 200) {
    // Request was successful
    // final responseData = jsonDecode(response.body);
    // print("Login successful: $responseData");
    var user = User.fromJson(json.decode(response.body), response.statusCode, "Login successful");
    return user;
  } else {
    // Request failed
    print("Login failed: ${response.reasonPhrase}");
    throw Exception('Failed to login');
  }
}






