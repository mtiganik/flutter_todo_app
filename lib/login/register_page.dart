import 'package:flutter/material.dart';
import 'package:flutter_todo_app/login/email_text_input.dart';
import 'package:flutter_todo_app/login/login_header.dart';
import 'package:flutter_todo_app/login/login_page.dart';
import 'package:flutter_todo_app/login/name_input.dart';
import 'package:flutter_todo_app/login/page_navigation.dart';
import 'package:flutter_todo_app/login/password_confirm_password.dart';

class RegisterPage extends StatelessWidget{
  const RegisterPage({super.key});



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Register", style: TextStyle(color: Colors.white),),
      ),
      body: 
      
      SingleChildScrollView(
        
        child: Container(
          width: double.infinity,

          decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.red, Colors.white],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter
        ),
      ),

        
        child: const RegisterPageBox()
      
      )));
  }
}

class RegisterPageBox extends StatefulWidget{
  const RegisterPageBox({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterPageBoxState();
  
}

class _RegisterPageBoxState extends State<RegisterPageBox>{
  String firstname = '';
  String lastname = '';
  String email = '';
  String password = '';
  String confirmPassword = '';

  void handleFirstnameChanged(String newFirstname){
    setState((){
      firstname = newFirstname;
    });
  }

  void handleLastnameChanged(String newLastname){
    setState((){
      lastname = newLastname;
    });
  }

  void handleEmailChanged(String newEmail){
    setState((){
      email = newEmail;
    });
  }

  void handlePassWordChanged(String newPassword){
    setState(() {
      password = newPassword;
    });
  }

  void handleConfirmPasswordChanged(String newConfirmPassword){
    setState(() {
      confirmPassword = newConfirmPassword;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20.0)
      ),
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.all(35.0),

      child: Column(
      children:  <Widget>[
      const LoginHeader(title: "Register"),
      NameInput(label: "First Name", onInputChanged: handleFirstnameChanged),
      NameInput(label: "Last Name", onInputChanged: handleLastnameChanged),
      EmailTextInput(labelText: "Email", onEmailChanged: handleEmailChanged),
      PasswordConfirmPassword(labelText: "Password", onPasswordChanged: handlePassWordChanged,onConfirmPasswordChanged: handleConfirmPasswordChanged),

      const PageNavigation(title: "Have account? Login instead", targetPage: LoginPage(),)
 
      ]
      ));


  }

}