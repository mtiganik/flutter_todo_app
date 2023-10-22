
import 'package:flutter_todo_app/login/register_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/login/email_text_input.dart';
import 'package:flutter_todo_app/login/password_text_input.dart';

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

void handleLoginPressed(){
  print("$email $password");
}

  @override
  Widget build(BuildContext context) {
    return       
           

          

    Container(
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
        ElevatedButton(onPressed: handleLoginPressed, 
        child: const Text("Login")),
        Text("Enter entered: $email"),
        InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const RegisterPage(),
              ));
          },
          child: const Text(
            "Dont have account? Register here",
            style: TextStyle(
              color: Colors.blue,
              decoration: TextDecoration.underline
            )
          )
        )
      ]
    ));
  }
}

class LoginHeader extends StatelessWidget{
  const LoginHeader({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(title, style: GoogleFonts.kalam(
        textStyle: const TextStyle(
        height: 2,
        fontSize: 30,
        )
       ));

  }

}