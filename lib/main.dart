import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true
      ),
      home:  Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,

          title: const Text("Todo App", style: TextStyle(color: Colors.white)),
        ),
        body: const
           LoginPage(),
        
      ),
    );
  }
}

class LoginPage extends StatelessWidget{
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
        width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.yellow, Colors.red],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter
        ),
        
      ),
      child: const LoginPageBox()
    );
  }
}


class LoginPageBox extends StatelessWidget{
  const LoginPageBox({super.key});

  @override
  Widget build(BuildContext context) {
    return       Container(
      decoration:  BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.blue, Colors.green],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter
        ),
        borderRadius: BorderRadius.circular(20.0)
      ),
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.all(35.0),

      child: const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
       Text("Logi666fdsn123"),
        Text("Enter email"),
        Text("Enter passwordfdsfdsfsd")
      ]

    ));
  }
}