import 'package:flutter/material.dart';
import 'package:flutter_todo_app/login/login_page.dart';
import 'package:flutter_todo_app/login/page_navigation.dart';

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
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20.0)
      ),
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.all(35.0),

      child: const Column(
      children:  <Widget>[
       Text("In register page"),
      PageNavigation(title: "Have account? Login instead", targetPage: LoginPage(),)
 
      ]
      ));


  }

}