

import 'package:flutter/material.dart';

class CategoriesHome extends StatelessWidget{
  const CategoriesHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories", style: TextStyle(color:Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: Text("From CategoriesHome"),
    );

  }

}