import 'package:flutter/material.dart';
import 'package:flutter_todo_app/api/api_methods/register_user_api.dart';
import 'package:flutter_todo_app/api/shared_preferences_config.dart';
import 'package:flutter_todo_app/db/initial_db_values.dart';
import 'package:flutter_todo_app/login/email_text_input.dart';
import 'package:flutter_todo_app/login/login_button.dart';
import 'package:flutter_todo_app/login/login_header.dart';
import 'package:flutter_todo_app/login/login_page.dart';
import 'package:flutter_todo_app/login/name_input.dart';
import 'package:flutter_todo_app/login/page_navigation.dart';
import 'package:flutter_todo_app/login/password_confirm_password.dart';
import 'package:flutter_todo_app/models/user.dart';
import 'package:flutter_todo_app/services/user_service.dart';
import 'package:flutter_todo_app/state_mgmt/auth_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  String registerError = '';

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

  void handleRegister (AuthModel authModel) async{
    User user = await registerUserApi(email: email, password: password, firstName: firstname, lastName: lastname);
    if (user.token == "" ){
          setState((){
      registerError = "Error occured: ${user.statusMessage}";
    });
    }
    else{
      print("Start of creating user");
      await SharedPreferencesConfig().addUserSharedPrefs(user);

      await InitialDbValues.addDataToAPI();
      authModel.setIsUserLoggedIn(true);
      Navigator.pop(context);
    }
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
      Consumer<AuthModel>(
        builder:(context, authModel, child){
          return LoginButton(label: "Register", 
          onPressed:() =>  handleRegister(authModel));
        }
      ),
      
      Text(registerError, style: const TextStyle(color: Colors.red),),
      const PageNavigation(title: "Have account? Login instead", targetPage: LoginPage(),)
 
      ]
      ));


  }

}