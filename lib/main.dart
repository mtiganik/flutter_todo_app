import 'package:flutter/material.dart';
import 'package:flutter_todo_app/login/login_page.dart';

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

