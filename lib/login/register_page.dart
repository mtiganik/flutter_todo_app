import 'package:flutter/material.dart';
import 'package:flutter_todo_app/login/login_page.dart';

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
      
      Center(
        child: Column(
      children:  <Widget>[
      const Text("In register page"),

      InkWell(
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const LoginPage()
            ));
        },child: const Text(
          "Have account? Login instead", 
          style: TextStyle(
            color: Colors.blue,
            decoration: TextDecoration.underline
          )
        )
      )
      ]
      )));
  }

}